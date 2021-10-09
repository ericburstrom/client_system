part of '../main.dart';

class UnityMessage {
  UnityMessage(this.Action);

  UnityMessage.reset(this.NrDices, this.NrThrows) {
    Action = "reset";
  }

  UnityMessage.updateColors(this.UnityColors) {
    Action = "setProperty";
    Property = "Color";
  }

  UnityMessage.changeBool(this.Property, this.Flag) {
    Action = "setProperty";
  }

  UnityMessage.fromJson(Map<String, dynamic> json)
      : Action = json['action'],
        NrDices = json['nrDices'],
        NrThrows = json['nrThrows'],
        Property = json['property'],
        UnityColors = json['colors'],
        Flag = json['flag'];

  Map<String, dynamic> toJson() => {
        'action': Action,
        'nrDices': NrDices,
        'nrThrows': NrThrows,
        'property': Property,
        'colors': UnityColors,
        'bool': Flag,
      };

  var Action = "";
  var Property = "";
  var UnityColors = [0.6, 0.7, 0.8, 0.1];
  var Flag = true;
  var NrDices = 5;
  var NrThrows = 3;
}

class Dices extends LanguagesDices {
  Dices(Function updateDiceValues) {
    UpdateDiceValues = updateDiceValues;
  }

  var HoldDices;
  var HoldDiceText;
  var HoldDiceOpacity;

  var RandomNumberGenerator = Random();
  var NrRolls = 0;
  var NrDices = 5;
  var DiceValue = List.filled(5, 0);
  var DiceRef = [
    'assets/images/empty.jpg',
    'assets/images/empty.jpg',
    'assets/images/empty.jpg',
    'assets/images/empty.jpg',
    'assets/images/empty.jpg'
  ];
  var DiceFile = [
    'empty.jpg',
    '1.jpg',
    '2.jpg',
    '3.jpg',
    '4.jpg',
    '5.jpg',
    '6.jpg'
  ];

  late Function UpdateDiceValues;
  late UnityWidgetController UWController;
  var UnityCreated = false;
  var UnityColors = [0.6, 0.7, 0.8, 0.1];

  var UnityDices = [false];
  var UnityTransparent = [true];
  var UnityLightMotion = [true];
  var UnityColorChangeOverlay = [false];

  ClearDices() {
    DiceValue = List.filled(NrDices, 0);
    HoldDices = List.filled(NrDices, false);
    HoldDiceText = List.filled(NrDices, "");
    HoldDiceOpacity = List.filled(NrDices, 0.0);
    DiceRef = List.filled(NrDices, 'assets/images/empty.jpg');
    NrRolls = 0;
  }

  MakeDiceRoll(var diceValue) {
    DiceValue = diceValue;
  }

  StartDices() {
    NrRolls = 0;
  }

  InitDices(int nrDices) {
    if (UnityCreated) {
      SendResetToUnity();
    }
    NrDices = nrDices;
    DiceValue = List.filled(nrDices, 0);
    HoldDices = List.filled(nrDices, false);
    HoldDiceText = List.filled(nrDices, "");
    HoldDiceOpacity = List.filled(nrDices, 0.0);
    DiceRef = List.filled(nrDices, 'assets/images/empty.jpg');
    NrRolls = 0;
  }

  HoldDice(int dice) {
    if (NrRolls > 0 && NrRolls < 3) {
      HoldDices[dice] = !HoldDices[dice];
      if (HoldDices[dice]) {
        HoldDiceText[dice] = GetText(Hold);
        HoldDiceOpacity[dice] = 0.7;
      } else {
        HoldDiceText[dice] = "";
        HoldDiceOpacity[dice] = 0.0;
      }
    }
  }

  UpdateDiceImages() {
    for (var i = 0; i < NrDices; i++) {
      DiceRef[i] = 'assets/images/' + DiceFile[DiceValue[i]];
    }
  }

  bool RollDices() {
    print('hi');
    if (NrRolls < 3) {
      print('hi again');
      NrRolls += 1;
      for (var i = 0; i < NrDices; i++) {
        if (!HoldDices[i]) {
          DiceValue[i] = RandomNumberGenerator.nextInt(6) + 1;
          DiceRef[i] = 'assets/images/' + DiceFile[DiceValue[i]];
        } else {
          if (NrRolls == 3) {
            HoldDices[i] = false;
            HoldDiceText[i] = "";
            HoldDiceOpacity[i] = 0.0;
          }
        }
      }
      UpdateDiceValues();
      net.SendDices(DiceValue);
      return true;
    }
    return false;
  }

  void SendResetToUnity() {
    UnityMessage msg = UnityMessage.reset(NrDices, 3);

    var json = jsonEncode(msg.toJson());
    print(json);
    UWController.postMessage(
      'GameManager',
      'flutterMessage',
      json,
    );
  }

  void SendColorsToUnity() {
    var msg = UnityMessage.updateColors(UnityColors);

    var json = jsonEncode(msg.toJson());
    print(json);
    UWController.postMessage(
      'GameManager',
      'flutterMessage',
      json,
    );
  }

  void SendTransparencyChangedToUnity() {
    var msg = UnityMessage.changeBool('Transparency', UnityTransparent[0]);

    var json = jsonEncode(msg.toJson());
    print(json);
    UWController.postMessage(
      'GameManager',
      'flutterMessage',
      json,
    );
  }

  void SendLightMotionChangedToUnity() {
    var msg = UnityMessage.changeBool('LightMotion', UnityLightMotion[0]);

    var json = jsonEncode(msg.toJson());
    print(json);
    UWController.postMessage(
      'GameManager',
      'flutterMessage',
      json,
    );
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    var msg = message.toString();
    print('Received message from unity: ${msg}');
    try {
      var _json = jsonDecode(msg);
      print(_json);
      if (_json['action'] == 'results') {
        DiceValue = _json['diceResult'].cast<int>();
        print(DiceValue);
        UpdateDiceValues();
        globalSetState();
      }
    } catch (e) {}
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    UWController = controller;
    UnityCreated = true;
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
