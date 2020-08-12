import 'package:saldo_cartao_break/views/shared/ui_helpers.dart';

class CardTransaction {
  final DateTime date;
  final DateTime valueDate;
  final String description;
  final double debit;
  final double credit;

  static const int _descrLength = 15;

  CardTransaction(
      {this.date, this.valueDate, this.description, this.debit, this.credit});

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
}
