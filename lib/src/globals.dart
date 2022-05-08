import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class Globals {
  const Globals._(this.host);

  static Future<void> initialize() async {
    const String port = '5296';
    final String host;
    if(Platform.isAndroid) {
      DeviceInfoPlugin plugin = DeviceInfoPlugin();
      AndroidDeviceInfo deviceInfo = await plugin.androidInfo;

      if(deviceInfo.isPhysicalDevice == true)
        host = 'http://192.168.1.22:$port';
      else
        host = 'http://10.0.2.2:$port';
    }
    else
      host = 'http://localhost:$port';
    
    
    _instance = Globals._(host);
  }

  static Globals get instance => _instance!;


  static Globals? _instance;
  final String host;
}