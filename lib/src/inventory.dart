import 'dart:convert';

import 'globals.dart';
import 'package:http/http.dart' as http;

import 'models/models.dart';
import 'session_data.dart';

class Inventory {
  const Inventory(this.sessionData);

  Future<Product?> getProduct(final String id) async {
    final http.Response response = await http.get(Uri.parse('${Globals.instance.host}/Inventory/GetProduct?id=$id'));
    
    return Product.fromJson(jsonDecode(response.body));
  }

  Future<List<Product>> getAllProducts() async {
    final Uri uri = Uri.parse('${Globals.instance.host}/Inventory/GetAllProducts');
    final http.Response response = await http.get(uri);

    final List<dynamic> productsJson = jsonDecode(response.body);

    return productsJson.map<Product>((element) => new Product.fromJson(element)).toList();
  }

  Future<Product> sellBid(final String productId, final double amount) async {
    final Map<String, String> headers = <String, String>{
      'Content-type': 'application/json'
    };

    final Uri uri = Uri.parse('${Globals.instance.host}/Inventory/SellBid');
    Map<String, dynamic> bodyJson = <String, dynamic>{
      'seller': sessionData.user!,
      'product': productId,
      'initialPrice': amount
    };
    final http.Response response = await http.post(uri, body: jsonEncode(bodyJson), headers: headers);

    final Map<String, dynamic> productJson = jsonDecode(response.body);
    final Product r = Product.fromJson(productJson);
    return r;
  }

  Future<List<SoldItem>> getAllSellersProducts() async {
    const Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, String> queryParameters = <String, String>{'seller': sessionData.user!};
    Uri uri = Uri.parse('${Globals.instance.host}/Inventory/GetAllSellersProducts');
    uri = uri.replace(queryParameters: queryParameters);
    final http.Response response = await http.get(uri, headers: headers);

    if(response.statusCode == 404)
      return <SoldItem>[];

    final List<dynamic> bidsJson = jsonDecode(response.body);
    final List<SoldItem> r = bidsJson.map<SoldItem>((json) => SoldItem.fromJson(json)).toList();
    return r;
  }

  Future<List<Product>> getLatestArrivals() async {
    const Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };    
    Uri uri = Uri.parse('${Globals.instance.host}/Inventory/GetLatestArrivals');    
    final http.Response response = await http.get(uri, headers: headers);

    if(response.statusCode == 404)
      throw Exception();

    final List<dynamic> bidsJson = jsonDecode(response.body);
    final List<Product> r = bidsJson.map<Product>((json) => Product.fromJson(json)).toList();
    return r;
  }

  Future<Product> addProduct(String name, double initialPrice, String description, int size, String mainImage, List<String>? images) async {
    final Map<String, String> headers = <String, String>{
      'Content-type': 'application/json'
    };

    final Uri uri = Uri.parse('${Globals.instance.host}/Inventory/AddProduct');
    Map<String, dynamic> bodyJson = <String, dynamic>{
      'seller': sessionData.user!,
      'name': name,
      'initialPrice': initialPrice,
      'description': description,
      'size': size,
      'mainImage': mainImage,
      'images': images
    };
    final http.Response response = await http.post(uri, body: jsonEncode(bodyJson), headers: headers);

    final Map<String, dynamic> responseBodyJson = jsonDecode(response.body);
    final Product product = Product.fromJson(responseBodyJson);
    return product;
  }
  

  
  final SessionData sessionData;
}