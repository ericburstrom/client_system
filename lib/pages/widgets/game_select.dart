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
          Transparency_,
          application.GameDices.UnityTransparent),
      settings.WidgetCheckbox(
          state,
          application.GameDices.SendLightMotionChangedToUnity,
          LightMotion_,
          application.GameDices.UnityLightMotion),
      settings.WidgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          Red_,
          application.GameDices.UnityColors,
          0),
      settings.WidgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          Green_,
          application.GameDices.UnityColors,
          1),
      settings.WidgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          Blue_,
          application.GameDices.UnityColors,
          2),
      settings.WidgetSlider(
          context,
          state,
          application.GameDices.SendColorsToUnity,
          Transparency_,
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
              title: Text(Settings_),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: SettingsTabController,
                isScrollable: false,
                tabs: [
                  Tab(text: Game_),
                  Tab(text: General_),
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
                          [GameTypeMini_, GameTypeOrdinary_, GameTypeMaxi_]),
                      settings.WidgetStringRadioButton(
                          state,
                          ['1', '2', '3', '4'],
                          NrPlayers,
                          ['1', '2', '3', '4']),
                      settings.WidgetCheckbox(state, () => {}, ChoseUnity_,
                          application.GameDices.UnityDices),
                      settings.WidgetCheckbox(
                          state,
                          () => {},
                          ColorChangeOverlay_,
                          application.GameDices.UnityColorChangeOverlay),
                      settings.WidgetSizedBox(15),
                      settings.WidgetButton(
                          context, OnStartGameButton, StartGame_),
                    ],
                  ),
                ),
                Scrollbar(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ListView(
                            children: [settings.WidgetParagraph(Appearance_)] +
                                WidgetColorChangeOverlay(context, state) +
                                [
                                  settings.WidgetSizedBox(15),
                                  settings.WidgetParagraph(Misc_),
                                  settings.WidgetDropDownList(
                                      state,
                                      ' ' + ChoseLanguage_,
                                      Languages.DifferentLanguages,
                                      Languages.ChosenLanguage),
                                ])))
              ],
            )));
  }
}
