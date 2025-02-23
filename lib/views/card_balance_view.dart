import 'package:saldo_cartao_break/services/card_service.dart';
import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/views/widgets/note_text.dart';

class CardBalanceView extends StatefulWidget {
  @override
  _CardBalanceViewState createState() => _CardBalanceViewState();
}

class _CardBalanceViewState extends State<CardBalanceView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: buildTransactions(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        }
        return Text('loading...');
      }
    );
  }

  Future<Widget> buildTransactions() async {
    String balance = await CardService.getBalance();
    return NoteText(
      balance,
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.indigo[900],
    );
  }
}
