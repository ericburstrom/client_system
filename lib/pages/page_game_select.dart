part of '../main.dart';

bool mainPopGamePage = false;

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
