import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'coin_data.dart';
import 'model/CoinApiModels.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

var seciliParaBirimi = "TL";
ExchangerateResult exchangerateResult = ExchangerateResult('1', '1', '1', 1);

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${exchangerateResult.rate} ${exchangerateResult.asset_id_quote}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getiPickker(),
          ),
        ],
      ),
    );
  }

  Widget iosPicker() {
    List<Widget> items = new List();

    for (int i = 0; i < currenciesList.length; ++i) {
      var paraBirimi = currenciesList[i];
      items.add(
        Text(paraBirimi),
      );
    }

    return CupertinoPicker(
        itemExtent: 35,
        onSelectedItemChanged: (selectedIndex) {
          paraBirimmiSecildi(currenciesList[selectedIndex]);
        },
        children: items);
  }

  Future<void> paraBirimmiSecildi(String paraBirimi) async {
    final response = await get(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$seciliParaBirimi?apikey=F1B80F17-2AF1-4C05-ADA5-7C7684CBCAD8');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      setState(() {
        exchangerateResult =
            ExchangerateResult.fromJson(jsonDecode(response.body));
      });


    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Widget androidDropDown() {
    List<DropdownMenuItem> items = new List();

    for (int i = 0; i < currenciesList.length; ++i) {
      var paraBirimi = currenciesList[i];

      items.add(DropdownMenuItem(
        child: Text(paraBirimi),
        value: paraBirimi,
      ));
    }

    return DropdownButton(
      items: items,
      value: seciliParaBirimi,
      onChanged: (value) {
        setState(() {
          seciliParaBirimi = value;
          paraBirimmiSecildi(seciliParaBirimi);
        });
      },
    );
  }

  Widget getiPickker() {
    if (Platform.isAndroid) {
      return androidDropDown();
    } else if (Platform.isIOS) {
      return iosPicker();
    }
  }

  Future<void> load() async {
   await paraBirimmiSecildi('TL');
  }
}
