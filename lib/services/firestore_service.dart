// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:saldo_cartao_break/models/card_info.dart';

// class FirestoreService {
//   final CollectionReference _cardsCollectionReference =
//       Firestore.instance.collection("cardinfo");

  // Future saveCard(CardInfo card) async {
  //   try {
  //     await _cardsCollectionReference.document(card.id).setData(card.toJson());
  //   } catch (e) {
  //     return e.message;
  //   }
  // }

//   Future<List<CardInfo>> getCards(String userId) async {
//     try {
//       QuerySnapshot query = await _cardsCollectionReference
//           .where('userId', isEqualTo: userId)
//           .getDocuments();
//       List<DocumentSnapshot> documents = query.documents;
//       List<CardInfo> cardList = new List();
//       for (var document in documents) {
//         cardList.add(CardInfo.fromDocument(document));
//       }
//       return cardList;
//     } catch (e) {
//       return e.message;
//     }
//   }
// }
