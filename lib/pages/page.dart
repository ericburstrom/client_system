part of '../main.dart';

class Pages {
  Future NavigateToAuthenticatePageR(context) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => PageAuthenticate()));
  }

  Future NavigateToRequestPageR(context) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => PageGameRequest()));
  }

  Future NavigateToSelectPageR(context) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => PageGameSelect()));
  }

  Future NavigateToSelectPage(context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PageGameSelect()));
  }

  Future NavigateToMainAppHandlerPageR(context) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainAppHandler()));
  }
}
