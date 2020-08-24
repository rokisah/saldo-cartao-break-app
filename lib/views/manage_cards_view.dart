import 'package:break_balance/repository/card_info_repository.dart';
import 'package:break_balance/routing/routing_constants.dart';
import 'package:flutter/material.dart';
import 'package:break_balance/models/card_info.dart';
import 'package:break_balance/services/session_service.dart';
import 'package:break_balance/views/nav-drawer-view.dart';
import 'package:break_balance/services/sign_in_service.dart'
    as SigninService;
import 'package:break_balance/views/widgets/note_text.dart';

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
          title: Text('Gerenciar Registos'),
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
                    child: NoteText('A Carregar...',
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 20));
              }
            },
            future: cardList()));
  }

  Future<Widget> cardList() async {
    final loggedUser = await SigninService.getLoggedUser();
    var cards = await CardInfoRepository().getCards(loggedUser.uid);
    await SessionService.loadCardService(cards);
    // load cards again to reflect any inactivated card
    cards = await CardInfoRepository().getCards(loggedUser.uid);
    print("Manage: " + SessionService.length.toString());
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, i) {
            var card = cards[i];
            return Card(
              elevation: 5,
              child: ListTile(
                  title: NoteText(
                    card.name,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  leading: (card.active && card.accessValid) 
                            ? Icon(Icons.check, color: Colors.green)
                            : Icon(Icons.error, color: Colors.red),
                  trailing: Icon(Icons.edit, color: Colors.indigo),
                  onTap: () {
                    Navigator.pushNamed(context, EditCardViewRoute,
                        arguments: card);
                  }),
            );
          },
        ));
  }
}
