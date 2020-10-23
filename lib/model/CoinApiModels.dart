class ExchangerateResult {
  String time;
  String asset_id_base;
  String asset_id_quote;
  int rate;

  ExchangerateResult(
      this.time, this.asset_id_base, this.asset_id_quote, this.rate);

  factory ExchangerateResult.fromJson(Map<String, dynamic> json) {


    var rate = 0 ;

    return ExchangerateResult(
      json['time'],
      json['asset_id_base'],
      json['asset_id_quote'],
      json['rate'] is int  ? json['rate']  :  (json['rate']).round() ,
    );
  }


}
