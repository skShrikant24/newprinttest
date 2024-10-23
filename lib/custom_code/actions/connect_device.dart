// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';

Future<bool> connectDevice(dynamic printers, String index) async {
  bool _isConnected = false;
  List<Printer> selectedPrinter = [];
  var printerManager = FlutterThermalPrinter.instance;

  // Determine which printer to connect based on the index and FFAppState
  if (index == "0") {
    selectedPrinter.add(printers);
  } else {
    for (var element in FFAppState().printerDevice) {
      if (FFAppState().posMode.toUpperCase() == "USB") {
        if (FFAppState().targetPlatform == "windows") {
          selectedPrinter.add(Printer.fromJson(element));
        } else {
          if (element["vendorId"] == index) {
            selectedPrinter.add(Printer.fromJson(element));
          }
        }
      } else if (FFAppState().posMode.toUpperCase() == "BLUETOOTH") {
        if (element["address"] == index) {
          selectedPrinter.add(Printer.fromJson(element));
        }
      }
    }
  }

  // Ensure there is a selected printer before attempting to connect
  if (selectedPrinter.isEmpty) return false;

  try {
    switch (selectedPrinter[0].connectionType) {
      case ConnectionType.USB:
        await printerManager.connect(
          type: ConnectionType.USB,
          model: UsbPrinterInput(
            name: selectedPrinter[0].name,
            vendorId: selectedPrinter[0].vendorId,
            productId: selectedPrinter[0].productId,
          ),
        );
        // Check connection status for Android
        if (Platform.isAndroid) {
          if (printerManager.usbPrinterConnector.status.index == 0) {
            _isConnected = false;
            FFAppState().isPrinterConnected = false;
          } else {
            _isConnected = true;
            FFAppState().printerName = "USBStatus.connected";
            FFAppState().isPrinterConnected = true;
          }
        } else {
          _isConnected = true;
          FFAppState().printerName = "USBStatus.connected";
          FFAppState().isPrinterConnected = true;
        }
        break;

      case ConnectionType.BLE:
        await printerManager.connect(
          type: ConnectionType.BLE,
          model: BluetoothPrinterInput(
            name: selectedPrinter[0].name,
            address: selectedPrinter[0].address ?? '',
            isBle: selectedPrinter[0].connectionType == ConnectionType.BLE,
          ),
        );
        FFAppState().printerName = "BTStatus.connected";
        FFAppState().isPrinterConnected = true;
        _isConnected = true;
        break;

      default:
        print('Unsupported printer type');
    }
  } catch (e) {
    print('Connection failed: $e');
    _isConnected = false;
  }

  return _isConnected;
}
