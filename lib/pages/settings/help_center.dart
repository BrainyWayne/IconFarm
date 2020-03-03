import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:iconfarm/utils/url_luncher.dart';

import '../../theme.dart';

class HelpCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(LineIcons.long_arrow_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'IconFarm',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // _firstTop(),
            Expanded(
              child: ListView(
                children: <Widget>[
                  coverImage(),
                  SizedBox(height: 10),
                  ListTile(
                    onTap: () {
                      Url.launchURL('');
                    },
                    title: Text(
                      'Terms and Conditions',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Url.launchURL('');
                    },
                    title: Text(
                      'Privacy Policy',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Url.launchURL('url');
                    },
                    title: Text(
                      'Refund Policy',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {
                  //     Navigator.of(context).pushNamed('/webView', arguments: {
                  //       'title': 'Just Foods',
                  //       'url': 'https://just-foods.firebaseapp.com'
                  //     });
                  //   },
                  //   title: Text(
                  //     'Our Website',
                  //     style: TextStyle(
                  //         fontFamily: 'Raleway',
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w500),
                  //   ),
                  // ),
                ],
              ),
            ),
            _socialIcons(context),
          ],
        ),
      ),
    );
  }
}

Widget _firstTop() {
  return Container(
    color: Colors.green,
  );
}

Widget coverImage() {
  return Container(
    padding: EdgeInsets.all(30),
    child: Center(
      child: Image.asset(
        'assets/profrancologo.png',
        // height: 150,
      ),
    ),
  );
}

Widget _socialIcons(BuildContext context) {
  return Card(
    clipBehavior: Clip.hardEdge,
    child: FittedBox(
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Url.launchURL('https://wa.me/+233000000000');
              },
              icon: Image(
                image: AssetImage('assets/images/whatsapp.png'),
              ),
              iconSize: 50,
              color: Color.fromRGBO(37, 211, 102, 1),
            ),
            IconButton(
              onPressed: () {
                Url.launchURL(
                    'mailto:__email__@gmail.com?subject=subject&body=body');
              },
              icon: Icon(LineIcons.at),
              iconSize: 50,
              color: Color.fromRGBO(221, 75, 57, 1),
            ),
            IconButton(
              onPressed: () {
                Url.launchURL('fb_link');
              },
              icon: Image(
                image: AssetImage('assets/images/facebook.png'),
                color: facebookBlue,
              ),
              iconSize: 50,
              color: Color.fromRGBO(59, 89, 152, 1),
            ),
            IconButton(
              onPressed: () {
                Url.launchURL('twitter_link');
              },
              icon: Icon(
                LineIcons.twitter,
                color: twitterBlue,
              ),
              iconSize: 50,
              color: Color.fromRGBO(59, 89, 152, 1),
            ),
            IconButton(
              onPressed: () {
                Url.launchURL('https://www.instagram.com/__ig__');
              },
              icon: socialBotton('assets/images/instagram.png'),
              iconSize: 50,
            ),
            // IconButton(
            //   onPressed: () {
            //     Url.launchURL('https://bit.ly/just-foods-mg');
            //   },
            //   icon: socialBotton('assets/social/messenger.png'),
            //   iconSize: 40,
            // ),
            IconButton(
              onPressed: () {
                Url.launchURL('tel:+233000000000');
              },
              icon: Icon(LineIcons.phone),
              iconSize: 45,
              color: Color.fromRGBO(10, 191, 83, 1),
            )
          ],
        ),
      ),
    ),
  );
}

Widget socialBotton(image) {
  return Material(
    shape: CircleBorder(),
    child: Image.asset(
      image,
    ),
  );
}
