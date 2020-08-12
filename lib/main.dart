import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/routing/router.dart' as router;
import 'package:saldo_cartao_break/views/startup_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saldo Cartão Break',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: router.generateRoute,
      // initialRoute: LoginViewRoute
      home: StartUpView(),
    );
  }
}
