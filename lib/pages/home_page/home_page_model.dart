import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Stores action output result for [Custom Action - scanPrinter] action in DropDown widget.
  bool? resultDevice2;
  // Stores action output result for [Custom Action - connectDevice] action in Container widget.
  bool? con;
  // Stores action output result for [Custom Action - newCustomAction] action in Container widget.
  List<dynamic>? selected;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
