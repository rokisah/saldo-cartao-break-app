import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:break_balance/routing/routing_constants.dart';
import 'package:break_balance/services/session_service.dart';
import 'package:break_balance/services/sign_in_service.dart'
    as signInService;

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    signInService.getLoggedUser().then((loggedUser) {
      if (loggedUser != null) {
        loadCards(context, loggedUser);
      } else {
        Navigator.popAndPushNamed(context, LoginViewRoute);
      }
    });
    return waitWidget();
  }

  loadCards(BuildContext context, FirebaseUser loggedUser) async {
    await SessionService.loadCards(loggedUser.uid);
    if (SessionService.length > 0) {
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
