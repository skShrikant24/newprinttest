// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<dynamic>> newCustomAction(String index) async {
  bool flag = false;

  List<dynamic> selectedPrinter = [];
  if (index == "0") {
  } else {
    FFAppState().printerDevice.forEach((element) {
      if (FFAppState().posMode.toUpperCase() == "USB") {
        if (FFAppState().targetPlatform == "windows") {
          selectedPrinter.add(element);
          flag = true;
        } else {
          if (element["vendorId"] == index) {
            selectedPrinter.add(element);
            flag = true;
          }
        }
      } else if (FFAppState().posMode.toUpperCase() == "BLUETOOTH") {
        if (element["address"] == index) {
          selectedPrinter.add(element);
          flag = true;
        }
      } else if (FFAppState().posMode.toUpperCase() == "ETHERNET") {
        if (element["address"] == index) {
          selectedPrinter.add(element);
          flag = true;
        }
      }
    });
  }
  return selectedPrinter;

  // Add your function code here!
}
