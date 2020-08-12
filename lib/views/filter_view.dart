import 'package:saldo_cartao_break/services/card_service.dart';
import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/views/widgets/note_text.dart';

class FilterView extends StatelessWidget {
  final VoidCallback onUpdate;

  const FilterView({Key key, this.onUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: buildFilters(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          }
          return Text('loading...');
        });
  }

  Future<Widget> buildFilters() async {
    Map<String, String> cardMap = await CardService.getCards();
    Map<String, String> periodMap = await CardService.getPeriods();
    List<DropdownMenuItem<String>> cardList = new List();
    for (var card in cardMap.entries) {
      cardList.add(new DropdownMenuItem(child: NoteText(card.key), value: card.value));
    }
    CardService.selectedCard = CardService.selectedCard ?? cardMap.values.first;
    List<DropdownMenuItem<String>> periodList = new List();
    for (var period in periodMap.entries) {
      periodList.add(
          new DropdownMenuItem(child: NoteText(period.key), value: period.value));
    }
    CardService.selectedPeriod =
        CardService.selectedPeriod ?? periodMap.values.first;
    return Column(
      // mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            NoteText(
              'Cartão:    ',
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
            DropdownButton(
                value: CardService.selectedCard,
                items: cardList,
                onChanged: changedDropDownCardItem
            ),
          ],
        ),
        Row(
          children: [
            NoteText(
              'Período:  ',
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
            DropdownButton(
                value: CardService.selectedPeriod,
                items: periodList,
                onChanged: changedDropDownPeriodItem
            )
          ],
        )
      ],
    );
  }

  void changedDropDownCardItem(String selectedCard) {
    CardService.selectedCard = selectedCard;
    onUpdate();
  }

  void changedDropDownPeriodItem(String selectedPeriod) {
    CardService.selectedPeriod = selectedPeriod;
    onUpdate();
  }
}
