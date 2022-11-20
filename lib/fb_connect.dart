import 'package:firebase_database/firebase_database.dart';

class fb_connect {

  Future loadSong(List listsong, String songname) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("Songs").orderByChild("title").equalTo(songname).get();
    if (snapshot.exists) {
      for(final key in snapshot.children){
        listsong.add(key.value);
      }
    }
    Future.delayed(const Duration(seconds: 1), () => "1");
    return listsong;
  }

  Future loadUser(String userUID) async {
    List userData = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("Users/"+userUID).get();
    if (snapshot.exists) {
      userData.add(snapshot.value);
    }
    Future.delayed(const Duration(seconds: 1), () => "1");
    return userData;
  }

  Future loadRanking() async {
    List usersranking = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("Users").orderByChild("stars").get();
    if (snapshot.exists) {
      for(final key in snapshot.children){
        usersranking.add(key.value);
      }
    }
    Future.delayed(const Duration(seconds: 1), () => "1");
    return usersranking;
  }

  Future fetchingSongList(String userName) async {
    List listSong = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("Songs").orderByChild("userName").equalTo(userName).get();
    if(snapshot.exists){
      for(final key in snapshot.children){
        listSong.add(key.value);
      }
    }
    Future.delayed(const Duration(seconds: 1), () => "1");
    return listSong;
  }

  void writeData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Instruments/123");
    await ref.set({
      "name": "John",
      "age": 18,
      "address": {
        "line1": "100 Mountain View"
      }
    });
  }
}
