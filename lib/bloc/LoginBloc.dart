import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'Validator.dart';

class LoginBloc with Validator {


  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  String get email => _emailController.value;
  String get password => _passwordController.value;

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get isValid =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}