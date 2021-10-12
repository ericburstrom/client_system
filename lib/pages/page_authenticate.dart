part of '../main.dart';

class PageAuthenticate extends StatefulWidget {
  PageAuthenticate({Key? key}) : super(key: key);

  @override
  _PageAuthenticate createState() => _PageAuthenticate();
}

class _PageAuthenticate extends State<PageAuthenticate>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    authenticate._tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    authenticate._tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return authenticate.WidgetScaffoldLogin(context);
  }
}
