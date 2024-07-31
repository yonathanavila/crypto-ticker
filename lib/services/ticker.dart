import 'package:cypto_ticker/services/network.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var apiKey = dotenv.env['API_KEY'] ?? '';
const baseURL = 'https://api.coingecko.com/api/v3/simple/price';

class CryptoTicker {
  late double price;

  Future<dynamic> getCryptoPrice(String assetId, String assetQuote) async {
    Map<String, String> headers = <String, String>{
      'x-cg-demo-api-key': apiKey,
    };

    NetworkHelper networkHelper = NetworkHelper(
        url: '$baseURL?ids=$assetId&vs_currencies=$assetQuote',
        headers: headers);

    var response = await networkHelper.getData();
    print(response);
    return response;
  }
}
