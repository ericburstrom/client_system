part of '../main.dart';

class Pages {
  Future NavigateToAuthenticatePageR(context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PageAuthenticate()));
  }

  Future NavigateToRequestPageR(context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PageGameRequest()));
  }

  Future NavigateToSelectPageR(context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PageGameSelect()));
  }

  Future NavigateToSelectPage(context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PageGameSelect()));
  }

  Future NavigateToMainAppHandlerPageR(context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const MainAppHandler()));
  }
}
