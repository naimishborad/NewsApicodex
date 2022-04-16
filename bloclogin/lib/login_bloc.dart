import 'package:bloclogin/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

class LoginBloc with Validators{
  final _loginEmail = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();

  //Gettrs
  Stream<String> get loginEmail => _loginEmail.stream.transform(emailValidator);
  Stream<String> get loginpassword => _loginPassword.stream.transform(loginPasswordValidator);

  Stream<bool> get isValid => Rx.combineLatest2(loginEmail,loginpassword,(a, b) => true);

  //setters
  Function(String) get changeEmail =>_loginEmail.sink.add;
  Function(String) get changePassword => _loginPassword.sink.add;
  void submit() {
    print(_loginEmail.value);
    print(_loginPassword.value);
  }

  void dispose(){
    _loginEmail.close();
    _loginPassword.cast();
  }
}