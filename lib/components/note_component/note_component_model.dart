import '/backend/schema/structs/index.dart';
import '/components/circle_button_component/circle_button_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'note_component_widget.dart' show NoteComponentWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NoteComponentModel extends FlutterFlowModel<NoteComponentWidget> {
  ///  Local state fields for this component.

  bool isEdit = false;

  NoteStruct? note;
  void updateNoteStruct(Function(NoteStruct) updateFn) =>
      updateFn(note ??= NoteStruct());

  ///  State fields for stateful widgets in this component.

  // State field(s) for NoteDescriptioinTextField widget.
  FocusNode? noteDescriptioinTextFieldFocusNode;
  TextEditingController? noteDescriptioinTextFieldController;
  String? Function(BuildContext, String?)?
      noteDescriptioinTextFieldControllerValidator;
  // Model for EditButton.
  late CircleButtonComponentModel editButtonModel;
  // Model for UpdateButon.
  late CircleButtonComponentModel updateButonModel;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    editButtonModel = createModel(context, () => CircleButtonComponentModel());
    updateButonModel = createModel(context, () => CircleButtonComponentModel());
  }

  void dispose() {
    noteDescriptioinTextFieldFocusNode?.dispose();
    noteDescriptioinTextFieldController?.dispose();

    editButtonModel.dispose();
    updateButonModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
