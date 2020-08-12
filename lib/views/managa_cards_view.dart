import 'package:saldo_cartao_break/routing/routing_constants.dart';
import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/models/card_info.dart';
import 'package:saldo_cartao_break/services/firestore_service.dart';
import 'package:saldo_cartao_break/views/nav-drawer-view.dart';
import 'package:saldo_cartao_break/services/sign_in_service.dart'
    as SigninService;
import 'package:saldo_cartao_break/views/widgets/note_text.dart';

class ManageCardsView extends StatefulWidget {
  @override
  _ManageCardsViewState createState() => _ManageCardsViewState();
}

class _ManageCardsViewState extends State<ManageCardsView> {
  final registerCodeController = TextEditingController();
  final accessCodeController = TextEditingController();
  List<CardInfo> cards = new List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawerView(),
        appBar: AppBar(
          title: Text('Gerenciar Cartões'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, EditCardViewRoute);
                })
          ],
        ),
        body: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data;
              } else {
                return Center(
                  child: NoteText(
                    'Loading...',
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  )
                );
              }
            },
            future: cardList()
          )
    );
  }

  Future<Widget> cardList() async {
    final loggedUser = await SigninService.getLoggedUser();
    var cards = await FirestoreService().getCards(loggedUser.uid);
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, i) {
        return ListTile(
            title: NoteText(
              cards[i].name,
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            trailing: Icon(
              Icons.edit,
              color: Colors.indigo
            ),
            onTap: () {
              Navigator.pushNamed(context, EditCardViewRoute,
                  arguments: cards[i]);
            });
      },
    );
  }
}
