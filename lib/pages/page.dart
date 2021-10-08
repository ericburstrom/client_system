part of '../main.dart';

class Pages {
  Future NavigateToLoginPageR(context) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => PageLogin()));
  }

  Future NavigateToGameRequestPageR(context) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => PageGameRequest()));
  }

  Future NavigateToGameSelectPageR(context) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => PageGameSelect()));
  }

  Future NavigateToGameSelectPage(context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PageGameSelect()));
  }

  Future NavigateToMainAppHandlerPageR(context) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainAppHandler()));
  }
}
