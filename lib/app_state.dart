import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_printerDevice')) {
        try {
          _printerDevice =
              jsonDecode(prefs.getString('ff_printerDevice') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _posMode = prefs.getString('ff_posMode') ?? _posMode;
    });
    _safeInit(() {
      _targetPlatform = prefs.getString('ff_targetPlatform') ?? _targetPlatform;
    });
    _safeInit(() {
      _isPrinterConnected =
          prefs.getBool('ff_isPrinterConnected') ?? _isPrinterConnected;
    });
    _safeInit(() {
      _printerName = prefs.getString('ff_printerName') ?? _printerName;
    });
    _safeInit(() {
      _paperSize = prefs.getString('ff_paperSize') ?? _paperSize;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  dynamic _printerDevice;
  dynamic get printerDevice => _printerDevice;
  set printerDevice(dynamic value) {
    _printerDevice = value;
    prefs.setString('ff_printerDevice', jsonEncode(value));
  }

  String _posMode = '';
  String get posMode => _posMode;
  set posMode(String value) {
    _posMode = value;
    prefs.setString('ff_posMode', value);
  }

  String _targetPlatform = '';
  String get targetPlatform => _targetPlatform;
  set targetPlatform(String value) {
    _targetPlatform = value;
    prefs.setString('ff_targetPlatform', value);
  }

  bool _isPrinterConnected = false;
  bool get isPrinterConnected => _isPrinterConnected;
  set isPrinterConnected(bool value) {
    _isPrinterConnected = value;
    prefs.setBool('ff_isPrinterConnected', value);
  }

  String _printerName = '';
  String get printerName => _printerName;
  set printerName(String value) {
    _printerName = value;
    prefs.setString('ff_printerName', value);
  }

  String _printerIndex = '';
  String get printerIndex => _printerIndex;
  set printerIndex(String value) {
    _printerIndex = value;
  }

  String _paperSize = '';
  String get paperSize => _paperSize;
  set paperSize(String value) {
    _paperSize = value;
    prefs.setString('ff_paperSize', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
