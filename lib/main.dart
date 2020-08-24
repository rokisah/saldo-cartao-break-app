import 'package:flutter/material.dart';
import 'package:break_balance/routing/router.dart' as router;
import 'package:break_balance/views/shared/theme.dart';
import 'package:break_balance/views/startup_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saldo Break',
      theme: themeData,
      onGenerateRoute: router.generateRoute,
      home: StartUpView(),
    );
  }
}
