import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:saldo_cartao_break/models/card_info.dart';
import 'package:saldo_cartao_break/models/card_transaction.dart';

class CardService {
  static http.Client _session;
  static Document _data;
  static String _viewState;
  static String _cookie;
  static String _jSessionId;
  static String _smSession;
  static String _preHa;
  static bool initialized = false;
  static String selectedCard;
  static String selectedPeriod;
  static CardInfo cardInfo;

  static getCardDataPeriod(String card, String movementDates) async {
    if (!initialized) {
      await _createSession();
    }

    final response = await _session.post(
        'https://portalprepagos.cgd.pt/portalprepagos/private/saldoMovimentos.seam',
        headers: {
          'Cookie': _jSessionId + _smSession + ';' + _preHa
        },
        body: {
          'consultaMovimentosCartoesPrePagos':
              'consultaMovimentosCartoesPrePagos',
          'consultaMovimentosCartoesPrePagos:ignoreFieldsComp': '',
          'consultaMovimentosCartoesPrePagos:selectedCard': '10136294096',
          'consultaMovimentosCartoesPrePagos:extractDates': movementDates,
          'javax.faces.ViewState': _viewState
        });
    if (response.statusCode == 200) {
      _data = parse(response.body);
    } else if (response.statusCode == 302) {
      print("302");
      print(response.headers["location"]);
      await _createSession();
      return getCardDataPeriod(card, movementDates);
    }
  }

  static getCardData() async {
    if (!initialized) {
      await _createSession();
      if (_jSessionId == null || _smSession == null || _preHa == null) {
        return;
      }
    }

    final response = await _session.get(
        'https://portalprepagos.cgd.pt/portalprepagos/private/saldoMovimentos.seam',
        headers: {'Cookie': _jSessionId + _smSession + ';' + _preHa});
    if (response.statusCode == 200) {
      _data = parse(response.body);
      initialized = true;
    }
  }

  static Future initialize() async {
    if (!initialized && cardInfo != null) {
      await getCardData();
    }
  }

  static _createSession() async {
    _session = http.Client();
    var home = await _session.get(
        'https://portalprepagos.cgd.pt/portalprepagos/login.seam?sp_param=PrePago');
    _cookie = home.headers['set-cookie'];
    _jSessionId = _cookie.substring(0, 53);
    var login = await _session.post(
        'https://portalprepagos.cgd.pt/portalprepagos/auth/forms/login.fcc',
        body: {
          'target': '/portalprepagos/private/home.seam',
          'username': 'PPP' + cardInfo.registerCode,
          'userInput': cardInfo.registerCode,
          'passwordInput': '*****',
          'loginForm:submit': 'Entrar',
          'password': cardInfo.accessCode
        });
    _smSession = login.headers['set-cookie'].split(';')[5].substring(8);
    if (login.headers['set-cookie'].split(';').length < 8) {
      return;
    }
    _preHa = login.headers['set-cookie'].split(';')[7].substring(8);
    final responseGet = await _session.get(
        'https://portalprepagos.cgd.pt/portalprepagos/private/saldoMovimentos.seam',
        headers: {'Cookie': _jSessionId + _smSession + ';' + _preHa});
    var documento = parse(responseGet.body);
    if (documento.getElementById('consultaMovimentosCartoesPrePagos') == null) {
      return;
    }
    _viewState = documento
        .getElementById('consultaMovimentosCartoesPrePagos')
        .getElementsByTagName('input')[3]
        .attributes
        .entries
        .elementAt(3)
        .value;
  }

  static Future<List<CardTransaction>> getTransactions() async {
    List<CardTransaction> transactions = new List();
    if (!initialized) {
      return null;
    }
    if (CardService.selectedPeriod != null &&
        CardService.selectedPeriod != 'Corrente') {
      await getCardDataPeriod('10136294096', CardService.selectedPeriod);
    }
    if (_data != null) {
      var rows =
          _data.getElementsByTagName('table')[0].getElementsByTagName('tr');
      for (var i = 1; i < rows.length; i++) {
        var row = rows[i];
        var cols = row.getElementsByTagName('td');
        if (cols.length == 5) {
          transactions.add(CardTransaction(
            date: new DateFormat("d-M-y").parse(cols[0].text),
            valueDate: new DateFormat("d-M-y").parse(cols[1].text), 
            description: cols[2].text,
            debit: cols[3].text.trim().isEmpty ? 0: double.parse(cols[3].text.replaceAll('.', '').replaceAll(',', '.')),
            credit: cols[4].text.trim().isEmpty ? 0: double.parse(cols[4].text.replaceAll('.', '').replaceAll(',', '.'))
            )
          );
        }
      }
    }
    return transactions;
  }

  static Future<String> getBalance() async {
    if (!initialized) {
      return null;
    }
    if (_data == null) {
      await getCardData();
    }

    if (_data != null) {
      var saldos = _data.getElementsByClassName('valor');
      if (saldos.length > 0) {
        var saldo = saldos[0].firstChild;
        if (saldo != null) {
          return 'Saldo: ' + saldo.text + ' €';
        }
      }
    }
    return 'Saldo: 0,00 €';
  }

  static Future<Map<String, String>> getPeriods() async {
    Map<String, String> periodMap = new Map();
    if (!initialized) {
      return null;
    }
    if (_data == null) {
      await getCardData();
    }
    if (_data != null) {
      var combos = _data.getElementsByClassName('componentsComboBox');
      if (combos.length > 0) {
        var periods = combos[1];
        if (periods != null) {
          for (var period in periods.children) {
            periodMap[period.text] = period.attributes.values.elementAt(0);
          }
        }
      }
    }

    return periodMap;
  }

  static Future<Map<String, String>> getCards() async {
    Map<String, String> cardMap = new Map();
    if (!initialized) {
      return null;
    }
    if (_data == null) {
      await getCardData();
    }
    if (_data != null) {
      var combos = _data.getElementsByClassName('componentsComboBox');
      if (combos.length > 0) {
        var cards = combos[0];
        if (cards != null) {
          for (var card in cards.children) {
            cardMap[card.text] = card.attributes.values.elementAt(0);
          }
        }
      }
    }
    return cardMap;
  }
}
