// ignore_for_file: file_names

class UserModel {
  String createdAt;
  String phoneNumber;
  String uid;

  UserModel({
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      createdAt: map['createdAt'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  Map<String, dynamic> tomap() {
    return {
      "createdAt": createdAt,
      "phoneNumber": phoneNumber,
      "uid": uid,
    };
  }
}
