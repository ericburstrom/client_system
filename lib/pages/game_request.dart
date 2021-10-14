part of '../main.dart';

class PageGameRequest extends StatefulWidget {
  const PageGameRequest({Key? key}) : super(key: key);

  @override
  _PageGameRequestState createState() => _PageGameRequestState();
}

class _PageGameRequestState extends State<PageGameRequest>
    with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    gameRequest.Context = context;
    net.SendRequestGame(
        gameSelect.GameType[0], int.parse(gameSelect.NrPlayers[0]));
    return gameRequest.WidgetScaffoldGameRequest(context, state);
  }
}

class GameRequest extends LanguagesGameRequest {
  GameRequest() {
    LanguagesSetup();
  }

  var TabContr = TabController(length: 1, vsync: _PageGameRequestState());

  //var GameList = [];
  late BuildContext Context;

  void StartGame(String gameType, int nrPlayers) {
    application.Setup(gameType, nrPlayers);

    GameStarted = true;
    pages.NavigateToMainAppHandlerPageR(Context);
  }

  Widget WidgetScaffoldGameRequest(BuildContext context, Function state) {
    return DefaultTabController(
        length: TabContr.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text(GameRequest_),
              backgroundColor: Colors.redAccent,
              bottom: TabBar(
                controller: TabContr,
                isScrollable: false,
                tabs: [
                  Tab(text: GameRequest_),
                ],
              ),
            ),
            body: TabBarView(
              controller: TabContr,
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
