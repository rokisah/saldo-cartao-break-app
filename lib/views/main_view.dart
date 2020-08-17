import 'package:saldo_cartao_break/services/card_service.dart';
import 'package:saldo_cartao_break/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/views/card_balance_view.dart';
import 'package:saldo_cartao_break/views/card_transactions_view.dart';
import 'package:saldo_cartao_break/views/filter_view.dart';
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
          return Text('A carregar...');
        });
  }

  Future<Widget> buildMain() async {
    return DefaultTabController(
      length: SessionService.length == 0 ? 1 : SessionService.length,
      child: Scaffold(
        drawer: NavDrawerView(),
        appBar: AppBar(
          title: Text('Transações'),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                tooltip: 'Refresh',
                onPressed: () {
                  setState(() {});
                })
          ],
          bottom: TabBar(
            tabs: buildTabs(),
          ),
        ),
        body: TabBarView(
          children: buildTabContent()
        ),
      ),
    );

    //     Container(
    //   height: double.maxFinite,
    //   child: DefaultTabController(
    //     length: 2,
    //     child: TabBar(tabs: [
    //       Tab(text: "1111111"),
    //       Tab(text: "2222222")
    //     ])

    //   )
    // );
  }

  buildColumn(CardService card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
           alignment: Alignment.center,
           width: double.maxFinite,
           height: 100,
           color: Colors.indigo,
          child: FilterView(
            cardService: card,
            onUpdate: () {
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: Container(
              width: double.maxFinite,
              color: Colors.blue[50],
              child: CardTransactionsView(
                cardService: card
              )
          )
        ),
        Container(
          alignment: Alignment.center,
          width: double.maxFinite,
          padding: EdgeInsets.all(5),
          color: Colors.blue[50],
          child: Card(
              color: Colors.indigo,
              child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.maxFinite,
                  child: CardBalanceView(
                    cardService: card
                  )
              )
          )
        )
      ]
    );
  }

  List<Widget> buildTabs() {
    List<Widget> tabs = new List();
    if (SessionService.length > 0) {
      for (var card in SessionService.cards) {
        tabs.add(Tab(text: card.cardInfo.name));
      }
    } else {
      tabs.add(Tab(text: "Nenhum cartão registado"));
    }
    return tabs;
  }

  buildTabContent() {
    List<Widget> tabs = new List();
    if (SessionService.length > 0) {
      for (var card in SessionService.cards) {
        tabs.add(buildColumn(card));
      }
    } else {
      tabs.add(Text("Nenhum cartão registado"));
    }
    return tabs;
  }
}
