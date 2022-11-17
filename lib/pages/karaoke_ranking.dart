import 'package:flutter/material.dart';

class KaraokeRanking extends StatefulWidget {
  final List usersRanking;

  const KaraokeRanking({Key? key,
  required this.usersRanking})
  : super(key: key);

  @override
  State<KaraokeRanking> createState() => _KaraokeRankingState();
}

class _KaraokeRankingState extends State<KaraokeRanking> {

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
            Icon(Icons.list)
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
              children: List.generate(widget.usersRanking.length, (index) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                child: GestureDetector(
                  child: Row(
                    children: [
                      Container(
                        width: (size.width - 60) * 0.77,
                        child: Text(
                          "${index + 1}  " + widget.usersRanking[index]['userName'],
                          style: TextStyle(color: Colors.white),
                        ),
                       ),
                      Container(
                        width: (size.width - 60) * 0.23,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Scores",
                              style: TextStyle(color: Colors.grey, fontSize: 14),
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
                                color: Colors.white,
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