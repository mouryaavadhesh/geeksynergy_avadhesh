import 'package:flutter/material.dart';
import 'package:geeksynergy_avadhesh/config/route.dart';
import 'package:geeksynergy_avadhesh/data/database/sql.dart';
import 'package:geeksynergy_avadhesh/utils/base/app_instance.dart';
import 'package:geeksynergy_avadhesh/utils/base/cubit.dart';
import 'package:geeksynergy_avadhesh/utils/input_utils.dart';
import 'package:geeksynergy_avadhesh/utils/widget/reusable_widget.dart';
import 'package:rxdart/rxdart.dart';

part 'login_state.dart';

class LoginCubit extends AppBlocHandler<BlocState> {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailController.stream;

  Stream<String> get passwordStream => _passwordController.stream;

  final BuildContext _context;

  Stream<bool> get validateForm =>
      Rx.combineLatest2(emailStream, passwordStream, (
        String email,
        String password,
      ) {
        return true;
      });

  LoginCubit(this._context) : super(InitialState()) {
    _init();
  }

  void _init() {}

  void updateEmail(String value) {
    if (value.isEmpty) {
      _emailController.sink.addError("Please enter email address");
    } else if (!InputUtils.emailValidator().hasMatch(value)) {
      _emailController.sink.addError("Please enter valid email address");
    } else {
      _emailController.sink.add(value);
    }
  }

  void updatePassword(String value) {
    if (value.isEmpty) {
      _passwordController.sink.addError("Please enter password");
    } else {
      _passwordController.sink.add(value);
    }
  }

  Future<void> onSubmitClicked(BuildContext context) async {
    AppInstance()
        .databaseHelper
        .readUser(UserColumn.email, _emailController.value)
        .then((value) async {
          print(value?.password);
      if (value != null &&
          value.email != null &&
          value.email!.isNotEmpty &&
          value.email != _emailController.value ) {
        ReusableWidget.toastError(
            "Please enter valid email");
      }else  if(value?.password != _passwordController.value){
        ReusableWidget.toastError(
            "Please enter valid password");
      } else {
        AppInstance()
            .sharedPreferences
            .setString("email", _emailController.value);
        ReusableWidget.toastError("Login successful");
        navigateToHome(context);
      }
    });
  }

  navigateToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.homeRoute, (Route<dynamic> route) => false);
  }

  Future<bool> onClickBack(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
    return Future.value(true);
  }
}
