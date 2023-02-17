import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/userModel.dart';

class FirebaseHelper {
  // her we used static so we can use this function anywehere without makin instances
  static Future<UserModel?> getUserModelbyId(String uid) async {
    UserModel? userModel;
    // get users doc data by calling this line
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (snapshot.data() != null) {
      // if data is not null then we fetch the data using from json and convert that to mao and then saved to that to object
      userModel = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    }
    return userModel;
  }
}
