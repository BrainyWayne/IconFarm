import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconfarm/services/firebase_auth.dart';
import 'package:iconfarm/utils/crudobj.dart';

import 'login.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  String username;
  String email;
  String photoUrl;
  String residence;
  String number;
  String occupation;
  String type;
  String title;
  String details;
  CRUDMethods crudObj;
  String uploadButtonText = "Upload";

  @override
  void initState() {
    super.initState();
    crudObj = new CRUDMethods();

    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        children: <Widget>[
          SafeArea(
            child: Row(
              children: <Widget>[
                Text(
                  "Upload new Product",
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            username,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            email,
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            height: 30,
          ),
          Text("TItle"),
          TextField(
            decoration: InputDecoration(hintText: "Enter title"),
            onChanged: (value) {
              title = value;
              print(title);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text("Details"),
          TextField(
            decoration: InputDecoration(hintText: "Enter details"),
            onChanged: (value) {
              details = value;
              print(details);
            },
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              uploadPost(title, details);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: <Widget>[
                  Text(
                    uploadButtonText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                Text(
                  "Cancel",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
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
          type = datasnapshot.data['residence'].toString();
          occupation = datasnapshot.data['type'].toString();
          number = datasnapshot.data['phone'].toString();
        });
      }
    });
  }

  void uploadPost(String title, String details) {
    crudObj.addData({
      'title': title,
      'details': details,
      'name': username,
      'number': number,
      'type': type,
      'emmail': email,
      'residence': residence

    }).then((result) {
      setState(() {
        uploadButtonText = "Uploaded";
      });
    }).catchError((e) {
      print(e);
    });
  }
}
