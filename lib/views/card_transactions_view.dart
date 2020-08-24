import 'package:break_balance/models/card_transaction.dart';
import 'package:break_balance/routing/routing_constants.dart';
import 'package:break_balance/services/card_service.dart';
import 'package:flutter/material.dart';
import 'package:break_balance/views/shared/ui_helpers.dart';
import 'package:break_balance/views/widgets/note_text.dart';

class CardTransactionsView extends StatefulWidget {
  final CardService cardService;

  CardTransactionsView({this.cardService});

  @override
  _CardTransactionsViewState createState() => _CardTransactionsViewState();
}

class _CardTransactionsViewState extends State<CardTransactionsView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: buildTransactions(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          }
          return Center(child: Text('A carregar...'));
        }
      );
  }

  Future<Widget> buildTransactions() async {
    List<CardTransaction> transactions =
        await widget.cardService.getTransactions();
    return ListView.builder(
      itemCount: transactions == null ? 0 : transactions.length,
      itemBuilder: (context, i) {
        var trx = transactions[i];
        return Card(
            elevation: 5,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              leading: CircleAvatar(
                backgroundColor: trx.isDebit ? Colors.red : Colors.green,
                radius: 20,
                child: Icon(Icons.attach_money, color: Colors.white),
              ),
              title: NoteText(
                trx.description,
                color: Colors.indigo,
                fontWeight: FontWeight.normal,
              ),
              subtitle: Row(
                children: [
                  Container(
                      child: NoteText(formatDate(trx.date),
                          color: Colors.indigo,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Expanded(
                      child: Container(
                          alignment: Alignment.bottomRight,
                          child: NoteText(formatCurrency(trx.value),
                              color: trx.isDebit ? Colors.red : Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)))
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.indigo),
              onTap: () {
                Navigator.pushNamed(context, TransactionDetailViewRoute,
                    arguments: trx);
              },
            ));
      },
    );
  }
}
