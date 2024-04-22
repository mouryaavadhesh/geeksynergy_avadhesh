import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksynergy_avadhesh/config/route.dart';
import 'package:geeksynergy_avadhesh/ui/login/cubit/login_cubit.dart';
import 'package:geeksynergy_avadhesh/utils/base/cubit.dart';
import 'package:geeksynergy_avadhesh/utils/template/text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context),
      child: BlocConsumer<LoginCubit, BlocState>(
        listener: (context, state) {},
        listenWhen: (previous, current) => current is PrefillState,
        buildWhen: (previous, current) {
          return current is InitialState;
        },
        builder: (context, state) {
          if (state is InitialState) {
            return SafeArea(
              child: WillPopScope(
                  onWillPop: () =>
                      context.read<LoginCubit>().onClickBack(context),
                  child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      appBar: AppBar(
                        centerTitle: true,
                        title: const Text("Login"),
                      ),
                      body: screenBody(context))),
            );
          }
          return const SizedBox(
            height: 0,
          );
        },
      ),
    );
  }


  Widget screenBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getForm(context.read<LoginCubit>()),
        const SizedBox(height: 20,),
        getButton(context.read<LoginCubit>()),
        const SizedBox(height: 20,),
        signupButton(context.read<LoginCubit>())
      ],
    );
  }

  Widget _getForm(LoginCubit cubit) {
    return Card(
        margin: const EdgeInsets.all(20.0),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),

                StreamBuilder<String>(
                    stream: cubit.emailStream,
                    builder: (context, snapshot) {
                      return TextField(
                        maxLength: 30,
                        controller: _emailController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        onChanged: (text) => {cubit.updateEmail(text)},
                        decoration: _getBorderDecoration(
                            cubit,
                            "Enter email",
                            snapshot.hasError,
                            snapshot.error as String?,
                            false,
                            snapshot.hasData,"Email"),
                      );
                    }),

                const SizedBox(
                  height: 16,
                ),

                StreamBuilder<String>(
                    stream: cubit.passwordStream,
                    builder: (context, snapshot) {
                      return TextField(
                        maxLength: 11,
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        onChanged: (text) => {cubit.updatePassword(text)},
                        decoration: _getBorderDecoration(
                            cubit,
                            "Enter Password",
                            snapshot.hasError,
                            snapshot.error as String?,
                            false,
                            snapshot.hasData,"Password"),
                      );
                    }),
              ],
            )));
  }

  getButton(LoginCubit cubit) {
    return StreamBuilder<bool>(
        stream: cubit.validateForm,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  snapshot.hasData ? Colors.blue : Colors.blue.shade200,
                ),
                onPressed: () {
                  if (snapshot.hasData) {
                    cubit.onSubmitClicked(context);
                  }
                },
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GeekAvaText.textMedium(text:"Login",fontSize: 14,color: Colors.white),
                  ],
                ),
              ),
            ),
          );
        });
  }

  signupButton(LoginCubit cubit) {
    return StreamBuilder<bool>(
        stream: cubit.validateForm,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.blue ,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.registration, (Route<dynamic> route) => false);
                },
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GeekAvaText.textMedium(text:"Signup",fontSize: 14,color: Colors.white),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _getBorderDecoration(LoginCubit cubit, String hintText, bool hasError,
      String? error, bool isShowClearIcon, bool hasData,String labelText) {
    InputDecoration decoration = InputDecoration(
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        errorText: hasError ? error : null,
        counterText: '',
        labelText:labelText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        hintText: hintText);

    return decoration;
  }
}
