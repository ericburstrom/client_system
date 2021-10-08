part of '../main.dart';

bool mainPopGamePage = false;

class PageGameSelect extends StatefulWidget {
  PageGameSelect({Key? key}) : super(key: key);

  @override
  _PageGameSelectState createState() => _PageGameSelectState();
}

late TabController _settingsTabController;
late Function widgetCChangeOverlay;

class _PageGameSelectState extends State<PageGameSelect>
    with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widgetCChangeOverlay = gameSelect.widgetColorChangeOverlay;
    _settingsTabController =
        TabController(length: gameSelect.nrTabs, vsync: this);
    net.ConnectToServer();
  }

  @override
  void dispose() {
    _settingsTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return gameSelect.widgetScaffoldGameSelect(context, state);
  }
}
