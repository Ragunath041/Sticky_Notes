import '/backend/schema/structs/index.dart';
import '/components/circle_button_component/circle_button_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'note_component_model.dart';
export 'note_component_model.dart';

class NoteComponentWidget extends StatefulWidget {
  const NoteComponentWidget({
    Key? key,
    required this.note,
    this.onDeleteAction,
    this.onUpdateAction,
    required this.index,
  }) : super(key: key);

  final NoteStruct? note;
  final Future<dynamic> Function()? onDeleteAction;
  final Future<dynamic> Function()? onUpdateAction;
  final int? index;

  @override
  _NoteComponentWidgetState createState() => _NoteComponentWidgetState();
}

class _NoteComponentWidgetState extends State<NoteComponentWidget>
    with TickerProviderStateMixin {
  late NoteComponentModel _model;

  final animationsMap = {
    'iconOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(1.1, 1.1),
        ),
      ],
    ),
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoteComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.note = widget.note;
      });
    });

    _model.noteDescriptioinTextFieldController ??=
        TextEditingController(text: _model.note?.description);
    _model.noteDescriptioinTextFieldFocusNode ??= FocusNode();

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      alignment: AlignmentDirectional(1.0, -1.0),
      children: [
        Container(
          width: 240.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: widget.note?.colour,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Builder(
                                  builder: (context) {
                                    if (_model.isEdit == false) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 4.0, 0.0, 0.0),
                                        child: Text(
                                          widget.note!.description,
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumFamily),
                                                lineHeight: 1.5,
                                              ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        width: 200.0,
                                        decoration: BoxDecoration(),
                                        child: TextFormField(
                                          controller: _model
                                              .noteDescriptioinTextFieldController,
                                          focusNode: _model
                                              .noteDescriptioinTextFieldFocusNode,
                                          onFieldSubmitted: (_) async {
                                            setState(() {
                                              _model.updateNoteStruct(
                                                (e) => e
                                                  ..description = _model
                                                      .noteDescriptioinTextFieldController
                                                      .text,
                                              );
                                            });
                                            setState(() {
                                              FFAppState().updateNotesAtIndex(
                                                widget.index!,
                                                (_) => _model.note!,
                                              );
                                            });
                                            setState(() {
                                              _model.isEdit = !_model.isEdit;
                                            });
                                            await widget.onUpdateAction?.call();
                                          },
                                          autofocus: true,
                                          textInputAction: TextInputAction.done,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            alignLabelWithHint: false,
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            focusedErrorBorder:
                                                InputBorder.none,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMediumFamily,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleMediumFamily),
                                                lineHeight: 1.5,
                                              ),
                                          textAlign: TextAlign.justify,
                                          validator: _model
                                              .noteDescriptioinTextFieldControllerValidator
                                              .asValidator(context),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 60.0,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          dateTimeFormat(
                              'MMMMEEEEd',
                              dateTimeFromSecondsSinceEpoch(valueOrDefault<int>(
                                widget.note?.createDate?.secondsSinceEpoch,
                                0,
                              ))),
                          style: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
                              ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Builder(
                            builder: (context) {
                              if (_model.isEdit == false) {
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    setState(() {
                                      _model.noteDescriptioinTextFieldController
                                          ?.text = _model.note!.description;
                                    });
                                    setState(() {
                                      _model.isEdit = !_model.isEdit;
                                    });
                                  },
                                  child: wrapWithModel(
                                    model: _model.editButtonModel,
                                    updateCallback: () => setState(() {}),
                                    child: CircleButtonComponentWidget(
                                      icon: Icon(
                                        Icons.edit_outlined,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    setState(() {
                                      _model.updateNoteStruct(
                                        (e) => e
                                          ..description = _model
                                              .noteDescriptioinTextFieldController
                                              .text,
                                      );
                                    });
                                    setState(() {
                                      FFAppState().updateNotesAtIndex(
                                        widget.index!,
                                        (_) => _model.note!,
                                      );
                                    });
                                    setState(() {
                                      _model.isEdit = !_model.isEdit;
                                    });
                                    await widget.onUpdateAction?.call();
                                  },
                                  child: wrapWithModel(
                                    model: _model.updateButonModel,
                                    updateCallback: () => setState(() {}),
                                    child: CircleButtonComponentWidget(
                                      icon: Icon(
                                        Icons.check_sharp,
                                      ),
                                      colour: FlutterFlowTheme.of(context)
                                          .secondary,
                                      opacity: 1.0,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]
                .addToStart(SizedBox(height: 16.0))
                .addToEnd(SizedBox(height: 8.0)),
          ),
        ),
        Container(
          decoration: BoxDecoration(),
          child: MouseRegion(
            opaque: false,
            cursor: MouseCursor.defer ?? MouseCursor.defer,
            child: Opacity(
              opacity: 0.5,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 12.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    setState(() {
                      FFAppState().removeAtIndexFromNotes(widget.index!);
                    });
                    await widget.onDeleteAction?.call();
                  },
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).info,
                    size: 24.0,
                  ),
                ).animateOnActionTrigger(
                  animationsMap['iconOnActionTriggerAnimation']!,
                ),
              ),
            ),
            onEnter: ((event) async {
              setState(() => _model.mouseRegionHovered = true);
              if (animationsMap['iconOnActionTriggerAnimation'] != null) {
                await animationsMap['iconOnActionTriggerAnimation']!
                    .controller
                    .forward(from: 0.0);
              }
            }),
            onExit: ((event) async {
              setState(() => _model.mouseRegionHovered = false);
              if (animationsMap['iconOnActionTriggerAnimation'] != null) {
                await animationsMap['iconOnActionTriggerAnimation']!
                    .controller
                    .reverse();
              }
            }),
          ),
        ),
      ],
    );
  }
}
