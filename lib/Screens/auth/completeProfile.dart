import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  //use file of dart io
  File? imageFile;
  TextEditingController fullnameController = TextEditingController();

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 20
    );//await ImageCropper().cropImage(sourcePath: file.path);
    if (croppedImage != null) {
      File convertedFile = File(croppedImage.path);
      setState(() {
        imageFile = convertedFile;
      });
    }
  }

//for showing dialog
  void showPhotoOption() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Upload Profile Picture'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('Select from gallary'),
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(
                        ImageSource.gallery); //to get image from gallery
                  },
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(
                        ImageSource.camera); ////to get image from camera
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text('Take a photo'),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          child: ListView(
            children: [
              SizedBox(
                height: height / 8,
              ),
              CupertinoButton(
                onPressed: () {
                  showPhotoOption();
                },
                child: CircleAvatar(
                  backgroundImage: FileImage(imageFile!),//CroppedFile(imageFile),
                  child: Icon(
                    Icons.person,
                    size: 60,
                  ),
                  radius: 60,
                ),
              ),
              SizedBox(
                height: height / 16,
              ),
              TextFormField(
                controller: fullnameController,
                decoration: InputDecoration(
                  label: Text('Enter your full name'),
                ),
              ),
              SizedBox(
                height: height / 12,
              ),
              Container(
                  width: width / 3,
                  height: 50,
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
