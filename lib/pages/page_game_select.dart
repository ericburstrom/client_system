part of '../main.dart';

bool mainPopGamePage = false;

class PageGameSelect extends StatefulWidget {
  PageGameSelect({Key? key}) : super(key: key);

  @override
  _PageGameSelectState createState() => _PageGameSelectState();
}

late TabController SettingsTabController;
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
    SettingsTabController =
        TabController(length: gameSelect.NrTabs, vsync: this);
    net.ConnectToServer();
  }

  @override
  void dispose() {
    SettingsTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return gameSelect.widgetScaffoldGameSelect(context, state);
  }
}
