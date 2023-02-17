class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  DateTime? createdOn;
  bool? seen;

  MessageModel({this.messageId,this.text, this.createdOn, this.seen, this.sender});

  MessageModel.fromJson(Map<String, dynamic> map) {
    this.messageId = map['messageId'];
    this.text = map['text'];
    this.sender = map['sender'];
    this.seen = map['seen'];
    this.createdOn = map['createdOn'];
  }

  Map<String, dynamic> toMap() {
    return {
      'messageId' : this.messageId,
      'text': this.text,
      'seen': this.seen,
      'sender': this.sender,
      'createdOn': this.createdOn,
    };
  }
}
