import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconfarm/design_course/home_design_course.dart';
import 'package:iconfarm/pages/profilePage.dart';
import 'package:iconfarm/pages/settings.dart';

import 'notifications.dart';

class HomePageView extends StatefulWidget {
  String photoUrl;
  HomePageView({@required this.photoUrl});

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

int _page = 0;
GlobalKey _bottomNavigationKey = GlobalKey();
PageController _controller = new PageController();

class _HomePageViewState extends State<HomePageView> {

@override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.green,
        onTap: (index){
          _page = index;
          _controller.animateToPage(_page, duration: Duration(microseconds: 500), curve: Curves.ease);
        },
        items: <Widget>[
          InkWell(child: Icon(Icons.home, size: 27),),
          Icon(Icons.favorite,size: 27),
          Icon(Icons.notifications, size: 27),
          Icon(Icons.account_circle, size: 27),
        ],
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          DesignCourseHomeScreen(),
          Notifications(),
          Notifications(),
          UserProfile(),
        ],
      ),
    );
  }

  
}
