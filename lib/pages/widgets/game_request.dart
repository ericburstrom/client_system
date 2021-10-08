part of '../../main.dart';

class GameRequest extends LanguagesGameRequest {
  GameRequest() {
    LanguagesSetup();
    net.SendRequestGame(
        gameSelect.gameType[0], int.parse(gameSelect.nrPlayers[0]));
  }

  int nrTabs = 1;

  Widget widgetScaffoldGameRequest(BuildContext context, Function state) {
    return DefaultTabController(
        length: nrTabs,
        child: Scaffold(
            appBar: AppBar(
              title: Text(GetText(_gameRequest)),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: _gameRequestTabController,
                isScrollable: false,
                tabs: [
                  Tab(text: GetText(_gameRequest)),
                ],
              ),
            ),
            body: TabBarView(
              controller: _gameRequestTabController,
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
