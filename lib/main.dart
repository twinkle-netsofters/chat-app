
import 'package:chat_app/Helper/firebaseHelper.dart';
import 'package:chat_app/Models/userModel.dart';
import 'package:chat_app/Screens/auth/completeProfile.dart';
import 'package:chat_app/Screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'Screens/auth/loginScreen.dart';

var uuid = Uuid();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? currentUser = FirebaseAuth.instance.currentUser;

  if(currentUser != null){
    UserModel? thiUserModel =await FirebaseHelper.getUserModelbyId(currentUser.uid);
    if (thiUserModel != null) {
      runApp( MyAppLoggedIn(userModel:thiUserModel ,firebaseUser: currentUser,));
    }  else{
      runApp( MyApp());
    }

  }
  else{
    runApp(const MyApp());
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: LoginScreen()
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
 final UserModel? userModel;
 final User? firebaseUser;

  const MyAppLoggedIn({super.key,required this.userModel,required this.firebaseUser});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: HomePage(
          userModel: userModel,
          firebaseUser: firebaseUser,
        )
    );
  }
}
