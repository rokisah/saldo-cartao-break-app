import 'package:saldo_cartao_break/models/card_info.dart';
import 'package:saldo_cartao_break/repository/card_info_repository.dart';
import 'package:saldo_cartao_break/services/card_service.dart';

class SessionService {
  static List<CardService> cards = new List();

  static int get length {
    return cards == null ? 0 : cards.length;
  }

  static Future<void> addCard(CardInfo card) async {
    CardService cardService = new CardService();
    cardService.cardInfo = card;
    await cardService.initialize();
    cards.add(cardService);
    print("SessionService: " + length.toString());
  }

  static loadCards(String userId) async {
    print("Load cards inicio");
    cards = new List();
    var cardList = await CardInfoRepository().getActiveCard(userId);
    print("Load cardservice length: " + cardList.length.toString());
    if (cardList != null) {
      for (var card in cardList) {
        await addCard(card);
      }
    }
    print("Load cards fim");
  }

  static loadCardService(List<CardInfo> cardList) async {
    cards = new List();
    print("Load cardservice inicio");
    if (cardList != null) {
      for (var card in cardList) {
        if (card.active && card.accessValid) {
          await addCard(card);
        }
      }
    }
    print("Load cardservice fim");
  }
}
