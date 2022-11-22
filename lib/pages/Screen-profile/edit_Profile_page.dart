import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:karaoke_real_one/pages/Screen-Profile/profile_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  PlatformFile? pickedFile;

  final _userNameController = TextEditingController();
  final _userImageController = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void dispose() {
    _userNameController.dispose();
    _userImageController.dispose();
    super.dispose();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('EditProfile'),
          leading: BackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 100),
                if (pickedFile == null)
                  Container(
                    child: noImage(),
                  ),
                if (pickedFile != null)
                  Container(
                    child: Stack(
                      children: [
                        haveImage(),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: buildEditIcon(Colors.black),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 40),
                buildUsername(),
                SizedBox(height: 50),
                selectFileBtn(),
                SizedBox(height: 10),
                uploadFileBtn(),
                SizedBox(height: 100),
                bulidUpdateBtn(),
              ],
            ),
          ),
        ),
      );

  Widget noImage() {
    return ProfileWidget(
      imagePath:
          'https://i.pinimg.com/280x280_RS/2e/45/66/2e4566fd829bcf9eb11ccdb5f252b02f.jpg',
      isEdit: true,
      onClicked: selectFile,
    );
  }

  Widget haveImage() {
    final image = File(pickedFile!.path!);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Image.file(
          File(pickedFile!.path!),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }

  Widget selectFileBtn() {
    return ElevatedButton(
      child: Text('Select Image'),
      onPressed: selectFile,
    );
  }

  Widget uploadFileBtn() {
    return ElevatedButton(
      child: Text('Upload Image'),
      onPressed: (){},
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.black,
        all: 3,
        child: buildCircle(
          color: Color.fromARGB(255, 0, 255, 8),
          all: 8,
          child: Icon(
            Icons.add_a_photo,
            color: Colors.black,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Widget buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: TextStyle(
              color: Colors.white60, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 50,
            child: TextField(
              controller: _userNameController,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.person, color: Color(0xff999999)),
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.black38)),
            )),
      ],
    );
  }

  Widget bulidUpdateBtn() {
    return ElevatedButton(
      child: Text('UPDATE'),
      onPressed: () {},
    );
  }
}