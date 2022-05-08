import 'dart:convert';
import 'dart:io';

import 'globals.dart';
import '../chiraag_app_backend_client.dart';
import 'package:http/http.dart' as http;

import 'session_data.dart';

class BidServices {
  const BidServices(this._sessionData);

  Future<Bid> placeBid(final String productId, final double amount) async {
    const Map<String, String> headers = <String, String>{
      'Content-Type' : 'application/json'
    };
    
    final Uri uri = Uri.parse('${Globals.instance.host}/BidServices/PlaceBid');
    final String requestBody = jsonEncode(
      <String, dynamic>{
        'bidder': _sessionData.user,
        'productId': productId,
        'amount': amount
      }
    );
    
    final http.Response response = await http.post(uri, headers: headers, body: requestBody);

    final Bid r = Bid.fromJson(jsonDecode(response.body));
    return r;
  }

  Future<void> removeBid(final String id) async {
    const Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final String requestBody = jsonEncode( <String, String>{ 'productId': id } );
    final Uri uri = Uri.parse('${Globals.instance.host}/BidServices/RemoveBid');
    await http.post(uri, headers: headers, body: requestBody);
  }

  Future<List<Bid>> getBidsForProduct(final String productId) async {
    const Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, String> queryParameters = <String, String>{'productId': productId};
    Uri uri = Uri.parse('${Globals.instance.host}/BidServices/GetBidsForProduct').replace(queryParameters: queryParameters);
    final http.Response response = await http.get(uri, headers: headers);

    if(response.statusCode == 404)
      return <Bid>[];

    final List<dynamic> bidsJson = jsonDecode(response.body);
    final List<Bid> r = bidsJson.map<Bid>((json) => Bid.fromJson(json)).toList();
    return r;
  }

  Future<List<BidWithProduct>> getBidsOfUser() async {
    const Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, String> queryParameters = <String, String>{'userId': _sessionData.user!};
    Uri uri = Uri.parse('${Globals.instance.host}/BidServices/GetBidsOfUser').replace(queryParameters: queryParameters);
    final http.Response response = await http.get(uri, headers: headers);

    if(response.statusCode == 404)
      return <BidWithProduct>[];

    final List<dynamic> bidsJson = jsonDecode(response.body);
    final List<BidWithProduct> r = bidsJson.map<BidWithProduct>((json) => BidWithProduct.fromJson(json)).toList();
    return r;
  }

  Future<Order> acceptBid(final String bidder, final String product) async {
    const Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, dynamic> bodyJson = <String, dynamic>{
      'product': product,
      'bidder': bidder
    };    
    Uri uri = Uri.parse('${Globals.instance.host}/BidServices/AcceptBid');
    final http.Response response = await http.post(uri, headers: headers, body: jsonEncode(bodyJson));    

    final Map<String, dynamic> responseBodyJson = jsonDecode(response.body);
    final Order r = Order.fromJson(responseBodyJson);
    return r;
  }


  final SessionData _sessionData;
}