import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'HttpService.dart';
import 'Models.dart';
import 'coin_data.dart';
import 'model/CoinApiModels.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

var seciliParaBirimi = "TL";
ExchangerateResult exchangerateResultBtc = ExchangerateResult('1', '1', '1', 1);
ExchangerateResult exchangerateResultEth = ExchangerateResult('1', '1', '1', 1);
ExchangerateResult exchangerateResultLtc = ExchangerateResult('1', '1', '1', 1);

class _PriceScreenState extends State<PriceScreen> {
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
          CoinWidget(exchangerateResultBtc),
          CoinWidget(exchangerateResultEth),
          CoinWidget(exchangerateResultLtc),
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

  var  exchangerateResultBtcTmp = await paraBirimiGetir(seciliParaBirimi, 'BTC');
  var  exchangerateResultEthTmp = await paraBirimiGetir(seciliParaBirimi, 'ETH');
  var  exchangerateResultLtcTmp = await paraBirimiGetir(seciliParaBirimi, 'LTC');

    setState(() {
      exchangerateResultBtc= exchangerateResultBtcTmp;
      exchangerateResultEth= exchangerateResultEthTmp;
      exchangerateResultLtc= exchangerateResultLtcTmp;
    });
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
