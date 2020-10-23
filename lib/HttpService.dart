
import 'package:http/http.dart';
import 'dart:convert';

import 'model/CoinApiModels.dart';

Future<ExchangerateResult> paraBirimiGetir(String paraBirimi , String coinBirimi) async {
  final response = await get(
      'https://rest.coinapi.io/v1/exchangerate/$coinBirimi/$paraBirimi?apikey=F1B80F17-2AF1-4C05-ADA5-7C7684CBCAD8');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return ExchangerateResult.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
