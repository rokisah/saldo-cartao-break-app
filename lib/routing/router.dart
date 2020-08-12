import 'package:saldo_cartao_break/routing/routing_constants.dart';
import 'package:saldo_cartao_break/views/edit_card_view.dart';
import 'package:saldo_cartao_break/views/login_view.dart';
import 'package:saldo_cartao_break/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/views/managa_cards_view.dart';
import 'package:saldo_cartao_break/views/signup_email_view.dart';
import 'package:saldo_cartao_break/views/transaction_detail_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
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
