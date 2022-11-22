import 'dart:ui';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:karaoke_real_one/pages/home/listen_and_record/karaoke_seekbar.dart';
import 'package:flutter/foundation.dart';
import 'package:record/record.dart'; 
import 'package:karaoke_real_one/pages/home/listen_and_record/flask_connect.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:karaoke_real_one/pages/home/listen_and_record/const.dart';

flask_connect flask = new flask_connect();

class Singing extends StatefulWidget {
  final String song_url;
  final String img;
  final String songname;
  final List userData;
  final int index;

  const Singing({
    Key? key,
    required this.song_url,
    required this.img,
    required this.songname,
    required this.userData,
    required this.index
  }) : super(key: key);

  @override
  _SingingState createState() => _SingingState();
}

class _SingingState extends State<Singing> with SingleTickerProviderStateMixin {
  AudioPlayer? audioPlayer = AudioPlayer();
  int playProgress = 0;
  double max_value = 211658;
  bool isTap = false;

  String? audioPath;

  int _recordDuration = 0;
  Timer? _timer;
  final _audioRecorder = Record();
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;

  @override
  void initState() {
    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => setState(() => _amplitude = amp));

    lyricModel = LyricsModelBuilder.create()
      .bindLyricToMain(normalLyric[widget.index])
      // .bindLyricToExt(transLyric)
      .getModel();

    super.initState();
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }

        // final devs = await _audioRecorder.listInputDevices();
        // final isRecording = await _audioRecorder.isRecording();

        await _audioRecorder.start();
        _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _stop(bool complete) async {
    _timer?.cancel();
    _recordDuration = 0;

    final path = await _audioRecorder.stop();

    if (complete) {
      flask.upload(path.toString(), widget.index.toString(), widget.userData[0]['userName'], widget.songname);
    }

    print(path.toString());
    print(widget.index.toString());
    print(widget.userData[0]['userName']);
    print( widget.songname);

  }

  Future<void> _pause() async {
    _timer?.cancel();
    await _audioRecorder.pause();
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();
  }
    String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0' + numberStr;
    }

    return numberStr;
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  bool useEnhancedLrc = false;
  var lyricModel;
  var lyricUI = UINetease(defaultSize: 30,lineGap: 30,highlight: false);

  Stream<SeekBarData> get _seekBarDataSteam =>
  rxdart.Rx.combineLatest2<Duration, Duration, SeekBarData>(
    audioPlayer!.onPositionChanged,
    audioPlayer!.onDurationChanged,
    (Duration position, Duration? duration,){
      return SeekBarData(
        position, 
        duration ?? Duration.zero
      );
    }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      extendBodyBehindAppBar: true,
      body: buildBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black.withOpacity(0.2),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
          audioPlayer?.stop();
          audioPlayer = AudioPlayer();
          setState(() {
            isPlaying = false;
            firstTimePlay = true;
            _stop(false);
          });
        },),
      title: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "NOW SINGING" ,
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.music_note),
          ],
        ),
      ),
    );
  }

  bool isPlaying = false;
  bool firstTimePlay = true;

  Widget buildBody(){
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          widget.img,
          fit: BoxFit.cover,
        ),
        ShaderMask(
          shaderCallback: (rect){
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.5),
                Colors.white.withOpacity(0.0),
              ],
              stops: const [
                0.0,
                0.4,
                0.6
              ]
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black,
                ]
              )
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        buildReaderWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<SeekBarData>(
                stream: _seekBarDataSteam,
                builder: 
                (context, snapshot){
                  final positionData = snapshot.data;
                  return SeekBar(
                    position: positionData?.position ?? Duration.zero, 
                    duration: positionData?.duration ?? Duration.zero,
                    onChangedEnd: audioPlayer!.seek,
                  );
                }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CircleAvatar(
                    radius: 29,
                    backgroundColor: Colors.white.withOpacity(0.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 30,),
                      onPressed: () async {
                        if(isPlaying == false || firstTimePlay == true) return;
                        audioPlayer?.pause();
                        setState(() {
                          isPlaying = false;
                          _pause();
                        });
                      },
                    ),
                ),
                Container(
                  width: 10,
                ),
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withOpacity(0.0),
                    child: 
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.0),
                        radius: 29,
                        child: IconButton(
                          icon: Icon(
                          Icons.mic,
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 30,),
                          onPressed: () async {
                            if (isPlaying == false && firstTimePlay == true) {
                                audioPlayer = AudioPlayer()..play(UrlSource(widget.song_url));
                                setState(() {
                                  playing = true;
                                  isPlaying = true;
                                  firstTimePlay = false;
                                  _start();
                                });
                                audioPlayer?.onDurationChanged.listen((Duration event) {
                                  setState(() {
                                    max_value = event.inMilliseconds.toDouble();
                                  });
                                });
                                audioPlayer?.onPositionChanged.listen((Duration event) {
                                  if (isTap) return;
                                  setState(() {
                                    playProgress = event.inMilliseconds;
                                  });
                                });
                                audioPlayer?.onPlayerStateChanged.listen((PlayerState state) {
                                  setState(() {
                                    playing = state == PlayerState.playing;
                                  });
                                });
                                audioPlayer?.onPlayerComplete.listen((event) {
                                  setState(() {
                                    _stop(true);
                                  });
                                });
                              } else {
                                audioPlayer?.resume();
                                setState((){
                                  isPlaying = true;
                                  _resume();
                                });
                              }
                          }),
                        ),
                    ),
                    Container(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 29,
                      backgroundColor: Colors.white.withOpacity(0.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.stop,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () async {
                          if(isPlaying == false || firstTimePlay == true) return;
                          audioPlayer?.stop();
                          audioPlayer = AudioPlayer();
                          setState(() {
                            isPlaying = false;
                            firstTimePlay = true;
                            _stop(true);
                          });
                        }),
                    ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  var lyricPadding = 40.0;

  Stack buildReaderWidget() {
    return Stack(
      children: [
        //...buildReaderBackground(),
        LyricsReader(
          padding: EdgeInsets.symmetric(horizontal: lyricPadding),
          model: lyricModel,
          position: playProgress,
          lyricUi: lyricUI,
          playing: playing,
          size: Size(double.infinity, MediaQuery.of(context).size.height *3/4),
          emptyBuilder: () => Center(
            child: Text(
              "No lyrics",
              style: lyricUI.getOtherMainTextStyle(),
            ),
          ),
        )
      ],
    );
  }

  var playing = false;

}