import 'dart:convert';

import 'package:chiraag_app_backend_client/src/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chiraag_app_backend_client.dart';
import 'session_data.dart';

class Client {
  Client._(this._inventory, this._authentication, this._bidServices, this._orderServices);  

  static Future<void> initialize() async {
    await Globals.initialize();

    final SessionData sessionData;
    
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? sessionDataJsonString = sharedPreferences.getString('session_data');
    if(sessionDataJsonString == null)
      sessionData = SessionData();
    else
      sessionData = SessionData.fromJson(jsonDecode(sessionDataJsonString));

    _instance = Client._(
      Inventory(sessionData),
      Authentication(sessionData),
      BidServices(sessionData),
      OrderServices(sessionData)
    );
  }

  Inventory inventory() => _inventory;
  Authentication authentication() => _authentication;
  BidServices bidServices() => _bidServices;
  OrderServices orderServices() => _orderServices;

  static Client get instance {
    Client? r = _instance;
    if(r == null)
      throw NotInitializedError();

    return r;
  }


  final Inventory _inventory;
  final Authentication _authentication;
  final BidServices _bidServices;
  final OrderServices _orderServices;
  
  static Client? _instance;
}

class NotInitializedError extends Error {}