class UserModel {
  String? uid;
  String? level;
  String? fullName;
  String? email;
  String? phoneNumber;

  UserModel({
    this.uid,
    this.level,
    this.email,
    this.fullName,
    this.phoneNumber,
  });

  // receive data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      level: map['level'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'level': level,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };
  }
}
