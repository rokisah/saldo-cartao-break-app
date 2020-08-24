import 'package:break_balance/services/card_service.dart';
import 'package:flutter/material.dart';
import 'package:break_balance/views/widgets/note_text.dart';

class FilterView extends StatelessWidget {
  final VoidCallback onUpdate;
  final CardService cardService;
  FilterView({this.onUpdate, this.cardService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: buildFilters(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          }
          return Text('A carregar...');
        });
  }

  Future<Widget> buildFilters() async {
    Map<String, String> cardMap = await cardService.getCards();
    Map<String, String> periodMap = await cardService.getPeriods();
    List<DropdownMenuItem<String>> cardList = new List();
    if (cardMap != null) {
      for (var card in cardMap.entries) {
        cardList.add(DropdownMenuItem(
            child: NoteText(card.key, color: Colors.blue[50]),
            value: card.value));
      }
      cardService.selectedCard =
          cardService.selectedCard ?? cardMap.values.first;
    }
    List<DropdownMenuItem<String>> periodList = new List();
    if (periodMap != null) {
      for (var period in periodMap.entries) {
        periodList.add(new DropdownMenuItem(
            child: NoteText(period.key, color: Colors.blue[50]),
            value: period.value));
      }
      cardService.selectedPeriod =
          cardService.selectedPeriod ?? periodMap.values.first;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            NoteText('Cartão:    ',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue[50]),
            DropdownButton(
                dropdownColor: Colors.indigo,
                value: cardService.selectedCard,
                items: cardList,
                onChanged: changedDropDownCardItem),
          ],
        ),
        Row(
          children: [
            NoteText('Período:  ',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue[50]),
            DropdownButton(
                dropdownColor: Colors.indigo,
                value: cardService.selectedPeriod,
                items: periodList,
                onChanged: changedDropDownPeriodItem)
          ],
        )
      ],
    );
  }

  void changedDropDownCardItem(String selectedCard) {
    cardService.selectedCard = selectedCard;
    onUpdate();
  }

  void changedDropDownPeriodItem(String selectedPeriod) {
    cardService.selectedPeriod = selectedPeriod;
    onUpdate();
  }
}
