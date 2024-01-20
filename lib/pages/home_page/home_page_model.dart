import '/backend/schema/structs/index.dart';
import '/components/new_note_selector_component/new_note_selector_component_widget.dart';
import '/components/note_component/note_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for NewNoteSelectorComponent component.
  late NewNoteSelectorComponentModel newNoteSelectorComponentModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    newNoteSelectorComponentModel =
        createModel(context, () => NewNoteSelectorComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    newNoteSelectorComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
