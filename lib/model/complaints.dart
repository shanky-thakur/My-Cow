class ComplaintsModel {
  String uid;
  String complaint;
  String phoneNumber;
  String createdAt;

  ComplaintsModel({
    required this.uid,
    required this.complaint,
    required this.phoneNumber,
    required this.createdAt,
  });

  factory ComplaintsModel.fromMap(Map<String, dynamic> map) {
    return ComplaintsModel(
      complaint: map['complaint'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      uid: map['uid'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> tomap() {
    return {
      "complaint": complaint,
      "phoneNumber": phoneNumber,
      "uid": uid,
      "createdAt": createdAt, 
    };
  }
}
