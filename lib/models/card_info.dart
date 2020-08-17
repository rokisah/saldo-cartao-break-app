class CardInfo {
  final int id;
  final String name;
  final String userId;
  final String registerCode;
  final String accessCode;
  final bool accessValid;
  final bool active;

  CardInfo(this.id, this.name, this.userId, this.registerCode, this.accessCode, this.accessValid, this.active);

  CardInfo.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map['name'],
        userId = map['userId'],
        registerCode = map['registerCode'],
        accessCode = map['accessCode'],
        accessValid = map['access_valid'] == 1,
        active = map['active'] == 1;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'registerCode': registerCode,
      'accessCode': accessCode,
      'access_valid': accessValid ? 1 : 0,
      'active': active ? 1 : 0
    };
  }
}
