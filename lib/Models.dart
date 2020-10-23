import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'model/CoinApiModels.dart';

class CoinWidget extends StatelessWidget {
  ExchangerateResult exchangerateResult;

  CoinWidget(this.exchangerateResult);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${exchangerateResult.asset_id_base} = ${exchangerateResult.rate} ${exchangerateResult.asset_id_quote}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
