import 'package:firebase_database/firebase_database.dart';

class fb_connect {

  Future loadSong(List listsong, String songname) async {
    List listsong = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("userSongs").orderByChild("title").equalTo(songname).get();
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
    final snapshot = await ref.child("userSongs").orderByChild("userName").equalTo(userName).get();
    if(snapshot.exists){
      for(final key in snapshot.children){
        listSong.add(key.value);
      }
    }
    Future.delayed(const Duration(seconds: 1), () => "1");
    return listSong;
  }

  Future getSongList() async {
    List songList = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("appSongs/songs").orderByKey().get();
    if(snapshot.exists){
      for(final key in snapshot.children){
        songList.add(key.value);
      }
    }
    Future.delayed(const Duration(seconds: 1), () => "1");
    return songList;
  }

  Future getSongLyrics(int index) async {
    String Lyrics = "";
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("allLyrics/"+index.toString()+"/lyrics").orderByKey().get();
    if(snapshot.exists){
      for(final line in snapshot.children){
        Lyrics = Lyrics + line.value.toString() + '\n';
      }
    }
    Future.delayed(const Duration(seconds: 1), () => "1");
    return Lyrics;
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
