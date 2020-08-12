import 'package:saldo_cartao_break/models/card_transaction.dart';
import 'package:saldo_cartao_break/routing/routing_constants.dart';
import 'package:saldo_cartao_break/services/card_service.dart';
import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/views/shared/ui_helpers.dart';
import 'package:saldo_cartao_break/views/widgets/note_text.dart';

class CardTransactionsView extends StatefulWidget {
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
          return Text('loading...');
        });
  }

  Future<Widget> buildTransactions() async {
    List<CardTransaction> transactions = await CardService.getTransactions();
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, i) {
        var trx = transactions[i];
        return Card(
            child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          leading: CircleAvatar(
            backgroundColor: trx.isDebit ? Colors.red : Colors.green,
            radius: 20,
            child: Icon(
              Icons.attach_money,
              color: Colors.white
            ),
          ),
          title: NoteText(
            trx.description,
            color: Colors.indigo,
            fontWeight: FontWeight.normal,
          ),
          subtitle: Row(
            children: [
              Container(
                  child: NoteText(
                formatDate(trx.date),
                color: Colors.indigo,
                fontSize: 16,
                fontWeight: FontWeight.bold
              )),
              Expanded(
                child: Container(
                    alignment: Alignment.bottomRight,
                    child: NoteText(
                      formatCurrency(trx.value),
                      color: trx.isDebit ? Colors.red : Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    )
                )
              )
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
