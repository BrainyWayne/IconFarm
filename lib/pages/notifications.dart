import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconfarm/services/CRUD.dart';
import 'package:iconfarm/services/firebase_auth.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

String name;
String level;
String rating;
QuerySnapshot cars;
String username;
String email;
String photoUrl = "";
String residence;
String number;
String occupation;
bool isUserVerified = true;

class _NotificationsState extends State<Notifications> {
  crudMedthods crudObj = new crudMedthods();
  @override
  void initState() {
    crudObj.getHomeData().then((results) {
      setState(() {
        cars = results;
      });
    });
    checkVerification();

    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          )
        ],
        title: Text('Notifications'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _generalNotifications(),
          ],
        ),
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
          number = datasnapshot.data['number'].toString();
        });
      }
    });
  }

  checkVerification() {
    Auth _auth = new Auth();
    _auth.isEmailVerified().then((onValue) {
      setState(() {
        isUserVerified = onValue;
      });
    });
  }
}

Widget _generalNotifications() {
  if (cars != null) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          isUserVerified
              ? Container()
              : Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(
                      "Email not verified",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Visit your email inbox to verify your email",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: cars.documents.length,
            padding: EdgeInsets.all(5.0),
            itemBuilder: (context, i) {
              return new Container(
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  title: Text(cars.documents[i].data['name']),
                ),
              );
              // return new ListTile(
              //   title: Text(cars.documents[i].data['carName']),
              //   subtitle: Text(cars.documents[i].data['color']),
              // );
            },
          ),
        ],
      ),
    );
  } else {
    return Row(
      children: <Widget>[
        CircularProgressIndicator(),
        Text('Loading, Please wait..'),
      ],
    );
  }
}
