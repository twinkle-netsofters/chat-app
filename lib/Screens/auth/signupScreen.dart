import 'package:chat_app/Models/userModel.dart';
import 'package:chat_app/Screens/auth/completeProfile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController confrimPwdController = TextEditingController();

  void checkValues() {
    String email = emailController.text.trim();
    String pwd = pwdController.text.trim();
    String cPwd = confrimPwdController.text.trim();
    if (email == "" || pwd == "" || cPwd == "") {
      print('Please fill all the values');
    } else if (pwd != cPwd) {
      print('passwords do not match');
    } else {
      signUp(email, pwd);
    }
  }

  void signUp(String email, String pwd) async {
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pwd);
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;
      UserModel newUser = UserModel(
        uid: uid,
        email: email,
        first_name: "",
        profile_pic: "",
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap())
          .then((value) {
        print('New User Created');
      });
    }
  }

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
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      label: Text('Password'),
                    ),
                  ),
                  TextFormField(
                    controller: confrimPwdController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      label: Text('Confirm Password'),
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
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => CompleteProfile())
                            // );
                          },
                          child: Text('Sign Up')))
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account ?'),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Login'))
            ],
          ),
        ));
  }
}
