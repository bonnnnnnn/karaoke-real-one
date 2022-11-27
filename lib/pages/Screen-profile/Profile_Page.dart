import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:karaoke_real_one/pages/Screen-profile/profile_widget.dart';
import 'package:karaoke_real_one/pages/Screen-profile/setting_Profile_page.dart';
import 'package:karaoke_real_one/pages/Screen-profile/edit_Profile_page.dart';
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
                  onClicked: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage()),
                    );
                  },
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
                      'data1',
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
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Profile",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingProfilePage();
                }));
              },
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
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 0),
      child: Stack(
        children: [
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
                          color: Colors.black,
                          description: widget.song['description'],
                          img: songAlbums[index]['img'],
                          songUrl: songAlbums[index]['song_url'],
                        ),
                        type: PageTransitionType.scale
                      )
                    );
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
            })
          )
        ],
      )          
    );
  }
}