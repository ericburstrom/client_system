part of '../main.dart';

class PageGameRequest extends StatefulWidget {
  PageGameRequest({Key? key}) : super(key: key);

  @override
  _PageGameRequestState createState() => _PageGameRequestState();
}

late TabController GameRequestTabController;

class _PageGameRequestState extends State<PageGameRequest>
    with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GameRequestTabController =
        TabController(length: gameRequest.NrTabs, vsync: this);
    net.ConnectToServer();
  }

  @override
  void dispose() {
    SettingsTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return gameRequest.widgetScaffoldGameRequest(context, state);
  }
}
