part of '../../main.dart';

class GameRequest extends LanguagesGameRequest {
  GameRequest() {
    LanguagesSetup();
    net.SendRequestGame(
        gameSelect.GameType[0], int.parse(gameSelect.NrPlayers[0]));
  }

  int NrTabs = 1;

  Widget widgetScaffoldGameRequest(BuildContext context, Function state) {
    return DefaultTabController(
        length: NrTabs,
        child: Scaffold(
            appBar: AppBar(
              title: Text(GetText(GameRequest)),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: GameRequestTabController,
                isScrollable: false,
                tabs: [
                  Tab(text: GetText(GameRequest)),
                ],
              ),
            ),
            body: TabBarView(
              controller: GameRequestTabController,
              children: [
                Scrollbar(
                  child: ListView(
                    children: <Widget>[],
                  ),
                ),
              ],
            )));
  }
}
