part of '../../main.dart';

class Authenticate extends LanguagesLogin {
  Authenticate() {
    LanguagesSetup();
  }

  final LoginTxtUserName = TextEditingController();
  final LoginTxtPassword = TextEditingController();
  final SignupTxtUserName = TextEditingController();
  final SignupTxtPassword = TextEditingController();
  final SignupTxtPassword2 = TextEditingController();

  var SignupFormKey = GlobalKey<FormState>();
  var LoginFormKey = GlobalKey<FormState>();

  var Jwt;

  Future CheckUser(BuildContext context) async {
    try {
      var serverResponse =
          await net.mainLogin(LoginTxtUserName.text, LoginTxtPassword.text);
      if (serverResponse.statusCode == 200) {
        print(serverResponse.body);
        userName = LoginTxtUserName.text;
        Jwt = serverResponse.body;
        print('User is logged in!');
        var _json = {
          'username': LoginTxtUserName.text,
          'password': LoginTxtPassword.text
        };
        fileHandler.SaveFile(_json, fileHandler.FileSettings);
        pages.NavigateToGameSelectPageR(context);
      } else {
        // TODO: handle not logged in case
        print('user not logged in');
      }
    } catch (e) {
      print('error logging in!');
    }
  }

  Future<void> AttemptSignup(BuildContext context) async {
    try {
      var serverResponse =
          await net.mainSignup(SignupTxtUserName.text, SignupTxtPassword.text);

      print(serverResponse);

      if (serverResponse.statusCode == 200) {
        userName = SignupTxtUserName.text;

        print('User is created!');
        var _json = {'username': userName, 'password': SignupTxtPassword.text};
        fileHandler.SaveFile(_json, fileHandler.FileSettings);
        try {
          var serverResponse =
              await net.mainLogin(userName, SignupTxtPassword.text);
          if (serverResponse.statusCode == 200) {
            Jwt = serverResponse.body;
            print('User is logged in!');
          } else {
            // TODO: handle not logged in case
            print('user not logged in');
          }
        } catch (e) {
          print('error logging in!');
        }
        pages.NavigateToGameSelectPageR(context);
      } else {
        print('User not created');
      }
    } catch (e) {
      print('error signing up!');
    }
  }

  String ValidatePassword(String value) {
    if (value.isEmpty) {
      return Required;
    } else if (value.length < 6) {
      return PasswordAtLeast + 6.toString() + Character;
    } else if (value.length > 15) {
      return PasswordNotGreater + 15.toString() + Character;
    } else
      return "";
  }

  void ForgotPasswordLinkPressed() {
    //TODO FORGOT PASSWORD SCREEN GOES HERE
  }

  void NewUserLinkPressed() {
    _tabController.animateTo(1);
  }

  void LoginButtonPressed(BuildContext context) {
    if (LoginFormKey.currentState!.validate()) {
      print("Validated format");
      CheckUser(context);
    } else {
      print("Not Validated format");
    }
  }

  void SignupButtonPressed(BuildContext context) {
    if (SignupFormKey.currentState!.validate()) {
      print("Validated format");
      AttemptSignup(context);
    } else {
      print("Not Validated format");
    }
  }

  Widget WidgetScaffoldLogin(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              bottom: TabBar(
                controller: _tabController,
                isScrollable: false,
                tabs: [
                  Tab(text: Login),
                  Tab(text: Signup),
                ],
              ),
            ),
            body: TabBarView(controller: _tabController, children: [
              SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: LoginFormKey,
                  child: Column(
                    children: <Widget>[
                      settings.WidgetImage(
                          200, 150, 'assets/images/flutter_logo.png'),
                      settings.WidgetTextFormField(
                          Email, EnterValidEmail, LoginTxtUserName),
                      settings.WidgetTextFormField(
                          Password, EnterSecurePassword, LoginTxtPassword),
                      settings.WidgetTextLink(
                          ForgotPasswordLinkPressed, ForgotPassword),
                      settings.WidgetButton(context, LoginButtonPressed, Login),
                      settings.WidgetSizedBox(100),
                      settings.WidgetTextLink(NewUserLinkPressed, NewUser),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: SignupFormKey,
                  child: Column(
                    children: <Widget>[
                      settings.WidgetImage(
                          200, 150, 'assets/images/flutter_logo.png'),
                      settings.WidgetTextFormField(
                          Email, EnterValidEmail, SignupTxtUserName),
                      settings.WidgetTextFormField(
                          Password, EnterSecurePassword, SignupTxtPassword),
                      settings.WidgetSizedBox(20),
                      settings.WidgetButton(
                          context, SignupButtonPressed, Signup),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
