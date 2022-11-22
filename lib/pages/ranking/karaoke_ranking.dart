import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:karaoke_real_one/pages/ranking/Screen-profile/Profile_Page.dart';
import 'package:karaoke_real_one/fb_connect.dart';

class KaraokeRanking extends StatefulWidget {
  final List usersRanking;

  const KaraokeRanking({Key? key,
  required this.usersRanking})
  : super(key: key);

  @override
  State<KaraokeRanking> createState() => _KaraokeRankingState();
}

class _KaraokeRankingState extends State<KaraokeRanking> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ranking",
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            searchIcon(),
          ],
        ),
      ),
    );
  }

  Widget searchIcon() {
    return AnimSearchBar(
      width: 275,
      textController: textController,
      onSuffixTap: () {
        setState(() {
          textController.clear();
        });
      },
      color: Colors.white24,
      helpText: "Search Music",
      autoFocus: true,
      closeSearchOnSuffixTap: true,
      animationDurationInMilli: 600,
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
              children: List.generate( widget.usersRanking.length, (index) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                child: GestureDetector(
                  onTap: () async {
                    List userData = [widget.usersRanking[widget.usersRanking.length-index-1]];
                    List userSongs = await fb_connect().fetchingSongList(userData[0]['userName']);
                    userData[0]['songs'] = userSongs;
                    Navigator.push(
                      context,
                      PageTransition(
                        alignment: Alignment.bottomCenter,
                        child: ProfilePage(userData: userData),
                        type: PageTransitionType.scale
                      )
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: (size.width - 60) * 0.77,
                        child: Text(
                          "${index + 1}  " + widget.usersRanking[widget.usersRanking.length-index-1]['userName'],
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                       ),
                      Container(
                        width: (size.width - 60) * 0.23,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.usersRanking[widget.usersRanking.length-index-1]['stars'].toString(),
                              style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 214, 252, 0),
                                size: 16,
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      )
    );
  }
}