import 'package:chat_app/Screens/auth/signupScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  height: height /6,
                ),
                Text('CHAT APP',style: TextStyle(color: ThemeData.light().primaryColor,fontSize: 40,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: height /6,
                ),
                TextFormField(
                  decoration: InputDecoration(
                   // hintText: 'Please add your email',
                    label: Text('Email'),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Password'),
                  ),
                ),
                SizedBox(
                  height: height /9,
                ),
                Container(
                    width: width/2,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    }, child: Text('Login')))
              ],
            ),
          ),
        ),
      ),
        bottomNavigationBar: Container(
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dont have an account ?'),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              }, child: Text('Sign up'))
            ],
          ),
        )
    );
  }
}
