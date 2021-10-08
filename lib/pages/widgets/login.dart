part of '../../main.dart';

class Login extends LanguagesLogin {
  Login() {
    LanguagesSetup();
  }

  final loginTxtUserName = new TextEditingController();
  final loginTxtPassword = new TextEditingController();
  final signupTxtUserName = new TextEditingController();
  final signupTxtPassword = new TextEditingController();
  final signupTxtPassword2 = new TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  var jwt;

  Future CheckUser(BuildContext context) async {
    try {
      var serverResponse =
          await net.mainLogin(loginTxtUserName.text, loginTxtPassword.text);
      if (serverResponse.statusCode == 200) {
        print(serverResponse.body);
        userName = loginTxtUserName.text;
        jwt = serverResponse.body;
        print('User is logged in!');
        Map<String, dynamic> _json = {
          'username': loginTxtUserName.text,
          'password': loginTxtPassword.text
        };
        fileHandler.saveFile(_json, fileHandler._settings);
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
          await net.mainSignup(signupTxtUserName.text, signupTxtPassword.text);

      print(serverResponse);

      if (serverResponse.statusCode == 200) {
        userName = signupTxtUserName.text;

        print('User is created!');
        Map<String, dynamic> _json = {
          'username': userName,
          'password': signupTxtPassword.text
        };
        fileHandler.saveFile(_json, fileHandler._settings);
        try {
          var serverResponse =
              await net.mainLogin(userName, signupTxtPassword.text);
          if (serverResponse.statusCode == 200) {
            jwt = serverResponse.body;
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
      return GetText(_required);
    } else if (value.length < 6) {
      return GetText(_passwordAtLeast) + 6.toString() + GetText(_characters);
    } else if (value.length > 15) {
      return GetText(_passwordNotGreater) +
          15.toString() +
          GetText(_characters);
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
    if (loginFormKey.currentState!.validate()) {
      print("Validated format");
      CheckUser(context);
    } else {
      print("Not Validated format");
    }
  }

  void SignupButtonPressed(BuildContext context) {
    if (signupFormKey.currentState!.validate()) {
      print("Validated format");
      AttemptSignup(context);
    } else {
      print("Not Validated format");
    }
  }

  Widget widgetScaffoldLogin(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              bottom: TabBar(
                controller: _tabController,
                isScrollable: false,
                tabs: [
                  Tab(text: GetText(_login)),
                  Tab(text: GetText(_signup)),
                ],
              ),
            ),
            body: TabBarView(controller: _tabController, children: [
              SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: loginFormKey,
                  child: Column(
                    children: <Widget>[
                      settings.widgetImage(
                          200, 150, 'assets/images/flutter_logo.png'),
                      settings.widgetTextFormField(GetText(_email),
                          GetText(_enterValidEmail), loginTxtUserName),
                      settings.widgetTextFormField(GetText(_password),
                          GetText(_enterSecurePassword), loginTxtPassword),
                      settings.widgetTextLink(
                          ForgotPasswordLinkPressed, GetText(_forgotPassword)),
                      settings.widgetButton(
                          context, LoginButtonPressed, GetText(_login)),
                      settings.widgetSizedBox(100),
                      settings.widgetTextLink(
                          NewUserLinkPressed, GetText(_newUser)),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: signupFormKey,
                  child: Column(
                    children: <Widget>[
                      settings.widgetImage(
                          200, 150, 'assets/images/flutter_logo.png'),
                      settings.widgetTextFormField(GetText(_email),
                          GetText(_enterValidEmail), signupTxtUserName),
                      settings.widgetTextFormField(GetText(_password),
                          GetText(_enterSecurePassword), signupTxtPassword),
                      settings.widgetSizedBox(20),
                      settings.widgetButton(
                          context, SignupButtonPressed, GetText(_signup)),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
