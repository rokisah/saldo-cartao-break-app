import 'package:cloud_firestore/cloud_firestore.dart';

class CardInfo {
  final String id;
  final String name;
  final String userId;
  final String registerCode;
  final String accessCode;

  CardInfo(this.id, this.name, this.userId, this.registerCode, this.accessCode);

  CardInfo.fromDocument(DocumentSnapshot doc)
      : id = doc.documentID,
        name = doc.data['name'],
        userId = doc.data['userId'],
        registerCode = doc.data['registerCode'],
        accessCode = doc.data['accessCode'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userId': userId,
      'registerCode': registerCode,
      'accessCode': accessCode
    };
  }
}
