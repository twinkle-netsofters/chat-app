import 'package:chat_app/Models/chatRoomModel.dart';
import 'package:chat_app/Models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  // for friend user
  final UserModel targetUser;
  final ChatRoomModel chatRoom;
  // for me
  final UserModel userModel;
  final User firebaseUser;

  const ChatRoomScreen({super.key, required this.targetUser, required this.chatRoom, required this.userModel, required this.firebaseUser});


  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Flexible(child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type Message',
                    ),

                  )),
                  IconButton(onPressed: (){}, icon: Icon(Icons.send,color: Colors.grey,))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
