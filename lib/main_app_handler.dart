part of './main.dart';

String localhost = 'http://192.168.0.168:3000';
String localhostIO = 'http://192.168.0.168:3001';
bool _gameStarted = false;
bool platformWeb = false;
bool reloadHighscore = true; // only used ones at loadup
var userName = 'Yatzy';
late Function globalSetState;
GlobalKey emptyContainerKey = new GlobalKey();
List<Widget> stackedWidgets = [];
late double screenWidth;
late double screenHeight;
// scrcpy --shortcut-mod=lctrl --always-on-top --stay-awake --window-title Yatzy
// android:theme="@style/UnityThemeSelector.Translucent"
// android/app/Src/main/AndroidManifest.xml

startAnimations(BuildContext context) {
  animationsScroll._animationController.repeat(reverse: true);
}

AnimationsRollDices animationsRollDices = new AnimationsRollDices();
AnimationsBoardEffect animationBoardEffect = new AnimationsBoardEffect();
AnimationsScroll animationsScroll = new AnimationsScroll(emptyContainerKey);
AnimationsHighscore animationsHighscore = new AnimationsHighscore();

FileHandler fileHandler = new FileHandler();
Net net = new Net();
Highscore highscore = new Highscore();
Pages pages = new Pages();
Application application = new Application();
Settings settings = new Settings();
Login login = new Login();
GameSelect gameSelect = new GameSelect();

GameRequest gameRequest = new GameRequest();

class MainAppHandler extends StatefulWidget {
  @override
  _MainAppHandlerState createState() => _MainAppHandlerState();
}

class _MainAppHandlerState extends State<MainAppHandler>
    with TickerProviderStateMixin {
  void state() {
    setState(() {});
  }

  void initState() {
    super.initState();
    globalSetState = state;
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => startAnimations(context));
  }

  Widget emptyContainer(double width, double height) {
    return Container(key: emptyContainerKey, width: width, height: height);
  }

  @override
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).devicePixelRatio);
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
              pages.NavigateToGameSelectPage(context);
            },
            tooltip: 'Settings',
            child: Icon(Icons.settings_applications),
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
                    highscore.widgetHighscore,
                    application.widgetSetupGameBoard,
                    application._dices.widgetDices,
                    emptyContainer) +
                [settings.widgetWrapCCOverlay(context, state)],
          ));
    } else {
      print('hello landscape');
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              pages.NavigateToGameSelectPage(context);
            },
            tooltip: 'Settings',
            child: Icon(Icons.settings_applications),
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
                    application.widgetSetupGameBoard,
                    application._dices.widgetDices,
                    highscore.widgetHighscore,
                    emptyContainer),
          ));
    }
    ;
  }
}
