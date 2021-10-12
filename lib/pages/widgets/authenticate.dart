part of '../../main.dart';

class Authenticate extends LanguagesLogin {
  Authenticate() {
    LanguagesSetup();
  }

  late TabController _tabController;

  final LoginTxtUserName = TextEditingController();
  final LoginTxtPassword = TextEditingController();
  final SignupTxtUserName = TextEditingController();
  final SignupTxtPassword = TextEditingController();
  final SignupTxtPassword2 = TextEditingController();

  var SignupFormKey = GlobalKey<FormState>();
  var LoginFormKey = GlobalKey<FormState>();

  //var Jwt;

  Future CheckUser(BuildContext context) async {
    try {
      var serverResponse =
          await net.mainLogin(LoginTxtUserName.text, LoginTxtPassword.text);
      if (serverResponse.statusCode == 200) {
        print(serverResponse.body);
        userName = LoginTxtUserName.text;
        //Jwt = serverResponse.body;
        print('User is logged in!');
        var _json = {
          'username': LoginTxtUserName.text,
          'password': LoginTxtPassword.text
        };
        fileHandler.SaveFile(_json, fileHandler.FileSettings);
        pages.NavigateToSelectPageR(context);
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
            //Jwt = serverResponse.body;
            print('User is logged in!');
          } else {
            // TODO: handle not logged in case
            print('user not logged in');
          }
        } catch (e) {
          print('error logging in!');
        }
        pages.NavigateToSelectPageR(context);
      } else {
        print('User not created');
      }
    } catch (e) {
      print('error signing up!');
    }
  }

  String ValidatePassword(String value) {
    if (value.isEmpty) {
      return Required_;
    } else if (value.length < 6) {
      return PasswordAtLeast_ + 6.toString() + Characters_;
    } else if (value.length > 15) {
      return PasswordNotGreater_ + 15.toString() + Characters_;
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
                  Tab(text: Login_),
                  Tab(text: Signup_),
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
                          Email_, EnterValidEmail_, LoginTxtUserName),
                      settings.WidgetTextFormField(
                          Password_, EnterSecurePassword_, LoginTxtPassword),
                      settings.WidgetTextLink(
                          ForgotPasswordLinkPressed, ForgotPassword_),
                      settings.WidgetButton(
                          context, LoginButtonPressed, Login_),
                      settings.WidgetSizedBox(100),
                      settings.WidgetTextLink(NewUserLinkPressed, NewUser_),
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
                          Email_, EnterValidEmail_, SignupTxtUserName),
                      settings.WidgetTextFormField(
                          Password_, EnterSecurePassword_, SignupTxtPassword),
                      settings.WidgetSizedBox(20),
                      settings.WidgetButton(
                          context, SignupButtonPressed, Signup_),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
