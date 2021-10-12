part of '../main.dart';

class GameSelect extends LanguagesGameSelect with InputItems {
  GameSelect() {
    LanguagesSetup();
    net.ConnectToServer();
  }

  var NrTabs = 2;
  var GameType = [application.GameType];
  var NrPlayers = [application.NrPlayers.toString()];
  late var SettingsTabController =
      TabController(length: gameSelect.NrTabs, vsync: _PageGameSelectState());

  List<Widget> WidgetColorChangeOverlay(BuildContext context, Function state) {
    return <Widget>[
      WidgetCheckbox(
          state,
          application.GameDices.SendTransparencyChangedToUnity,
          Transparency_,
          application.GameDices.UnityTransparent),
      WidgetCheckbox(state, application.GameDices.SendLightMotionChangedToUnity,
          LightMotion_, application.GameDices.UnityLightMotion),
      WidgetSlider(context, state, application.GameDices.SendColorsToUnity,
          Red_, application.GameDices.UnityColors, 0),
      WidgetSlider(context, state, application.GameDices.SendColorsToUnity,
          Green_, application.GameDices.UnityColors, 1),
      WidgetSlider(context, state, application.GameDices.SendColorsToUnity,
          Blue_, application.GameDices.UnityColors, 2),
      WidgetSlider(context, state, application.GameDices.SendColorsToUnity,
          Transparency_, application.GameDices.UnityColors, 3)
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
                      WidgetStringRadioButton(
                          state,
                          ['Mini', 'Ordinary', 'Maxi'],
                          GameType,
                          [GameTypeMini_, GameTypeOrdinary_, GameTypeMaxi_]),
                      WidgetStringRadioButton(state, ['1', '2', '3', '4'],
                          NrPlayers, ['1', '2', '3', '4']),
                      WidgetCheckbox(state, () => {}, ChoseUnity_,
                          application.GameDices.UnityDices),
                      WidgetCheckbox(state, () => {}, ColorChangeOverlay_,
                          application.GameDices.UnityColorChangeOverlay),
                      WidgetSizedBox(15),
                      WidgetButton(context, OnStartGameButton, StartGame_),
                    ],
                  ),
                ),
                Scrollbar(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView(
                            children: [WidgetParagraph(Appearance_)] +
                                WidgetColorChangeOverlay(context, state) +
                                [
                                  WidgetSizedBox(15),
                                  WidgetParagraph(Misc_),
                                  WidgetDropDownList(
                                      state,
                                      ' ' + ChoseLanguage_,
                                      Languages.DifferentLanguages,
                                      Languages.ChosenLanguage),
                                ])))
              ],
            )));
  }
}
