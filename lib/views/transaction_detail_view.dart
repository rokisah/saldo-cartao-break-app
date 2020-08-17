import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/models/card_transaction.dart';
import 'package:saldo_cartao_break/views/widgets/note_text.dart';
import 'package:saldo_cartao_break/views/shared/ui_helpers.dart';

class TransactionDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CardTransaction transaction = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Detalhes")
      ),
      body: Card(
        margin: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        elevation: 5,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NoteText("Data", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
              NoteText(formatDate(transaction.date), fontSize: 20, color: Colors.indigo),
              verticalSpaceMedium,
              NoteText("Data Valor", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
              NoteText(formatDate(transaction.valueDate), fontSize: 20, color: Colors.indigo),
              verticalSpaceMedium,
              NoteText("Descrição", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
              NoteText(transaction.description, fontSize: 20, color: Colors.indigo),
              verticalSpaceMedium,
              NoteText("Crédito", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
              NoteText(formatCurrency(transaction.credit), fontSize: 20, color: Colors.indigo),
              verticalSpaceMedium,
              NoteText("Débito", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
              NoteText("-" + formatCurrency(transaction.debit), fontSize: 20, color: Colors.indigo)
            ]
          ),
        )
      )
    );
  }
}