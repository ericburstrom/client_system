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
    return gameRequest.WidgetScaffoldGameRequest(context, state);
  }
}
