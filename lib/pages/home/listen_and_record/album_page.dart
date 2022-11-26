import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:karaoke_real_one/pages/home/listen_and_record/music_detail_page.dart';
import 'package:karaoke_real_one/pages/home/listen_and_record/karaoke_singing.dart';

class AlbumPage extends StatefulWidget {
  final dynamic song;
  final List userData;
  final int index;

  const AlbumPage(
      {Key? key,
      required this.song,
      required this.userData,
      required this.index})
      : super(key: key);
  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getFooter() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(5)),
      child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Color.fromARGB(255, 13, 161, 33),
                    Color.fromARGB(255, 25, 210, 102),
                    Color.fromARGB(255, 66, 245, 141),
                  ])),
                )),
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.only(left: 140, right: 140, bottom: 1),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          const Text(
                          'SINGING NOW',
                        )
                      ],
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            child: Singing(
                              img: widget.song['img'],
                              song_url: widget.song['intruments'],
                              songname: widget.song['title'],
                              userData: widget.userData,
                              index: widget.index,
                            ),
                            type: PageTransitionType.scale),
                      );
                    })
              ],
            ),
          )),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    List songAlbums = widget.song['songs'];
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width,
                height: 220,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.song['img']),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.song['title'],
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 255, 8))),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: List.generate(1, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    alignment: Alignment.bottomCenter,
                                    child: MusicDetailPage(
                                      title: widget.song['title'],
                                      color: widget.song['color'],
                                      description: widget.song['description'],
                                      img: widget.song['img'],
                                      songUrl: widget.song['song_url'],
                                    ),
                                    type: PageTransitionType.scale));
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(widget.song['img']),
                                        fit: BoxFit.cover),
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                widget.song['title'],
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: size.width - 210,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: (size.width - 60) * 0.70,
                          child: Text(
                            "#  " +
                            "Name",
                          style: TextStyle(
                          color: Colors.yellow.withOpacity(0.8), fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: (size.width - 60) * 0.30,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Total Stars",
                                style: TextStyle(
                                  color: Colors.yellow.withOpacity(0.8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ),
              Column(
                  children: List.generate(songAlbums.length, (index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              alignment: Alignment.bottomCenter,
                              child: MusicDetailPage(
                                title: songAlbums[index]['title'],
                                color: widget.song['color'],
                                description: widget.song['description'],
                                img: songAlbums[index]['img'],
                                songUrl: songAlbums[index]['song_url'],
                              ),
                              type: PageTransitionType.scale));
                    },
                    child: Row(
                      children: [
                        Container(
                          width: (size.width - 60) * 0.77,
                          child: Text(
                            "${index + 1}  " +
                                songAlbums[index]['title'] +
                                " - " +
                                songAlbums[index]['userName'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          width: (size.width - 60) * 0.23,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: List.generate(songAlbums[index]['stars'], (index){
                              return Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orange.shade400,
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  )
                              );
                            })
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }))
            ],
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
