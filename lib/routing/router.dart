import 'package:break_balance/routing/routing_constants.dart';
import 'package:break_balance/views/edit_card_view.dart';
import 'package:break_balance/views/login_view.dart';
import 'package:break_balance/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:break_balance/views/manage_cards_view.dart';
import 'package:break_balance/views/signup_email_view.dart';
import 'package:break_balance/views/startup_view.dart';
import 'package:break_balance/views/transaction_detail_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case StartUpViewRoute:
      return MaterialPageRoute(builder: (context) => StartUpView(), settings: settings);
    case TransactionsViewRoute:
      return MaterialPageRoute(builder: (context) => MainView(), settings: settings);
    case LoginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginView(), settings: settings);
    case ManageCardsViewRoute:
      return MaterialPageRoute(builder: (context) => ManageCardsView(), settings: settings);
    case SignupEmailViewRoute:
      return MaterialPageRoute(builder: (context) => SignupEmailView(), settings: settings);
    case EditCardViewRoute:
      return MaterialPageRoute(builder: (context) => EditCardView(), settings: settings);
    case TransactionDetailViewRoute:
      return MaterialPageRoute(builder: (context) => TransactionDetailView(), settings: settings);
    default:
      return MaterialPageRoute(builder: (context) => MainView(), settings: settings);
  }
}
