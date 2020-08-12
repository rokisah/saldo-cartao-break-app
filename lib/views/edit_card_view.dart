import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/models/card_info.dart';
import 'package:saldo_cartao_break/services/firestore_service.dart';
import 'package:saldo_cartao_break/views/shared/ui_helpers.dart';
import 'package:saldo_cartao_break/views/widgets/input_field.dart';
import 'package:saldo_cartao_break/views/widgets/busy_button.dart';
import 'package:saldo_cartao_break/services/sign_in_service.dart'
    as SigninService;

class EditCardView extends StatefulWidget {
  @override
  _EditCardViewState createState() => _EditCardViewState();
}

class _EditCardViewState extends State<EditCardView> {
  final nameController = TextEditingController();
  final registerCodeController = TextEditingController();
  final accessCodeController = TextEditingController();
  CardInfo card;
  @override
  Widget build(BuildContext context) {
    card = ModalRoute.of(context).settings.arguments;
    if (card != null) {
      nameController.text = card.name;
      registerCodeController.text = card.registerCode;
      accessCodeController.text = card.accessCode;
    }
    bool saving = false;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Edit card'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            verticalSpaceMedium,
            InputField(
              placeholder: 'Card Name',
              controller: nameController,
            ),
            verticalSpaceSmall,
            InputField(
              placeholder: 'Número de Adesão',
              controller: registerCodeController,
            ),
            verticalSpaceSmall,
            InputField(
              placeholder: 'Código de Acesso',
              password: true,
              controller: accessCodeController,
              additionalNote: 'Password has to be a minimum of 6 characters.',
            ),
            verticalSpaceMedium,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BusyButton(
                  title: 'Gravar',
                  onPressed: () {
                    saving = true;
                    save(nameController.text, registerCodeController.text,
                        accessCodeController.text);
                  },
                  busy: saving,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> save(
      String cardName, String registerCode, String accessCode) async {
    final loggedUser = await SigninService.getLoggedUser();
    if (card != null) {
      card =
          CardInfo(card.id, cardName, loggedUser.uid, registerCode, accessCode);
    } else {
      card = CardInfo(null, cardName, loggedUser.uid, registerCode, accessCode);
    }
    FirestoreService()
        .saveCard(card)
        .whenComplete(() => {Navigator.pop(context)});
  }
}
