import 'package:chat_app/Models/userModel.dart';

class ChatRoomModel{
  String? chatRoomId;
  Map<String ,dynamic>? participants;
  String? lastMessage ;//for showing lastmessage on home screen

  ChatRoomModel({this.chatRoomId , required this.participants, required this.lastMessage});

  ChatRoomModel.fromMap(Map<String , dynamic> map){
    this.lastMessage = map['lastMessage'];
    this.chatRoomId = map['chatRoomId'];
    this.participants = map['participants'];
  }

  Map<String, dynamic> toMap(){
    return{
      "lastMessage" : this.lastMessage,
      'chatRoomId' : this.chatRoomId,
      'participants' : this.participants,
    };
  }
}