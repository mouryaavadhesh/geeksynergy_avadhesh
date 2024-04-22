import 'package:flutter/material.dart';
import 'package:geeksynergy_avadhesh/config/route.dart';
import 'package:geeksynergy_avadhesh/data/database/sql.dart';
import 'package:geeksynergy_avadhesh/data/database/user.dart';
import 'package:geeksynergy_avadhesh/utils/base/app_instance.dart';
import 'package:geeksynergy_avadhesh/utils/base/cubit.dart';
import 'package:geeksynergy_avadhesh/utils/input_utils.dart';
import 'package:geeksynergy_avadhesh/utils/widget/reusable_widget.dart';
import 'package:rxdart/rxdart.dart';

part 'reg_state.dart';

class RegistrationCubit extends AppBlocHandler<BlocState> {
  final _companyNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _addressController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get companyNameStream => _companyNameController.stream;

  Stream<String> get emailStream => _emailController.stream;

  Stream<String> get phoneStream => _phoneController.stream;

  Stream<String> get addressStream => _addressController.stream;

  Stream<String> get passwordStream => _passwordController.stream;

  final BuildContext _context;

  Stream<bool> get validateForm => Rx.combineLatest5(companyNameStream,
          emailStream, phoneStream, addressStream, passwordStream, (
        String companyName,
        String email,
        String phone,
        String address,
        String password,
      ) {
        return true;
      });

  RegistrationCubit(this._context) : super(InitialState()) {
    _init();
  }

  void _init() {}

  void updateCompanyName(String value) {
    if (value.isEmpty) {
      _companyNameController.sink.addError("Please enter name");
    } else {
      _companyNameController.sink.add(value);
    }
  }

  void updateEmail(String value) {
    if (value.isEmpty) {
      _emailController.sink.addError("Please enter email address");
    } else if (!InputUtils.emailValidator().hasMatch(value)) {
      _emailController.sink.addError("Please enter valid email address");
    } else {
      _emailController.sink.add(value);
    }
  }

  void updatePhone(String value) {
    if (value.isEmpty) {
      _phoneController.sink.addError("Please enter phone number");
    }  else if (value.length < 9) {
      _addressController.sink
          .addError('Phone number must be at least 10 digit');
    }else {
      _phoneController.sink.add(value);
    }
  }

  void updateAddress(String value) {
    if (value.isEmpty) {
      _addressController.sink.addError("Please enter address");
    } else if (value.length < 3) {
      _addressController.sink
          .addError('Password must be at least 3 characters');
    } else {
      _addressController.sink.add(value);
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
        .readUser( UserColumn.email, _emailController.value)
        .then((value) async {

      if (value != null &&
          value.email != null &&
          value.email!.isNotEmpty) {
        ReusableWidget.toastError("User already exist please enter different email");
      }else {
        var userModel = SqlUser(
            companyName: _companyNameController.value,
            email: _emailController.value,
            phone: _phoneController.value,
            address: _addressController.value,
            password: _passwordController.value);
        await AppInstance()
            .sharedPreferences
            .setString("email", _emailController.value);
        await AppInstance().databaseHelper.insert(
            Sql.userTable,
            userModel.toMap());
        ReusableWidget.toastError("User register successful");

        onClickBack(context);
      }
    });
  }



  Future<bool> onClickBack(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
    return Future.value(true);
  }
}
