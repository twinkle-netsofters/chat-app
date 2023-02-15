class UserModel {
  String? uid;
  String? first_name;
  String? email;
  String? profile_pic;

  UserModel({this.uid, this.email, this.first_name, this.profile_pic});

  //from map -> map to object deserialization

  UserModel.fromJson(Map<String, dynamic> map) {
    uid = map['uid'];
    email = map['email'];
    first_name = map['first_name'];
    profile_pic = map['profile_pic'];
  }

  //to map -> object to map serialization
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'first_name': first_name,
      'profile_pic': profile_pic,
    };
  }
}
