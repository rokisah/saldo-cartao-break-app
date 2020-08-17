import 'package:saldo_cartao_break/services/card_service.dart';
import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/views/widgets/note_text.dart';

class CardBalanceView extends StatefulWidget {
  final CardService cardService;

  CardBalanceView({this.cardService});

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
          return Center(child: NoteText('A Carregar...',
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        )
            );
        });
  }

  Future<Widget> buildTransactions() async {
    String balance = await widget.cardService.getBalance();
    balance = balance ?? "";
    return NoteText(
      balance,
      fontSize: 35,
      fontWeight: FontWeight.bold,
      color: Colors.blue[50],
    );
  }
}
