class MessageModel {
  String? sender;
  String? text;
  DateTime? createdOn;
  bool? seen;

  MessageModel({this.text, this.createdOn, this.seen, this.sender});

  MessageModel.fromJson(Map<String, dynamic> map) {
    this.text = map['text'];
    this.sender = map['sender'];
    this.seen = map['seen'];
    this.createdOn = map['createdOn'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': this.text,
      'seen': this.seen,
      'sender': this.sender,
      'createdOn': this.createdOn,
    };
  }
}
