import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:chiraag_app_backend_client/src/session_data.dart';

import 'globals.dart';
import 'models/models.dart';

class OrderServices {
  const OrderServices(this._sessionData);

  Future<List<Order>> getOrders() async {
    const Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, String> queryParameters = <String, String>{'purchasedBy': _sessionData.user!};
    Uri uri = Uri.parse('${Globals.instance.host}/Orders/GetOrdersPurchasedBy').replace(queryParameters: queryParameters);
    final http.Response response = await http.get(uri, headers: headers);

    if(response.statusCode == 404)
      return <Order>[];

    final List<dynamic> ordersJson = jsonDecode(response.body);
    final List<Order> r = ordersJson.map<Order>((json) => Order.fromJson(json)).toList();
    return r;
  }

  Future<Order> getOrderForProduct(String product) async {
    const Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, String> queryParameters = <String, String>{'product': product};
    Uri uri = Uri.parse('${Globals.instance.host}/Orders/GetOrderForProduct').replace(queryParameters: queryParameters);
    final http.Response response = await http.get(uri, headers: headers);

    if(response.statusCode == 404)
      throw HttpException('Status code ${response.statusCode} - Order not found', uri: uri);

    final Map<String, dynamic> responseBodyJson = jsonDecode(response.body);
    final Order r = Order.fromJson(responseBodyJson);
    return r;
  }

  Future<Order> confirmBid(final String product, final String bidder, String deliverTo) async {
    const Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, dynamic> bodyJson = <String, dynamic>{
      'product': product,
      'bidder': bidder,
      'deliverTo': deliverTo
    };    
    Uri uri = Uri.parse('${Globals.instance.host}/Orders/GetOrders');
    final http.Response response = await http.post(uri, headers: headers, body: jsonEncode(bodyJson));    

    final Map<String, dynamic> responseBodyJson = jsonDecode(response.body);
    final Order r = Order.fromJson(responseBodyJson);
    return r;
  }

  Future<Order> completeCheckout(final String product, final Address address, final String contactNumber) async {
    const Map<String, String> headers = <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    final Map<String, dynamic> bodyJson = <String, dynamic>{
      'product': product,
      'address': address.toString(),
      'contactNumber': contactNumber
    };

    final Uri url = Uri.parse('${Globals.instance.host}/Orders/CompleteCheckout');
    final http.Response response = await http.post(url, headers: headers, body: jsonEncode(bodyJson));

    if(response.statusCode < 200 || response.statusCode > 299)
      throw HttpException('Confirming payment for product $product failed');

    final Map<String, dynamic> responseBodyJson = jsonDecode(response.body);

    return Order.fromJson(responseBodyJson);
  }



  final SessionData _sessionData;  
}