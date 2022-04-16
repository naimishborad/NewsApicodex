import 'package:bloclogin/validators.dart';
import 'package:rxdart/rxdart.dart';
class RegisterBloc with Validators{
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _phonenumber = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirmpassword = BehaviorSubject<String>();

  //Getters
  Stream<String> get name => _name.stream.transform(nameValidator);
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get phonenumber => _phonenumber.stream.transform(phoneValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<String> get confirmpassword => _confirmpassword.stream.transform(passwordValidator);

  Stream<bool> get isValid => Rx.combineLatest5(name,email,phonenumber,password,confirmpassword,(a, b, c, d, e) => true);
  Stream<bool> get isPasswordMatched => Rx.combineLatest2(password,confirmpassword,(a,b){
    if(a != b){
      return false;
    }
    else{
      return true;
    }
  });

  //setters
  Function(String) get ChangeName => _name.sink.add;
  Function(String) get ChangeEmail => _email.sink.add;
  Function(String) get ChangePhone => _phonenumber.sink.add;
  Function(String) get ChangePassword => _password.sink.add;
  Function(String) get ChangeConfirmPassword => _confirmpassword.sink.add;

  void display(){
    _name.close();
    _email.close();
    _phonenumber.close();
    _password.close();
    _confirmpassword.close();
  }
}