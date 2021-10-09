part of '../../main.dart';

class GameSelect extends LanguagesGameSelect {
  GameSelect() {
    LanguagesSetup();
  }

  var NrTabs = 2;
  var GameType = [application.GameType];
  var NrPlayers = [application.NrPlayers.toString()];

  List<Widget> WidgetColorChangeOverlay(BuildContext context, Function state) {
    return <Widget>[
      settings.WidgetCheckbox(
          state,
          application.GameDices.SendTransparencyChangedToUnity,
          Transparency,
          application.GameDices.UnityTransparent),
      settings.WidgetCheckbox(
          state,
          application.GameDices.SendLightMotionChangedToUnity,
          LightMotion,
          application.GameDices.UnityLightMotion),
      settings.WidgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          Red,
          application.GameDices.UnityColors,
          0),
      settings.WidgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          Green,
          application.GameDices.UnityColors,
          1),
      settings.WidgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          Blue,
          application.GameDices.UnityColors,
          2),
      settings.WidgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          Transparency,
          application.GameDices.UnityColors,
          3)
    ];
  }

  void OnStartGameButton(BuildContext context) {
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

  Widget WidgetScaffoldGameSelect(BuildContext context, Function state) {
    return DefaultTabController(
        length: NrTabs,
        child: Scaffold(
            appBar: AppBar(
              title: Text(Settings),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: SettingsTabController,
                isScrollable: false,
                tabs: [
                  Tab(text: Game),
                  Tab(text: General),
                ],
              ),
            ),
            body: TabBarView(
              controller: SettingsTabController,
              children: [
                Scrollbar(
                  child: ListView(
                    children: <Widget>[
                      settings.WidgetStringRadioButton(
                          state,
                          ['Mini', 'Ordinary', 'Maxi'],
                          GameType,
                          [GameTypeMini, GameTypeOrdinary, GameTypeMaxi]),
                      settings.WidgetStringRadioButton(
                          state,
                          ['1', '2', '3', '4'],
                          NrPlayers,
                          ['1', '2', '3', '4']),
                      settings.WidgetCheckbox(state, () => {}, ChoseUnity,
                          application.GameDices.UnityDices),
                      settings.WidgetCheckbox(
                          state,
                          () => {},
                          ColorChangeOverlay,
                          application.GameDices.UnityColorChangeOverlay),
                      settings.WidgetSizedBox(15),
                      settings.WidgetButton(
                          context, OnStartGameButton, StartGame),
                    ],
                  ),
                ),
                Scrollbar(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ListView(
                            children: [
                                  settings.WidgetParagraph(Appearance)
                                ] +
                                WidgetColorChangeOverlay(context, state) +
                                [
                                  settings.WidgetSizedBox(15),
                                  settings.WidgetParagraph(Misc),
                                  settings.WidgetDropDownList(
                                      state,
                                      ' ' + ChoseLanguage,
                                      Languages.DifferentLanguages,
                                      Languages.ChosenLanguage),
                                ])))
              ],
            )));
  }
}
