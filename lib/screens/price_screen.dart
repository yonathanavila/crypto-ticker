import 'package:cypto_ticker/components/ReusableCard.dart';
import 'package:cypto_ticker/services/ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cypto_ticker/utilities/coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  late String btcPrice = '';
  late String ethPrice = '';
  late String ltcPrice = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI();
  }

  List<Text> getPickerItems() {
    List<Text> dropdownItems = [];
    for (String currency in currenciesList) {
      dropdownItems.add(Text(currency));
    }
    return dropdownItems;
  }

  void updateUI({String? newCurrency}) async {
    if (newCurrency != null) {
      selectedCurrency = newCurrency;
    }

    CryptoTicker cryptoTicker = CryptoTicker();

    final futures = [
      cryptoTicker.getCryptoPrice('bitcoin', selectedCurrency),
      cryptoTicker.getCryptoPrice('ethereum', selectedCurrency),
      cryptoTicker.getCryptoPrice('litecoin', selectedCurrency),
    ];

    final results = await Future.wait(futures);
    var btcPriceValue = results[0]['bitcoin'][selectedCurrency.toLowerCase()];
    var ethPriceValue = results[1]['ethereum'][selectedCurrency.toLowerCase()];
    var ltcPriceValue = results[2]['litecoin'][selectedCurrency.toLowerCase()];

    setState(() {
      btcPrice = btcPriceValue is int
          ? btcPriceValue.toString()
          : btcPriceValue.toStringAsFixed(2);
      ethPrice = ethPriceValue is int
          ? ethPriceValue.toString()
          : ethPriceValue.toStringAsFixed(2);
      ltcPrice = ltcPriceValue is int
          ? ltcPriceValue.toString()
          : ltcPriceValue.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ReusableCard(
                      labelText: '1 BTC = $btcPrice $selectedCurrency'),
                  ReusableCard(
                      labelText: '1 ETH = $ethPrice $selectedCurrency'),
                  ReusableCard(
                      labelText: '1 LTC = $ltcPrice $selectedCurrency'),
                ],
              )),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: CupertinoPicker(
                itemExtent: 32.0,
                onSelectedItemChanged: (value) {
                  selectedCurrency = currenciesList[value];
                  updateUI(newCurrency: selectedCurrency);
                },
                children: getPickerItems(),
              ))
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
