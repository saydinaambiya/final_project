class UserModel {
  String? uid;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? address;
  String? level;

  UserModel(
      {this.uid,
      this.email,
      this.fullName,
      this.phoneNumber,
      this.address,
      this.level});

  //receive data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      level: map['level'],
    );
  }

  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
      'level': level,
    };
  }
}
