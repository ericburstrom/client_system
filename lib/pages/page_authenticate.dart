part of '../main.dart';

class PageAuthenticate extends StatefulWidget {
  const PageAuthenticate({Key? key}) : super(key: key);

  @override
  _PageAuthenticate createState() => _PageAuthenticate();
}

class _PageAuthenticate extends State<PageAuthenticate>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return authenticate.WidgetScaffoldLogin(context);
  }
}
