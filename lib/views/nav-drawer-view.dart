import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/routing/routing_constants.dart';
import 'package:saldo_cartao_break/services/sign_in_service.dart'
    as sign_in_service;
import 'package:saldo_cartao_break/views/widgets/note_text.dart';

class NavDrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue[50],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: NoteText(
                  'Bem vindo',
                  color: Colors.white,
                  fontSize: 25
                ),
              decoration: BoxDecoration(
              color: Colors.blue,
                  // image: DecorationImage(
                  //     fit: BoxFit.fill,
                  //     image: AssetImage('assets/images/cover.jpg')
                  // )
              ),
            ),
            ListTile(
              leading: Icon(Icons.list, color: Colors.indigo),
              title: NoteText('Transações', color: Colors.indigo),
              onTap: () {
                Navigator.pushNamed(context, TransactionsViewRoute);
              },
            ),
            ListTile(
              leading: Icon(Icons.card_membership, color: Colors.indigo),
              title: NoteText('Cartões', color: Colors.indigo),
              onTap: () {
                Navigator.pushNamed(context, ManageCardsViewRoute);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.indigo),
              title: NoteText('Logout', color: Colors.indigo),
              enabled: true,
              onTap: () {
                signout(context);
              },
            ),
          ],
        ),
      )
    );
  }

  void signout(BuildContext context) {
    sign_in_service.signOutGoogle().whenComplete(() {
      Navigator.pushNamedAndRemoveUntil(context, LoginViewRoute, (route) => false);
    });
  }
}
