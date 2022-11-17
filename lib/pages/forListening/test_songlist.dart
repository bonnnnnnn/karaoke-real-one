import 'package:firebase_database/firebase_database.dart';

class showListSong {

  Future loadsong(List listsong, String songname) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("Songs/"+songname).orderByKey().get();
    if (snapshot.exists) {
      for(final key in snapshot.children){
        listsong.add(key.value);
      }
    }
    Future.delayed(const Duration(seconds: 1), () => "1");
    return listsong;
  }

  Future loaduser(String userUID) async {
    List userData = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("Users/"+userUID).get();
    if (snapshot.exists) {
      userData.add(snapshot.value);
    }
    Future.delayed(const Duration(seconds: 1), () => "1");
    return userData;
  }

  Future loadranking() async {
    List usersranking = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child("Users").orderByChild("userAge").get();
    if (snapshot.exists) {
      for(final key in snapshot.children){
        usersranking.add(key.value);
      }
    }
    Future.delayed(const Duration(seconds: 1), () => "1");
    return usersranking;
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
