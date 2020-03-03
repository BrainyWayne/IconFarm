import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconfarm/routes.dart';

import 'services/settings_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    
    // FirebaseMessaging _fcm = FirebaseMessaging();
    // _fcm.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     //  _showItemDialog(message);
    //   },
    //   //  onBackgroundMessage: myBackgroundMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     //  _navigateToItemDetail(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     //  _navigateToItemDetail(message);
    //   },
    // );

    return MultiProvider(
      providers: [
        /// Providing a the current user as a stream
        ///
        ///
        /// provider.of<FirebaseUser>(context);
        /// to get access to the current user
        ///

        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
          catchError: (context, object) => null,
          initialData: null,
        ),

        /// settings provider
        ChangeNotifierProvider<SettingsProvider>.value(
          value: SettingsProvider(),
        ),

        
      ],
      child: Consumer(
        builder: (context, SettingsProvider prefs, Widget object) =>
            MaterialApp(
          title: 'IconFarm',
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          themeMode: prefs.darkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            // primarySwatch: Color.fromARGB(a, r, g, b),
            primaryColor: Color.fromRGBO(248, 160, 24, 1),
            accentColor: Color.fromRGBO(240, 208, 128, 1),
          ),
          initialRoute: '/splash',
          onGenerateRoute: Router.onGenerateRoutes,
        ),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
