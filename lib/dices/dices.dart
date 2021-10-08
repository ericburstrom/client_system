part of '../main.dart';

class UnityMessage {
  UnityMessage(this._action) {}

  UnityMessage.reset(this._nrDices, this._nrThrows) {
    _action = "reset";
  }

  UnityMessage.updateColors(this._colors) {
    _action = "setProperty";
    _property = "Color";
  }

  UnityMessage.changeBool(this._property, this._bool) {
    _action = "setProperty";
  }

  UnityMessage.fromJson(Map<String, dynamic> json)
      : _action = json['action'],
        _nrDices = json['nrDices'],
        _nrThrows = json['nrThrows'],
        _property = json['property'],
        _colors = json['colors'],
        _bool = json['bool'];

  Map<String, dynamic> toJson() => {
        'action': _action,
        'nrDices': _nrDices,
        'nrThrows': _nrThrows,
        'property': _property,
        'colors': _colors,
        'bool': _bool,
      };

  String _action = "";
  String _property = "";
  List<double> _colors = [0.6, 0.7, 0.8, 0.1];
  bool _bool = true;
  int _nrDices = 5;
  int _nrThrows = 3;
}

class Dices extends LanguagesDices {
  Dices(Function updateDiceValues) {
    _updateDiceValues = updateDiceValues;
  }

  var _hold;
  var _holdText;
  var _holdOpacity;

  var _rng = new Random();
  int _nrRolls = 0;
  int _nrDices = 5;
  var _diceValue = List.filled(5, 0);
  var _diceRef = [
    'assets/images/empty.jpg',
    'assets/images/empty.jpg',
    'assets/images/empty.jpg',
    'assets/images/empty.jpg',
    'assets/images/empty.jpg'
  ];
  var diceFile = [
    'empty.jpg',
    '1.jpg',
    '2.jpg',
    '3.jpg',
    '4.jpg',
    '5.jpg',
    '6.jpg'
  ];

  late Function _updateDiceValues;
  late UnityWidgetController _unityWidgetController;
  bool _unityCreated = false;
  List<double> _unityColors = [0.6, 0.7, 0.8, 0.1];

  List<bool> _unityDices = [false];
  List<bool> _unityTransparent = [true];
  List<bool> _unityLightMotion = [true];
  List<bool> _unityColorChangeOverlay = [false];

  ClearDices() {
    _diceValue = List.filled(_nrDices, 0);
    _hold = List.filled(_nrDices, false);
    _holdText = List.filled(_nrDices, "");
    _holdOpacity = List.filled(_nrDices, 0.0);
    _diceRef = List.filled(_nrDices, 'assets/images/empty.jpg');
    _nrRolls = 0;
  }

  MakeDiceRoll(var diceValue) {
    _diceValue = diceValue;
  }

  StartDices() {
    _nrRolls = 0;
  }

  InitDices(int nrDices) {
    if (_unityCreated) {
      SendResetToUnity();
    }
    _nrDices = nrDices;
    _diceValue = List.filled(nrDices, 0);
    _hold = List.filled(nrDices, false);
    _holdText = List.filled(nrDices, "");
    _holdOpacity = List.filled(nrDices, 0.0);
    _diceRef = List.filled(nrDices, 'assets/images/empty.jpg');
    _nrRolls = 0;
  }

  HoldDice(int dice) {
    if (_nrRolls > 0 && _nrRolls < 3) {
      _hold[dice] = !_hold[dice];
      if (_hold[dice]) {
        _holdText[dice] = GetText(_holdDice);
        _holdOpacity[dice] = 0.7;
      } else {
        _holdText[dice] = "";
        _holdOpacity[dice] = 0.0;
      }
    }
  }

  UpdateDiceImages() {
    for (var i = 0; i < _nrDices; i++) {
      _diceRef[i] = 'assets/images/' + diceFile[_diceValue[i]];
    }
  }

  bool RollDices() {
    print('hi');
    if (_nrRolls < 3) {
      print('hi again');
      _nrRolls += 1;
      for (var i = 0; i < _nrDices; i++) {
        if (!_hold[i]) {
          _diceValue[i] = _rng.nextInt(6) + 1;
          _diceRef[i] = 'assets/images/' + diceFile[_diceValue[i]];
        } else {
          if (_nrRolls == 3) {
            _hold[i] = false;
            _holdText[i] = "";
            _holdOpacity[i] = 0.0;
          }
        }
      }
      _updateDiceValues();
      net.SendDices(_diceValue);
      return true;
    }
    return false;
  }

  void SendResetToUnity() {
    UnityMessage msg = new UnityMessage.reset(_nrDices, 3);

    String json = jsonEncode(msg.toJson());
    print(json);
    _unityWidgetController.postMessage(
      'GameManager',
      'flutterMessage',
      json,
    );
  }

  void SendColorsToUnity() {
    UnityMessage msg = new UnityMessage.updateColors(_unityColors);

    String json = jsonEncode(msg.toJson());
    print(json);
    _unityWidgetController.postMessage(
      'GameManager',
      'flutterMessage',
      json,
    );
  }

  void SendTransparencyChangedToUnity() {
    UnityMessage msg =
        new UnityMessage.changeBool('Transparency', _unityTransparent[0]);

    String json = jsonEncode(msg.toJson());
    print(json);
    _unityWidgetController.postMessage(
      'GameManager',
      'flutterMessage',
      json,
    );
  }

  void SendLightMotionChangedToUnity() {
    UnityMessage msg =
        new UnityMessage.changeBool('LightMotion', _unityLightMotion[0]);

    String json = jsonEncode(msg.toJson());
    print(json);
    _unityWidgetController.postMessage(
      'GameManager',
      'flutterMessage',
      json,
    );
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    String msg = message.toString();
    print('Received message from unity: ${msg}');
    try {
      var _json = jsonDecode(msg);
      print(_json);
      if (_json['action'] == 'results') {
        _diceValue = _json['diceResult'].cast<int>();
        print(_diceValue);
        _updateDiceValues();
        globalSetState();
      }
    } catch (e) {}
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
    _unityCreated = true;
    SendResetToUnity();
    print('Unity Created');
  }

  // Communication from Unity when new scene is loaded to Flutter
  void onUnitySceneLoaded(SceneLoaded sceneInfo) {
    print('Received scene loaded from unity: ${sceneInfo.name}');
    print(
        'Received scene loaded from unity buildIndex: ${sceneInfo.buildIndex}');
  }
}
