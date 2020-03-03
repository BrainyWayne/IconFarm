import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconfarm/services/firebase_auth.dart';

import 'login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
  String photourl =
      "https://firebasestorage.googleapis.com/v0/b/profranco-c60f8.appspot.com/o/users%2F6FYGtLNyRhPIwXQPLXgvrx769tx2?alt=media&token=556eae73-0b2f-41b2-988c-07488d08ef36";

  String name;
  String email;

}

String residence;
String number;
String occupation;

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;

    FirebaseUser _user = Provider.of<FirebaseUser>(context);
    bool _loggedIn = _user != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Profile',
          // style: _theme.textTheme.title,
        ),
      ),
      body: !_loggedIn
          ? Center(
              child: Login(),
            )
          : SingleChildScrollView(
              child: Stack(
              children: <Widget>[
                Container(
                  height: _size.height - 200,
                  width: _size.width,
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Card(
                                clipBehavior: Clip.hardEdge,
                                shape: CircleBorder(),
                                child: CachedNetworkImage(
                                  imageUrl: widget.photourl,
                                  height: 170,
                                  width: 170,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 15),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Divider(
                                        endIndent: 20,
                                        height: 1,
                                        thickness: 0.5,
                                      ),
                                    ),
                                    Text(
                                      widget.name ?? 'User Name',
                                      style: _theme.textTheme.subhead.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        indent: 20,
                                        height: 1,
                                        thickness: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(widget.email,
                                  style: _theme.textTheme.caption)
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Preferences'),
                        trailing: Icon(LineIcons.cogs),
                        onTap: () => Navigator.of(context).pushNamed('/prefs'),
                      ),
                      Divider(
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Account'),
                        trailing: Icon(LineIcons.user),
                        onTap: () =>
                            Navigator.of(context).pushNamed('/account'),
                      ),
                      Divider(
                        height: 1,
                      ),
                      ListTile(
                        title: Text('Help Center'),
                        trailing: Icon(LineIcons.question),
                        onTap: () {
                          Navigator.of(context).pushNamed('/help_center');
                        },
                      ),
                      Divider(
                        height: 1,
                      ),
                      ListTile(
                        title: Text(
                          'Log out',
                          style: TextStyle(color: Colors.red),
                        ),
                        trailing: Icon(LineIcons.sign_out),
                        onTap: () {
                          Auth _auth = new Auth();
                          _auth.signOut();
                          Navigator.of(context).pushNamed('/login');
                        },
                      ),
                      Divider(
                        height: 1,
                      ),
                    ],
                  ),
                ),
              ],
            )),
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
        var photolink = datasnapshot.data['photo'].toString();

        setState(() {
          widget.name = datasnapshot.data['name'].toString();
          widget.email = datasnapshot.data['email'].toString();
          widget.photourl = photolink;
          residence = datasnapshot.data['residence'].toString();
          occupation = datasnapshot.data['occupation'].toString();
          number = datasnapshot.data['number'].toString();
        });
      }
    });
  }
}
