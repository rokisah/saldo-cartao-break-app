import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/routing/router.dart' as router;
import 'package:saldo_cartao_break/views/shared/theme.dart';
import 'package:saldo_cartao_break/views/startup_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saldo Cartão Break',
      theme: themeData,
      onGenerateRoute: router.generateRoute,
      home: StartUpView(),
    );
  }
}
