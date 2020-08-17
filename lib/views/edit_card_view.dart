import 'package:flutter/material.dart';
import 'package:saldo_cartao_break/models/card_info.dart';
import 'package:saldo_cartao_break/repository/card_info_repository.dart';
import 'package:saldo_cartao_break/routing/routing_constants.dart';
import 'package:saldo_cartao_break/views/shared/ui_helpers.dart';
import 'package:saldo_cartao_break/views/widgets/boolean_editing_controller.dart';
import 'package:saldo_cartao_break/views/widgets/checkbox_field.dart';
import 'package:saldo_cartao_break/views/widgets/input_field.dart';
import 'package:saldo_cartao_break/views/widgets/busy_button.dart';
import 'package:saldo_cartao_break/services/sign_in_service.dart'
    as SigninService;
import 'package:saldo_cartao_break/views/widgets/note_text.dart';
import 'package:saldo_cartao_break/views/widgets/switch_field.dart';

class EditCardView extends StatefulWidget {
  @override
  _EditCardViewState createState() => _EditCardViewState();
}

class _EditCardViewState extends State<EditCardView> {
  final nameController = TextEditingController();
  final registerCodeController = TextEditingController();
  final accessCodeController = TextEditingController();
  final BooleanEditingController activeController = BooleanEditingController();
  final BooleanEditingController validatedController =
      BooleanEditingController();
  CardInfo card;
  @override
  Widget build(BuildContext context) {
    card = ModalRoute.of(context).settings.arguments;
    if (card != null) {
      nameController.text = card.name;
      registerCodeController.text = card.registerCode;
      accessCodeController.text = card.accessCode;
      activeController.value = card.active;
      validatedController.value = card.accessValid;
    }
    bool saving = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Editar cartão'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
              height: 480,
              child: Card(
                  elevation: 5,
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          NoteText("Dados do cartão",
                              fontSize: 20, fontWeight: FontWeight.bold),
                          verticalSpaceMedium,
                          InputField(
                            placeholder: 'Card Name',
                            controller: nameController,
                          ),
                          verticalSpaceSmall,
                          InputField(
                              placeholder: 'Número de Adesão',
                              controller: registerCodeController,
                              textInputType: TextInputType.number),
                          verticalSpaceSmall,
                          InputField(
                              placeholder: 'Código de Acesso',
                              password: true,
                              controller: accessCodeController,
                              textInputType: TextInputType.number),
                          SwitchField(
                              text: "Ativo", controller: activeController),
                          CheckboxField(
                            text: "Validado",
                            controller: validatedController,
                            onChanged: (value) {
                              if (value) {
                                showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          validatedController.value = false;
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        child: NoteText("Cancelar")),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: NoteText("Validar"))
                                    ],
                                    title: NoteText(
                                      "Alerta",
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    content: NoteText("Se tentares validar este cartão com as credenciais incorretas, " +
                                                      "seu acesso podeá ser bloqueado.\n\n" + 
                                                      "Confira atentamente as informações digitadas."
                                      ),
                                  )
                                  
                                );
                              }
                            },
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
                                  save(
                                      nameController.text,
                                      registerCodeController.text,
                                      accessCodeController.text);
                                },
                                busy: saving,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: BusyButton(
                                    enabled: card != null,
                                    title: 'Apagar',
                                    onPressed: () {
                                      saving = true;
                                      confirmDelete(
                                          nameController.text,
                                          registerCodeController.text,
                                          accessCodeController.text);
                                    },
                                    busy: saving,
                                  ))
                            ],
                          )
                        ],
                      ))))),
    );
  }

  Future<void> save(
      String cardName, String registerCode, String accessCode) async {
    final loggedUser = await SigninService.getLoggedUser();
    if (card != null) {
      card = CardInfo(card.id, cardName, loggedUser.uid, registerCode,
          accessCode, validatedController.value, activeController.value);
    } else {
      card = CardInfo(null, cardName, loggedUser.uid, registerCode, accessCode,
          validatedController.value, activeController.value);
    }
    CardInfoRepository().save(card).whenComplete(() {
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, ManageCardsViewRoute);
    });
  }

  confirmDelete(String cardName, String registerCode, String accessCode) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: NoteText("Confirma apagar o cartão?",
                fontWeight: FontWeight.bold, fontSize: 16),
            content: NoteText("Esta ação não poderá ser desfeita"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: NoteText("Cancelar")),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    delete(cardName, registerCode, accessCode);
                  },
                  child: NoteText("Apagar"))
            ],
          );
        });
  }

  Future<void> delete(
      String cardName, String registerCode, String accessCode) async {
    CardInfoRepository().delete(card.id).whenComplete(() {
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, ManageCardsViewRoute);
    });
  }
}
