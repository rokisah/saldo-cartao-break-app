import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/routing/routing_constants.dart';
import 'package:saldo_cartao_break/services/card_service.dart';
import 'package:saldo_cartao_break/services/firestore_service.dart';
import 'package:saldo_cartao_break/services/sign_in_service.dart'
    as signInService;

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    signInService.getLoggedUser().then((loggedUser) {
      if (loggedUser != null) {
        loadCard(context, loggedUser);
      } else {
        Navigator.popAndPushNamed(context, LoginViewRoute);
      }
    });
    return waitWidget();
  }

  loadCard(BuildContext context, FirebaseUser loggedUser) async {
    var cards = await FirestoreService().getCards(loggedUser.uid);
    if (cards.length > 0) {
      CardService.cardInfo = cards[0];
      await CardService.initialize();
      Navigator.popAndPushNamed(context, TransactionsViewRoute);
    } else {
      Navigator.popAndPushNamed(context, ManageCardsViewRoute);
    }
  }

  Widget waitWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(width: 300, height: 100),
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(Color(0xff19c7c1)),
            )
          ],
        ),
      ),
    );
  }
}
