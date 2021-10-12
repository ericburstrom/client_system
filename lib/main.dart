// System imports
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

// Animations imports
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:marquee/marquee.dart';

part 'layouts.dart';

part 'main_app_handler.dart';

part './application/animations_board_effect.dart';

part './application/application.dart';

part './application/application_functions_internal.dart';

part './application/application_functions_internal_calc_dice_values.dart';

part './application/widget_game_setup_board.dart';

part './dices/animations_rolldice.dart';

part './dices/dices.dart';

part './dices/languages_dices.dart';

part './dices/widget_dices.dart';

part './file_handler/file_handler.dart';

part './highscore/animations_highscore.dart';

part './highscore/highscore.dart';

part './highscore/languages_highscore.dart';

part './highscore/widget_highscore.dart';

part './languages/languages.dart';

part './languages/classes/languages_animations_scroll.dart';

part './languages/classes/languages_game_request.dart';

part './languages/classes/languages_game_select.dart';

part './languages/classes/languages_login.dart';

part './languages/classes/languages_application.dart';

part './net/net.dart';

part './pages/page.dart';

part './pages/page_game_request.dart';

part './pages/page_game_select.dart';

part './pages/page_authenticate.dart';

part './pages/widgets/authenticate.dart';

part './pages/widgets/game_request.dart';

part './pages/widgets/game_select.dart';

part './scroll/animations_scroll.dart';

part './scroll/widget_scroll.dart';

part './settings/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future attemptLogin(BuildContext context) async {
  try {
    var userData = await fileHandler.ReadFile(fileHandler.FileSettings);
    print(userData);
    userName = userData['username'];
    try {
      var serverResponse = await net.mainLogin(userName, userData['password']);
      if (serverResponse.statusCode == 200) {
        print(serverResponse.body);
        //authenticate.Jwt = serverResponse.body;
        print('User is logged in!');
      } else {
        print('user not logged in');
      }
    } catch (e) {
      print('error logging in!');
    }
  } catch (e) {}

  Timer.run(() {
    //if (authenticate.Jwt == null && !platformWeb) {
    if (!platformWeb) {
      pages.NavigateToAuthenticatePageR(context);
    } else if (!GameStarted) {
      pages.NavigateToSelectPageR(context);
    } else {
      pages.NavigateToMainAppHandlerPageR(context);
    }
  });
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    attemptLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
