part of '../program.dart';

class PageGameSelect extends StatefulWidget {
  const PageGameSelect({Key? key}) : super(key: key);

  @override
  _PageGameSelectState createState() => _PageGameSelectState();
}

class _PageGameSelectState extends State<PageGameSelect>
    with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return gameSelect.WidgetScaffoldGameSelect(context, state);
  }
}

class GameSelect extends LanguagesGameSelect with InputItems {
  GameSelect() {
    LanguagesSetup();
    net.ConnectToServer();
  }

  var GameType = [application.GameType];
  var NrPlayers = [application.NrPlayers.toString()];
  var TabContr = TabController(length: 2, vsync: _PageGameSelectState());

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

  void OnGameListButton(BuildContext context) {
    print("request game");
    pages.NavigateToRequestPageR(context);

    // if (GameStarted) {
    //   Navigator.pop(context);
    // } else {
    //   GameStarted = true;
    //   pages.NavigateToMainAppHandlerPageR(context);
    // }
  }

  Widget WidgetScaffoldGameSelect(BuildContext context, Function state) {
    return DefaultTabController(
        length: TabContr.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text(Settings_),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: TabContr,
                isScrollable: false,
                tabs: [
                  Tab(text: Game_),
                  Tab(text: General_),
                ],
              ),
            ),
            body: TabBarView(
              controller: TabContr,
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
                      WidgetButton(context, OnGameListButton, GameList_),
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
