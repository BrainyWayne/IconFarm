import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconfarm/design_course/home_design_course.dart';
import 'package:iconfarm/pages/homepageview.dart';
import 'package:iconfarm/pages/settings.dart';
import 'package:iconfarm/services/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

double bottomLoaderHeight = 0;
bool topSnackVisible = false;
String topBannerText = "";
File _image;
String _uploadedFileURL;
FirebaseUser user;

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {

    FirebaseApp.configure();

    checkLoginStat();


    super.initState();
  }

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
                      color: Colors.green, fit: BoxFit.cover))),
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
                children: <Widget>[
                  
                  Container(
                      padding: EdgeInsets.all(40),
                      child: Image.asset("assets/agronomy.png",
                          fit: BoxFit.cover)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
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
                                  border: InputBorder.none)),
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
                          child: FlatButton(
                            padding: EdgeInsets.all(15),
                            color: Colors.black,
                            onPressed: () {
                              if (emailController.text == "") {
                                setState(() {
                                  topBannerText = "Enter your email";
                                  topSnackVisible = true;
                                  _hideTopBanner();
                                });
                              }
                              if (!emailController.text.contains("@")) {
                                setState(() {
                                  topBannerText = "Enter a valid email";
                                  topSnackVisible = true;
                                  _hideTopBanner();
                                });
                              } else if (passwordController.text == "") {
                                setState(() {
                                  topBannerText = "Enter your password";
                                  topSnackVisible = true;
                                  _hideTopBanner();
                                });
                              } else {
                                setState(() {
                                  bottomLoaderHeight = 70;
                                });
                                Auth _auth = Auth();

                                _auth
                                    .signIn(emailController.text,
                                        passwordController.text)
                                    .then((onValue) async {
                                  user =
                                      await FirebaseAuth.instance.currentUser();
                                  try {
                                    print(user.uid);
                                  } catch (e) {
                                  }

                                  // print('Hello ' + user.displayName.toString());
                                  // var name = user.displayName;
                                  // var photo = user.photoUrl;
                                  // print(user);
                                  // print(name);flutter
                                  // print(photo);

                                  //Uploading information to firestore
                                  Firestore.instance
                                      .collection('users')
                                      .document(user.uid)
                                      .updateData({
                                        "email": emailController.text,
                                      })
                                      .then((result) => {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (BuildContext
                                            //                 context) =>
                                            //             ProfilePage(
                                            //               name: name,
                                            //               photourl: photo,
                                            //               email: user.email,
                                            //             )))

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        HomePageView(photoUrl: "name",)))
                                          })
                                      .catchError((err) => print(err));
                                });
                              }
                            },
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Don't have an account?",
                            style: TextStyle(color: Colors.black)),
                        SizedBox(height: 20),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: FlatButton(
                            padding: EdgeInsets.all(15),
                            color: Colors.black,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signup');
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Forgot Password?",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: topSnackVisible,
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  topBannerText,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
              height: bottomLoaderHeight,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15))),
              child: Row(
                children: <Widget>[
                  CircularProgressIndicator(backgroundColor: Colors.green, ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Signing in...",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _hideTopBanner() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        topSnackVisible = false;
      });
    });
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('users/' + user.uid);
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  Future<void> checkLoginStat() async {
    FirebaseUser user;
    user = await FirebaseAuth.instance.currentUser();

    if (user != null) {
      // var name = user.displayName;
      // var photo = user.photoUrl;
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => ProfilePage(
      //               name: name,
      //               photourl: photo,
      //               email: user.email,
      //             )));

      var name = user.displayName;
      var photo = user.photoUrl;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => HomePageView(photoUrl: photo,)));
    }
  }
}
