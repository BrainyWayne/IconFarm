import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconfarm/services/firebase_auth.dart';

import 'login.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String username;
  String email;
  String photoUrl;
  String residence;
  String number;
  String occupation;

  @override
  void initState() {
    super.initState();

    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          
        ],
        title: Text('Profile'),
      ),
      body: Center(
        child: Container(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                            child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(photoUrl),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                username,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                email,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(residence, style: TextStyle(fontSize: 17)),
                  SizedBox(width: 10),
                  Container(color: Colors.grey, height: 20, width: 1),
                  SizedBox(width: 10),
                  Text(number, style: TextStyle(fontSize: 17)),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Auth _auth = new Auth();
                  _auth.signOut().then((onValue) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Login()));
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.red, borderRadius: BorderRadius.circular(20)),
                  child: Text("Logout",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Future<void> getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentReference documentReference =
        Firestore.instance.collection('users').document(user.uid);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        print(datasnapshot.data['email'].toString());
        print(datasnapshot.data['name'].toString());
        print(datasnapshot.data['residence'].toString());
        var photolink;
        try {
          photolink = datasnapshot.data['photo'].toString();
        } catch (e) {
          photoUrl = "N/A";
        }

        setState(() {
          username = datasnapshot.data['name'].toString();
          email = datasnapshot.data['email'].toString();
          photoUrl = photolink;
          residence = datasnapshot.data['residence'].toString();
          occupation = datasnapshot.data['occupation'].toString();
          number = datasnapshot.data['phone'].toString();
        });
      }
    });
  }
}
