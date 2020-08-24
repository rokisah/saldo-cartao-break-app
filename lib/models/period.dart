class Period {
  final int id;
  final int cardId;
  final int month;
  final int year;
  final String text;
  final String value;

  Period(
      {this.id,
      this.cardId,
      this.month,
      this.year,
      this.text,
      this.value});

  Period.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        cardId = map["cardId"],
        month = map["month"],
        year = map['year'],
        text = map['text'],
        value = map['value'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardId': cardId,
      'month': month,
      'year': year,
      'text': text,
      'value': value
    };
  }
}
