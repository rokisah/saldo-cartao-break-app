import 'package:break_balance/views/shared/ui_helpers.dart';

class CardTransaction {
  final int id;
  final int cardId;
  final int periodId;
  final DateTime date;
  final DateTime valueDate;
  final String description;
  final double debit;
  final double credit;
  final int category;

  static const int _descrLength = 15;

  CardTransaction(
      {this.id,
      this.cardId,
      this.periodId,
      this.date,
      this.valueDate,
      this.description,
      this.debit,
      this.credit,
      this.category});

  double get value {
    return isDebit ? -debit : credit;
  }

  bool get isDebit {
    return debit > 0;
  }

  @override
  String toString() {
    return formatDate(date) +
        "     " +
        (description.length < _descrLength
            ? description
            : description.substring(0, _descrLength)) +
        "     " +
        (debit == 0 ? "" : "-" + debit.toString()) +
        (credit == 0 ? "" : credit.toString());
  }

  CardTransaction.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        cardId = map["cardId"],
        periodId = map["periodId"],
        date = DateTime.fromMillisecondsSinceEpoch(map['date']),
        valueDate = DateTime.fromMillisecondsSinceEpoch(map['valueDate']),
        description = map['description'],
        debit = map['debit'],
        credit = map['credit'],
        category = map['category'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardId': cardId,
      'periodId': periodId,
      'date': date.millisecondsSinceEpoch,
      'valueDate': valueDate.millisecondsSinceEpoch,
      'description': description,
      'debit': debit,
      'credit': credit,
      'category': category
    };
  }
}
