part of '../../main.dart';

class LanguagesLogin extends Languages {
  var _required = {'English': '* Required'};
  var _passwordAtLeast = {'English': 'Password should be atleast'};
  var _characters = {'English': 'characters'};
  var _passwordNotGreater = {'English': 'Password should not be greater than'};
  var _login = {'English': 'Login'};
  var _signup = {'English': 'Signup'};
  var _email = {'English': 'Email'};
  var _enterValidEmail = {'English': 'Enter valid email id as abc@gmail.com'};
  var _password = {'English': 'Password'};
  var _enterSecurePassword = {'English': 'Enter secure password'};
  var _forgotPassword = {'English': 'Forgot Password'};
  var _newUser = {'English': 'New User? Create Account'};

  void LanguagesSetup() {
    _required['Swedish'] = '* Nödvändig';
    _passwordAtLeast['Swedish'] = 'Lösenord skall vara minst';
    _characters['Swedish'] = 'tecken';
    _passwordNotGreater['Swedish'] = 'Lösenord skall inte vara större än';
    _login['Swedish'] = 'Logga in';
    _signup['Swedish'] = 'Registrera dig';
    _email['Swedish'] = 'Epost';
    _enterValidEmail['Swedish'] =
        'Ange en giltig e-postadress som abc@gmail.com';
    _password['Swedish'] = 'Lösenord';
    _enterSecurePassword['Swedish'] = 'Ange ett säkert lösenord';
    _forgotPassword['Swedish'] = 'Glömt lösenord';
    _newUser['Swedish'] = 'Ny användare';
  }
}
