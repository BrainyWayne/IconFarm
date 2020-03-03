import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
 
class crudMedthods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }
 
  Future<void> addData(carData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('teachers').add(carData).catchError((e) {
         print(e);
       });
 
    } else {
      print('You need to be logged in');
    }
  }
 
  getHomeData() async {
    return await Firestore.instance.collection('users').getDocuments();
  }

  getGeneralNotifications() async {
    return await Firestore.instance.collection('generalnotifications').getDocuments();
  }
}