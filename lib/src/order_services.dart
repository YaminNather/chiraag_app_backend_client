import 'dart:convert';

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

  final SessionData _sessionData;  
}