import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:karaoke_real_one/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_real_one/Screen-login/LoginPage.dart';
import 'package:karaoke_real_one/root_app.dart';
import 'package:karaoke_real_one/fb_connect.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _HomePage();
}

class _HomePage extends State<MyApp> {
  List userData = [];
  List usersRanking = [];
  List userSongs = [];

  Future loaduser(String userUID) async {
    List tempData = await fb_connect().loadUser(userUID);
    setState(() {
      userData = tempData;
    });
  }

  Future loadRanking() async {
    List tempData = await fb_connect().loadRanking();
    setState(() {
      usersRanking = tempData;
    });
  }

  Future fetchingSongList(String userName) async {
    List tempData = await fb_connect().fetchingSongList(userName);
    setState(() {
      userSongs = tempData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.black, dividerColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }

  Widget Home() {
    final user = FirebaseAuth.instance.currentUser;
    final nextroute;
    if (user != null) {
      loaduser(user.uid);
      if (!userData.isEmpty) {
        fetchingSongList(userData[0]['userName']);
        userData[0]['songs'] = userSongs;
        if (!userSongs.isEmpty && userData[0]['songs_count'] > 0) {
          nextroute = RootApp(userData: userData, rankingData: usersRanking);
        } else if (userSongs.isEmpty && userData[0]['songs_count'] == 0) {
          userData[0]['songs'] = [];
          nextroute = RootApp(userData: userData, rankingData: usersRanking);
        } else {
          nextroute = MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.black, dividerColor: Colors.white),
            debugShowCheckedModeBanner: false,
          );
        }
      } else {
        nextroute = loadScreen();
      }
    } else {
      nextroute = LoginPage();
    }
    return nextroute;
  }

  Widget loadScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Color.fromARGB(255, 0, 255, 8),
          size: 200,
        ),
      ),
    );
  }
}
