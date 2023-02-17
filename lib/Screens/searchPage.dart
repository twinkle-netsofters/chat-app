import 'dart:developer';

import 'package:chat_app/Models/userModel.dart';
import 'package:chat_app/Screens/chatRoomScreen.dart';
import 'package:chat_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../Models/chatRoomModel.dart';

class SearchPage extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;

  const SearchPage(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  Future<ChatRoomModel?> getChatRoom(UserModel targetUser) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatRoom")
        .where("participants.${widget.userModel?.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      log('ChatRoom already created');
    } else {
      log('ChatRoom not created');
      ChatRoomModel newChatRoom = ChatRoomModel(
          chatRoomId: uuid.v1(),
          participants: {
            widget.userModel!.uid.toString(): true,
            targetUser.uid.toString(): true,
          },
          lastMessage: "");

      await FirebaseFirestore.instance.collection("chatRoom").doc(newChatRoom.chatRoomId).set(newChatRoom.toMap());
      log("chat room created");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                label: Text('Enter mail id'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                  // checkValues();
                },
                child: Text("Search")),
            SizedBox(
              height: 30,
            ),
            StreamBuilder(
              // The query is created using the where method to filter the collection by email, and the snapshots() method is called to create a stream of query results.
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("email",
                      isEqualTo: searchController.text.trim().toString())
                  .where("email", isNotEqualTo: widget.userModel!.email)
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.active) {
                  if (snapshots.hasData) {
                    //data with typess with all array - and then convert data to map
                    QuerySnapshot dataSnapshot =
                        snapshots.data as QuerySnapshot;
//we need mpa from this quesrysnap shot
                    if (dataSnapshot.docs.length > 0) {
                      Map<String, dynamic> userMap =
                          dataSnapshot.docs[0].data() as Map<String, dynamic>;
                      UserModel searchResult = UserModel.fromJson(userMap);
                      return ListTile(
                        onTap: () async {
                          ChatRoomModel? chatRoomModel =
                              await getChatRoom(searchResult);
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(searchResult.profile_pic!),
                        ),
                        title: Text(searchResult.first_name!),
                        subtitle: Text(searchResult.email!),
                      );
                    } else {
                      return Text('No result found');
                    }
                  } else if (snapshots.hasError) {
                    return Text('Error occured');
                  } else {
                    return Text("No results found");
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
