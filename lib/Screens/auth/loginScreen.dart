import 'package:chat_app/Models/userModel.dart';
import 'package:chat_app/Screens/homepage.dart';
import 'package:chat_app/Screens/auth/signupScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  void checkValues() {
    String email = emailController.text.trim();
    String password = pwdController.text.trim();
// for validation
    if (email == "" || password == "") {
      print('Please fill both fields');
    } else {
      logIn(email, password);
    }
  }

  void logIn(String email, String password) async {
    UserCredential? credential;
//sign in dataaa
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      print('error ${ex.code}');
    }
    //
    if (credential != null) {
      String? uid = credential.user!.uid;
      //A DocumentSnapshot contains data read from a document in your FirebaseFirestore database.
      // The data can be extracted with the data property or by using subscript syntax to access a specific field.
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      // fromJSon method converts the json data in object usin fromJson
      // here data is not in map format for now so we have to convert that to map using .data() as MAp<>
      UserModel? userModel =
          UserModel.fromJson(userData.data() as Map<String, dynamic>);
      print('login successfullll');
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(userModel: userModel,firebaseUser: credential!.user!,)));
    }


  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height / 6,
                  ),
                  Text(
                    'CHAT APP',
                    style: TextStyle(
                        color: ThemeData.light().primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height / 6,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      // hintText: 'Please add your email',
                      label: Text('Email'),
                    ),
                  ),
                  TextFormField(
                    controller: pwdController,
                    decoration: InputDecoration(
                      label: Text('Password'),
                    ),
                  ),
                  SizedBox(
                    height: height / 9,
                  ),
                  Container(
                      width: width / 2,
                      child: ElevatedButton(
                          onPressed: () {
                            checkValues();
                          },
                          child: Text('Login')))
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dont have an account ?'),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text('Sign up'))
            ],
          ),
        ));
  }
}
