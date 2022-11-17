import 'package:flutter/material.dart';
import '/Screen-Profile/profile_widget.dart';
import '/Screen-profile/setting_Profile_page.dart';
import 'edit_Profile_page.dart';

class ProfilePage extends StatefulWidget {
  final List userData;

  const ProfilePage({Key? key, 
  required this.userData}) 
  :super (key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(height: 100),
              ProfileWidget(
                imagePath:
                    'https://upload.wikimedia.org/wikipedia/th/thumb/5/5d/Your_Name_poster.jpg/640px-Your_Name_poster.jpg',
                onClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
              ),
              SizedBox(height: 30),
              Text(
                widget.userData[0]['userName'],
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              SizedBox(height: 5),
              Text(
                widget.userData[0]['userEmail'],
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              SizedBox(height: 15),
              buildNumber(),
              SizedBox(height: 20),
              buildAbout(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Profile",
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
  Widget buildAbout() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            'KMUTNB',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildButton(context, '19', 'Singing'),
        buildDivider(),
        buildButton(context, '2.5', 'Rating'),
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
}
