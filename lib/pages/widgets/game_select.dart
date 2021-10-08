part of '../../main.dart';

class GameSelect extends LanguagesGameSelect {
  GameSelect() {
    LanguagesSetup();
  }

  int nrTabs = 2;
  List<String> gameType = [application._gameType];
  List<String> nrPlayers = [application._nrPlayers.toString()];

  List<Widget> widgetColorChangeOverlay(BuildContext context, Function state) {
    return <Widget>[
      settings.widgetCheckbox(
          state,
          application._dices.SendTransparencyChangedToUnity,
          GetText(_transparency),
          application._dices._unityTransparent),
      settings.widgetCheckbox(
          state,
          application._dices.SendLightMotionChangedToUnity,
          GetText(_lightMotion),
          application._dices._unityLightMotion),
      settings.widgetSlider(
          context,
          state,
          application._dices.SendColorsToUnity,
          GetText(_red),
          application._dices._unityColors,
          0),
      settings.widgetSlider(
          context,
          state,
          application._dices.SendColorsToUnity,
          GetText(_green),
          application._dices._unityColors,
          1),
      settings.widgetSlider(
          context,
          state,
          application._dices.SendColorsToUnity,
          GetText(_blue),
          application._dices._unityColors,
          2),
      settings.widgetSlider(
          context,
          state,
          application._dices.SendColorsToUnity,
          GetText(_transparency),
          application._dices._unityColors,
          3)
    ];
  }

  void onStartGameButton(BuildContext context) {
    pages.NavigateToGameRequestPageR(context);

    //net.SendRequestGame(gameType[0], int.parse(nrPlayers[0]));

    // application.Setup(gameType[0], int.parse(nrPlayers[0]));
    // if (_gameStarted) {
    //   Navigator.pop(context);
    // } else {
    //   _gameStarted = true;
    //   net.SendRequestGame(gameType[0], int.parse(nrPlayers[0]));
    //   pages.NavigateToMainAppHandlerPageR(context);
    // }
  }

  Widget widgetScaffoldGameSelect(BuildContext context, Function state) {
    return DefaultTabController(
        length: nrTabs,
        child: Scaffold(
            appBar: AppBar(
              title: Text(GetText(_settings)),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: _settingsTabController,
                isScrollable: false,
                tabs: [
                  Tab(text: GetText(_game)),
                  Tab(text: GetText(_general)),
                ],
              ),
            ),
            body: TabBarView(
              controller: _settingsTabController,
              children: [
                Scrollbar(
                  child: ListView(
                    children: <Widget>[
                      settings.widgetStringRadioButton(
                          state,
                          ['Mini', 'Ordinary', 'Maxi'],
                          gameType,
                          [
                            GetText(_gameTypeMini),
                            GetText(_gameTypeOrdinary),
                            GetText(_gameTypeMaxi)
                          ]),
                      settings.widgetStringRadioButton(
                          state,
                          ['1', '2', '3', '4'],
                          nrPlayers,
                          ['1', '2', '3', '4']),
                      settings.widgetCheckbox(state, () => {},
                          GetText(_choseUnity), application._dices._unityDices),
                      settings.widgetCheckbox(
                          state,
                          () => {},
                          GetText(_colorChangeOverlay),
                          application._dices._unityColorChangeOverlay),
                      settings.widgetSizedBox(15),
                      settings.widgetButton(
                          context, onStartGameButton, GetText(_startGame)),
                    ],
                  ),
                ),
                Scrollbar(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ListView(
                            children: [
                                  settings.widgetParagraph(GetText(_appearance))
                                ] +
                                widgetColorChangeOverlay(context, state) +
                                [
                                  settings.widgetSizedBox(15),
                                  settings.widgetParagraph(GetText(_misc)),
                                  settings.widgetDropDownList(
                                      state,
                                      ' ' + GetText(_choseLanguage),
                                      Languages._languages,
                                      Languages._chosenLanguage),
                                ])))
              ],
            )));
  }
}
