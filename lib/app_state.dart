import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

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
      _isDarkMode = prefs.getBool('ff_isDarkMode') ?? _isDarkMode;
    });
    _safeInit(() {
      _notes = prefs
              .getStringList('ff_notes')
              ?.map((x) {
                try {
                  return NoteStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _notes;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool _value) {
    _isDarkMode = _value;
    prefs.setBool('ff_isDarkMode', _value);
  }

  List<NoteStruct> _notes = [];
  List<NoteStruct> get notes => _notes;
  set notes(List<NoteStruct> _value) {
    _notes = _value;
    prefs.setStringList('ff_notes', _value.map((x) => x.serialize()).toList());
  }

  void addToNotes(NoteStruct _value) {
    _notes.add(_value);
    prefs.setStringList('ff_notes', _notes.map((x) => x.serialize()).toList());
  }

  void removeFromNotes(NoteStruct _value) {
    _notes.remove(_value);
    prefs.setStringList('ff_notes', _notes.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromNotes(int _index) {
    _notes.removeAt(_index);
    prefs.setStringList('ff_notes', _notes.map((x) => x.serialize()).toList());
  }

  void updateNotesAtIndex(
    int _index,
    NoteStruct Function(NoteStruct) updateFn,
  ) {
    _notes[_index] = updateFn(_notes[_index]);
    prefs.setStringList('ff_notes', _notes.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInNotes(int _index, NoteStruct _value) {
    _notes.insert(_index, _value);
    prefs.setStringList('ff_notes', _notes.map((x) => x.serialize()).toList());
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
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
