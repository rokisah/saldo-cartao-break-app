import 'package:saldo_cartao_break/views/card_balance_view.dart';
import 'package:saldo_cartao_break/views/card_transactions_view.dart';
import 'package:saldo_cartao_break/views/filter_view.dart';
import 'package:saldo_cartao_break/services/card_service.dart';
import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/views/nav-drawer-view.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: buildMain(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          }
          return Text('loading...');
        });
  }

  Future<Widget> buildMain() async {
      await CardService.initialize();
    return Scaffold(
        drawer: NavDrawerView(),
        appBar: AppBar(
            title: Text('Transações'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.refresh),
                  tooltip: 'Refresh',
                  onPressed: () {
                    setState(() {});
                  })
            ]),
        body: Container(
          height: double.maxFinite,
          // color: Colors.blue[40],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                height: 100,
                // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                color: Colors.blue[100],
                child: FilterView(
                  onUpdate: () {
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: Container(
                  // alignment: Alignment.center,
                  width: double.maxFinite,
                  // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  color: Colors.blue[50],
                  child: CardTransactionsView()
                )
              ),
              Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                // height: 150,
                // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.blue[100],
                child: CardBalanceView()
              )
            ]
          )
        )
        
      );
  }
}
