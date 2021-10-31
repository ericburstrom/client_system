part of './program.dart';

var localhost = 'http://192.168.0.168:3000';
var localhostIO = 'http://192.168.0.168:3001';
var GameStarted = false;
var platformWeb = false;
var reloadHighscore = true; // only used ones at loadup
var userName = 'Yatzy';
var EmptyContainerKey = GlobalKey();
late Function globalSetState;
var stackedWidgets = <Widget>[];
late double screenWidth;
late double screenHeight;
// scrcpy --shortcut-mod=lctrl --always-on-top --stay-awake --window-title Yatzy
// android:theme="@style/UnityThemeSelector.Translucent"
// android/app/Src/main/AndroidManifest.xml

startAnimations(BuildContext context) {
  animationsScroll.AnimController.repeat(reverse: true);
}

var animationsScroll = AnimationsScroll(EmptyContainerKey);

var fileHandler = FileHandler();
var net = Net();
var highscore = Highscore();
var pages = Pages();
var application = Application();
var authenticate = Authenticate();
var gameSelect = GameSelect();
var gameRequest = GameRequest();

class MainAppHandler extends StatefulWidget {
  const MainAppHandler({Key? key}) : super(key: key);

  @override
  _MainAppHandlerState createState() => _MainAppHandlerState();
}

class _MainAppHandlerState extends State<MainAppHandler>
    with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    globalSetState = state;
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => startAnimations(context));
  }

  Widget EmptyContainer(double width, double height) {
    return Container(key: EmptyContainerKey, width: width, height: height);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    if (reloadHighscore) {
      highscore.LoadAndUpdateHighscoresFromServer();
      reloadHighscore = false;
    }

    if (screenHeight > screenWidth) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              pages.NavigateToSelectPage(context);
            },
            tooltip: 'Settings',
            child: const Icon(Icons.settings_applications),
            backgroundColor: Colors.blue,
          ),
          body: Stack(
            children: <Widget>[
                  Image.asset('assets/images/yatzy_portrait.jpg',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity),
                  Stack(children: stackedWidgets),
                ] +
                LayoutPTopToBottom4(
                    screenWidth,
                    screenHeight,
                    highscore.WidgetHighscore,
                    application.WidgetSetupGameBoard,
                    application.GameDices.WidgetDices,
                    EmptyContainer) +
                [gameSelect.WidgetWrapCCOverlay(context, state)],
          ));
    } else {
      print('hello landscape');
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              pages.NavigateToSelectPage(context);
            },
            tooltip: 'Settings',
            child: const Icon(Icons.settings_applications),
            backgroundColor: Colors.blue,
          ),
          body: Stack(
            children: <Widget>[
                  Image.asset('assets/images/yatzy_landscape2.jpg',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity),
                  Stack(children: stackedWidgets)
                ] +
                LayoutLLeftToRight4(
                    screenWidth,
                    screenHeight,
                    application.WidgetSetupGameBoard,
                    application.GameDices.WidgetDices,
                    highscore.WidgetHighscore,
                    EmptyContainer),
          ));
    }
  }
}
