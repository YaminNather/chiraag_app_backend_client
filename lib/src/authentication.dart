import 'dart:convert';
import 'dart:io';

import 'package:chiraag_app_backend_client/src/session_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart';
import 'models/authentication_response.dart';
import 'package:http/http.dart' as http;

class Authentication {
  const Authentication(this._sessionData);

  Future<String> signUp(
    final String username,
    final String email,
    final String password
  ) async {
    Uri uri = Uri.parse('${Globals.instance.host}/Authentication/SignUp');
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, dynamic> bodyJson = <String, dynamic>{
      'Username': username,
      'Email': email,
      'Password': password
    };
    final http.Response response = await http.post(uri, headers: headers, body: jsonEncode(bodyJson));
    
    if(response.statusCode < 200 || response.statusCode > 299)
      throw Exception();

    AuthenticationResponse authenticationResponse = AuthenticationResponse.fromJson(jsonDecode(response.body));
    _sessionData.user = authenticationResponse.id;
    _saveSessionDataLocally();

    return authenticationResponse.id;
  }

  Future<String> loginWithUsername(final String username, final String password) async {
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, dynamic> bodyJson = <String, dynamic>{
      'username': username,
      'password': password
    };
    final Uri uri = Uri.parse('${Globals.instance.host}/Authentication/LoginWithUsername');
    final http.Response response = await http.post(uri, headers: headers, body: jsonEncode(bodyJson));
    
    if(response.statusCode < 200 || response.statusCode > 299)
      throw HttpException(response.reasonPhrase!, uri: uri);

    AuthenticationResponse authenticationResponse = AuthenticationResponse.fromJson(jsonDecode(response.body));
    _sessionData.user = authenticationResponse.id;
    _saveSessionDataLocally();

    return authenticationResponse.id;
  }
  
  Future<String> loginWithEmail(final String email, final String password) async {
    final Uri uri = Uri.parse('${Globals.instance.host}/Authentication/LoginWithEmail');
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, dynamic> bodyJson = <String, dynamic>{
      'Email': email,
      'Password': password
    };
    final http.Response response = await http.post(uri, headers: headers, body: jsonEncode(bodyJson));
    
    if(response.statusCode < 200 || response.statusCode > 299)
      throw HttpException(response.reasonPhrase!, uri: uri);

    AuthenticationResponse authenticationResponse = AuthenticationResponse.fromJson(jsonDecode(response.body));
    _sessionData.user = authenticationResponse.id;
    _saveSessionDataLocally();

    return authenticationResponse.id;
  }

  Future<void> logout() async {
    _sessionData.user = null;
    await _saveSessionDataLocally();
  }

  Future<void> _saveSessionDataLocally() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('session_data', jsonEncode(_sessionData.toJson()));
  }

  Future<String?> getCurrentUser() async {
    return _sessionData.user;
  }  



  final SessionData _sessionData;
}