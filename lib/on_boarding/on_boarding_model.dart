import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'on_boarding_widget.dart' show OnBoardingWidget;
import 'package:flutter/material.dart';

class OnBoardingModel extends FlutterFlowModel<OnBoardingWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for NameVar widget.
  FocusNode? nameVarFocusNode;
  TextEditingController? nameVarTextController;
  String? Function(BuildContext, String?)? nameVarTextControllerValidator;
  String? _nameVarTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Name is required';
    }

    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? name;

  @override
  void initState(BuildContext context) {
    nameVarTextControllerValidator = _nameVarTextControllerValidator;
  }

  @override
  void dispose() {
    nameVarFocusNode?.dispose();
    nameVarTextController?.dispose();
  }
}
