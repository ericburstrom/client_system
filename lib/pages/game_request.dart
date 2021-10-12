part of '../main.dart';

class GameRequest extends LanguagesGameRequest {
  GameRequest() {
    LanguagesSetup();
    net.SendRequestGame(
        gameSelect.GameType[0], int.parse(gameSelect.NrPlayers[0]));
  }

  var NrTabs = 1;
  late var GameRequestTabController =
      TabController(length: NrTabs, vsync: _PageGameRequestState());

  Widget WidgetScaffoldGameRequest(BuildContext context, Function state) {
    return DefaultTabController(
        length: NrTabs,
        child: Scaffold(
            appBar: AppBar(
              title: Text(GameRequest_),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: GameRequestTabController,
                isScrollable: false,
                tabs: [
                  Tab(text: GameRequest_),
                ],
              ),
            ),
            body: TabBarView(
              controller: GameRequestTabController,
              children: [
                Scrollbar(
                  child: ListView(
                    children: const <Widget>[],
                  ),
                ),
              ],
            )));
  }
}
