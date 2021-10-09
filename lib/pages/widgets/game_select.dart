part of '../../main.dart';

class GameSelect extends LanguagesGameSelect {
  GameSelect() {
    LanguagesSetup();
  }

  int NrTabs = 2;
  List<String> GameType = [application.GameType];
  List<String> NrPlayers = [application.NrPlayers.toString()];

  List<Widget> widgetColorChangeOverlay(BuildContext context, Function state) {
    return <Widget>[
      settings.widgetCheckbox(
          state,
          application.GameDices.SendTransparencyChangedToUnity,
          GetText(Transparency),
          application.GameDices.UnityTransparent),
      settings.widgetCheckbox(
          state,
          application.GameDices.SendLightMotionChangedToUnity,
          GetText(LightMotion),
          application.GameDices.UnityLightMotion),
      settings.widgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          GetText(Red),
          application.GameDices.UnityColors,
          0),
      settings.widgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          GetText(Green),
          application.GameDices.UnityColors,
          1),
      settings.widgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          GetText(Blue),
          application.GameDices.UnityColors,
          2),
      settings.widgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          GetText(Transparency),
          application.GameDices.UnityColors,
          3)
    ];
  }

  void onStartGameButton(BuildContext context) {
    //pages.NavigateToGameRequestPageR(context);

    //net.SendRequestGame(gameType[0], int.parse(nrPlayers[0]));

    application.Setup(GameType[0], int.parse(NrPlayers[0]));
    if (GameStarted) {
      Navigator.pop(context);
    } else {
      GameStarted = true;
      net.SendRequestGame(GameType[0], int.parse(NrPlayers[0]));
      pages.NavigateToMainAppHandlerPageR(context);
    }
  }

  Widget widgetScaffoldGameSelect(BuildContext context, Function state) {
    return DefaultTabController(
        length: NrTabs,
        child: Scaffold(
            appBar: AppBar(
              title: Text(GetText(Settings)),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: SettingsTabController,
                isScrollable: false,
                tabs: [
                  Tab(text: GetText(Game)),
                  Tab(text: GetText(General)),
                ],
              ),
            ),
            body: TabBarView(
              controller: SettingsTabController,
              children: [
                Scrollbar(
                  child: ListView(
                    children: <Widget>[
                      settings.widgetStringRadioButton(
                          state,
                          ['Mini', 'Ordinary', 'Maxi'],
                          GameType,
                          [
                            GetText(GameTypeMini),
                            GetText(GameTypeOrdinary),
                            GetText(GameTypeMaxi)
                          ]),
                      settings.widgetStringRadioButton(
                          state,
                          ['1', '2', '3', '4'],
                          NrPlayers,
                          ['1', '2', '3', '4']),
                      settings.widgetCheckbox(
                          state,
                          () => {},
                          GetText(ChoseUnity),
                          application.GameDices.UnityDices),
                      settings.widgetCheckbox(
                          state,
                          () => {},
                          GetText(ColorChangeOverlay),
                          application.GameDices.UnityColorChangeOverlay),
                      settings.widgetSizedBox(15),
                      settings.widgetButton(
                          context, onStartGameButton, GetText(StartGame)),
                    ],
                  ),
                ),
                Scrollbar(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ListView(
                            children: [
                                  settings.widgetParagraph(GetText(Appearance))
                                ] +
                                widgetColorChangeOverlay(context, state) +
                                [
                                  settings.widgetSizedBox(15),
                                  settings.widgetParagraph(GetText(Misc)),
                                  settings.widgetDropDownList(
                                      state,
                                      ' ' + GetText(ChoseLanguage),
                                      Languages.DifferentLanguages,
                                      Languages.ChosenLanguage),
                                ])))
              ],
            )));
  }
}
