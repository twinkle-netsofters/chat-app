import 'package:chat_app/Models/userModel.dart';

class ChatRoomModel{
  String? chatRoomId;
  List<String>? participants;

  ChatRoomModel({this.chatRoomId , this.participants});

  ChatRoomModel.fromMap(Map<String , dynamic> map){
    this.chatRoomId = map['chatRoomId'];
    this.participants = map['participants'];
  }

  Map<String, dynamic> toMap(){
    return{
      'chatRoomId' : this.chatRoomId,
      'participants' : this.participants,
    };
  }
}