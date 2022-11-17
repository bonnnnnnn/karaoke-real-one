import 'package:flutter/material.dart';
import 'package:karaoke_real_one/pages/karaoke_home.dart';
import 'package:karaoke_real_one/pages/karaoke_ranking.dart';
import 'Screen-profile/Profile_Page.dart';

class RootApp extends StatefulWidget {
  final List userData;
  final List rankingData;

  RootApp({Key? key,
  required this.userData,
  required this.rankingData})
  :super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: [
        HomePage(),
        KaraokeRanking(usersRanking: widget.rankingData),
        ProfilePage(userData: widget.userData)
      ],
    );
  }

  Widget getFooter() {
    List items = [
      Icons.home,
      Icons.emoji_events_rounded,
      Icons.supervisor_account_sharp
    ];
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
            List.generate(items.length, (index) {
              return IconButton(
                icon: Icon(
                  items[index],
                  color: activeTab == index ? Colors.green :Colors.white,
                ),
                onPressed: (){
                  setState(() {
                    activeTab = index;
                  });
                }
              );
            })
        ),
      ),
    );
  }
}