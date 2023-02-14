class UserModel {
  String? uid;
  String? first_name;
  String? email;
  String? profile_pic;

  UserModel({this.uid, this.email, this.first_name, this.profile_pic});

  //from map -> map to object deserialization

  UserModel.fromJson(Map<String, dynamic> map) {
    this.uid = map['uid'];
    this.email = map['email'];
    this.first_name = map['first_name'];
    this.profile_pic = map['profile_pic'];
  }

  //to map -> object to map serialization
  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      'first_name': this.first_name,
      'profile_pic': this.profile_pic,
    }
  }
}
