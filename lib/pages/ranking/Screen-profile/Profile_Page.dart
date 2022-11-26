import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'profile_widget.dart';
import 'package:karaoke_real_one/pages/home/listen_and_record/music_detail_page.dart';

class ProfilePage extends StatefulWidget {
  final List userData;

  const ProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: getAppBar(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              children: [
                SizedBox(height: 120),
                ProfileWidget(
                  imagePath: widget.userData[0]['img'],
                  onClicked: () {},
                ),
                SizedBox(height: 40),
                Text(
                  widget.userData[0]['userName'],
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                SizedBox(height: 5),
                Text(
                  widget.userData[0]['userEmail'],
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
                SizedBox(height: 25),
                buildNumber(),
                SizedBox(height: 25),
                tabBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tabBar() {
    return Container(
      child: Column(
        children: [
          Container(
            child: TabBar(
              indicatorColor: Colors.green,
              isScrollable: true,
              tabs: [
                Tab(text: 'Last Singing'),
                Tab(text: 'Most Score'),
              ],
            ),
          ),
          SizedBox(
            height: 300,
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "data 1",
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'data2',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.0),
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "View Profile",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildButton(
            context, widget.userData[0]['songs_count'].toString(), 'Singing'),
        buildDivider(),
        buildButton(context, widget.userData[0]['stars'].toString(), 'Stars'),
      ],
    );
  }

  Widget buildDivider() => Container(
        height: 26,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 4),
          onPressed: () {},
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              SizedBox(height: 2),
              Text(
                text,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ));

  Widget getList() {
    List userSongs = widget.userData[0]['songs'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Text("USER LIST SONG"),
          Row(
            children: List.generate(userSongs.length, (index) {
              return Padding(
                padding: EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            child: MusicDetailPage(
                              title: userSongs[index]['title'],
                              description: "",
                              color: Colors.black,
                              img: userSongs[index]['img'],
                              songUrl: userSongs[index]['song_url'],
                            ),
                            type: PageTransitionType.scale));
                  },
                  child: Column(children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(userSongs[index]['img']),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      userSongs[index]['title'],
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        "",
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ]),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}