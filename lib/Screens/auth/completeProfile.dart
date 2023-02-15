import 'package:flutter/material.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: ListView(
            children: [
              SizedBox(
                height: height / 6,
              ),
              CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 60,
                ),
                radius: 60,
              ),
              SizedBox(
                height: height / 9,
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Enter your full name'),
                ),
              ),
              SizedBox(
                height: height / 6,
              ),
              Container(
                  width: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                      child: Text('Sign Up')))
            ],
          ),
        ),
      ),
    ));
  }
}
