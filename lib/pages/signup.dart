import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconfarm/pages/homepageview.dart';
import 'package:iconfarm/pages/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iconfarm/services/firebase_auth.dart';
import 'package:iconfarm/utils/userprofile.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

FirebaseUser user;
File _image;
String _uploadedFileURL = "null";

List<String> _signupType = ['Farmer', 'Buyer']; // Option 2
String _selectedSignType; // Option 2

class _SignupState extends State<Signup> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameontroller = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController residenceController = new TextEditingController();
  TextEditingController occupationController = new TextEditingController();
  TextEditingController signuptypeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset("assets/book.png",
                  color: Colors.green, fit: BoxFit.cover),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(0.8)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      chooseFile();
                    },
                    child: Container(
                        padding: EdgeInsets.all(60),
                        child: _uploadedFileURL == "null"
                            ? CircleAvatar(
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 60,
                                ),
                                radius: 60,
                                backgroundColor: Colors.green,
                              )
                            : CachedNetworkImage(
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                imageUrl: _uploadedFileURL)),
                  ),
                  Text("Tap on icon to select profile image"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: usernameontroller,
                            decoration: InputDecoration(
                                hintText: "Full Name",
                                prefixIcon: Icon(Icons.account_circle),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: numberController,
                            decoration: InputDecoration(
                                hintText: "Number",
                                prefixIcon: Icon(Icons.phone),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: residenceController,
                            decoration: InputDecoration(
                                hintText: "Residence",
                                prefixIcon: Icon(Icons.home),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Icons.email),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.keyboard),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          // child: TextField(
                          //   controller: signuptypeController,
                          //   decoration: InputDecoration(
                          //       hintText: "Signup type: Student or Teacher",
                          //       prefixIcon: Icon(Icons.accessibility),
                          //       border: InputBorder.none),
                          // ),

                          child: DropdownButton(
                            hint: Text(
                                'Signup type'), // Not necessary for Option 1
                            value: _selectedSignType,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedSignType = newValue;
                              });
                            },
                            items: _signupType.map((signupType) {
                              return DropdownMenuItem(
                                child: new Text(signupType),
                                value: signupType,
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 15),
                        FlatButton(
                          padding: EdgeInsets.all(15),
                          color: Colors.black,
                          onPressed: () {
                            Auth _auth = new Auth();
                            _auth
                                .signUp(
                                    emailController.text.toLowerCase().trim(),
                                    passwordController.text)
                                .then((onValue) async {
                              user = await FirebaseAuth.instance.currentUser();
                              print(user.uid);

                              print('Hello ' + user.displayName.toString());
                              var name = user.displayName;
                              var photo = user.photoUrl;
                              print(user);
                              print(name);
                              print(photo);

                              //Uploading information to firestore
                              Firestore.instance
                                  .collection('users')
                                  .document(user.uid)
                                  .updateData({
                                    "userid": user.uid,
                                    "email": emailController.text,
                                    "name": usernameontroller.text,
                                    "phone": numberController.text,
                                    "residence": residenceController.text,
                                    "type": _selectedSignType
                                  })
                                  .then((result) => {
                                        saveUserInfo(
                                            usernameontroller.text,
                                            emailController.text,
                                            residenceController.text,
                                            numberController.text,
                                            signuptypeController.text),
                                        uploadFile(),
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomePageView()))
                                      })
                                  .catchError((err) => print(err));
                            });
                          },
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
        _uploadedFileURL = image.toString();
      });
    });
  }

  Future uploadFile() async {
    user = await FirebaseAuth.instance.currentUser();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('users/' + user.uid);
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      print(fileURL);
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });

    Firestore.instance
        .collection('users')
        .document(user.uid)
        .updateData({
          "photo": _uploadedFileURL,
        })
        .then((result) async => {await savePhotoUrl(_uploadedFileURL)})
        .catchError((err) => print(err));
  }

  Future<void> saveUserInfo(String name, String email, String residence,
      String number, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', name);
    await prefs.setString('number', number);
    await prefs.setString('residence', residence);
    await prefs.setString('email', email);
    await prefs.setString('type', type);
  }

  savePhotoUrl(String photourl) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('photourl', photourl);
  }
}
