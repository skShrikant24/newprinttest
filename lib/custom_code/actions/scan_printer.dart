// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';

Future<bool> scanPrinter(String type) async {
  ConnectionType? defaultPrinterType;

  // Determine the connection type based on input
  if (type.toUpperCase() == "USB") {
    defaultPrinterType = ConnectionType.USB;
  } else if (type.toUpperCase() == "BLUETOOTH") {
    defaultPrinterType = ConnectionType.BLE; // Use BLE for Bluetooth
  } else {
    print('Unsupported printer type');
    return false;
  }

  final _flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;
  List<Printer> devices = [];
  StreamSubscription<List<Printer>>? _devicesStreamSubscription;

  try {
    // Start scanning based on the selected printer type
    if (defaultPrinterType == ConnectionType.USB) {
      await _flutterThermalPrinterPlugin.getUsbDevices();
    } else if (defaultPrinterType == ConnectionType.BLE) {
      await _flutterThermalPrinterPlugin.startScan();
    }

    _devicesStreamSubscription =
        _flutterThermalPrinterPlugin.devicesStream.listen((event) {
      devices = event;
      print('Discovered Devices: ${devices.map((d) => d.name).toList()}');

      devices.forEach((device) {
        // Add to your state management (like FFAppState) for discovered devices
        FFAppState().printerDevice.add({
          "deviceName": device.name,
          "address": device.address ?? device.vendorId,
          "isBle": defaultPrinterType == ConnectionType.BLE,
          "vendorId": device.vendorId,
          "productId": device.productId,
          "typePrinter": defaultPrinterType,
        });
      });
    });

    // Allow scan to run for a limited time, e.g., 5 seconds
    await Future.delayed(const Duration(seconds: 5));

    // Stop scan and cancel subscription
    if (defaultPrinterType == ConnectionType.BLE) {
      await _flutterThermalPrinterPlugin.stopScan();
    }
    _devicesStreamSubscription?.cancel();
  } catch (e) {
    print('Error during scanning: $e');
    return false;
  }

  // Check if any devices were found
  if (FFAppState().printerDevice.isEmpty) {
    print('No printers found');
    return false;
  } else {
    print('Printers found: ${FFAppState().printerDevice.length}');
    return true;
  }
}

// BluetoothPrinter model adapted for this plugin
class BluetoothPrinter {
  String? address;
  String? name;
  ConnectionType? connectionType;
  bool? isConnected;
  String? vendorId;
  String? productId;

  BluetoothPrinter({
    this.name,
    this.address,
    this.vendorId,
    this.productId,
    this.connectionType,
    this.isConnected = false,
  });
}
