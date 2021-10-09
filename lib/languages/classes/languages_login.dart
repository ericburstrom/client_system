part of '../../main.dart';

class LanguagesLogin extends Languages {
  var Required = {'English': '* Required'};
  var PasswordAtLeast = {'English': 'Password should be atleast'};
  var Characters = {'English': 'characters'};
  var PasswordNotGreater = {'English': 'Password should not be greater than'};
  var Login = {'English': 'Login'};
  var Signup = {'English': 'Signup'};
  var Email = {'English': 'Email'};
  var EnterValidEmail = {'English': 'Enter valid email id as abc@gmail.com'};
  var Password = {'English': 'Password'};
  var EnterSecurePassword = {'English': 'Enter secure password'};
  var ForgotPassword = {'English': 'Forgot Password'};
  var NewUser = {'English': 'New User? Create Account'};

  void LanguagesSetup() {
    Required['Swedish'] = '* Nödvändig';
    PasswordAtLeast['Swedish'] = 'Lösenord skall vara minst';
    Characters['Swedish'] = 'tecken';
    PasswordNotGreater['Swedish'] = 'Lösenord skall inte vara större än';
    Login['Swedish'] = 'Logga in';
    Signup['Swedish'] = 'Registrera dig';
    Email['Swedish'] = 'Epost';
    EnterValidEmail['Swedish'] =
        'Ange en giltig e-postadress som abc@gmail.com';
    Password['Swedish'] = 'Lösenord';
    EnterSecurePassword['Swedish'] = 'Ange ett säkert lösenord';
    ForgotPassword['Swedish'] = 'Glömt lösenord';
    NewUser['Swedish'] = 'Ny användare';
  }
}
