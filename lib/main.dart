import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'Screen-login/LoginPage.dart';
import 'root_app.dart';
import 'package:karaoke_real_one/pages/forListening/test_songlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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

  Future loaduser(String userUID) async {
    List tempData = await showListSong().loaduser(userUID);
    setState(() {
      userData = tempData;
    });
  }

  Future loadRanking() async {
    List tempData = await showListSong().loadranking();
    setState(() {
      usersRanking = tempData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 0, 255, 8),
            dividerColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: Home(),
    );
  }

  Widget Home() {
    final user = FirebaseAuth.instance.currentUser;
    final nextroute;
    if(user != null ){
      loaduser(user.uid);
      loadRanking();
      if(!userData.isEmpty && !usersRanking.isEmpty){
        nextroute =  RootApp(userData: userData, rankingData: usersRanking);
      } else { 
        nextroute = LoginPage(); 
      }
    }else{
      nextroute = LoginPage();
    }
    return nextroute;
  }
}
