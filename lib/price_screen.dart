import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:coin_tracker/networking.dart';

const apikey = "CDC972ED-99D3-4417-8248-DAF99F2231D0";

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  var btcValue;
  var ethValue;
  var ltcValue;
  String btc,eth,ltc;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrency('USD');
    print("in init");
  }

  Future<dynamic> getCurrency(String country) async{

    NetworkHelper networkHelperBTC = NetworkHelper("https://rest.coinapi.io/v1/exchangerate/BTC/$country?apikey=$apikey");
    NetworkHelper networkHelperETH = NetworkHelper("https://rest.coinapi.io/v1/exchangerate/ETH/$country?apikey=$apikey");
    NetworkHelper networkHelperLTC = NetworkHelper("https://rest.coinapi.io/v1/exchangerate/LTC/$country?apikey=$apikey");
    var coindataBTC = await networkHelperBTC.getData();
    var coindataETH = await networkHelperETH.getData();
    var coindataLTC = await networkHelperLTC.getData();

    setState(() {
      selectedCurrency = country;
      btcValue = coindataBTC['rate'];
      ethValue = coindataETH['rate'];
      ltcValue = coindataLTC['rate'];
      btc = btcValue.toString();
      eth = ethValue.toString();
      ltc = ltcValue.toString();
    });

  }


  List<DropdownMenuItem> getDropDownItems(){
    List<DropdownMenuItem<String>> items = [];
    for(String curr in currenciesList){
      var newItem = DropdownMenuItem(
        value: curr,
        child: Text(curr),
      );
      items.add(newItem);
    }
    return items;
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      '1 BTC = $btc $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
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
                      '1 ETH = $eth $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
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
                      '1 LTC = $ltc $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
                value: selectedCurrency,
                items: getDropDownItems(),
                onChanged: (value){
                  selectedCurrency = value;
                  getCurrency(selectedCurrency);
                }
            ),
          ),
        ],
      ),
    );
  }
}
