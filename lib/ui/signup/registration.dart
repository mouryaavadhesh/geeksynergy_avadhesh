import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksynergy_avadhesh/ui/signup/cubit/reg_cubit.dart';
import 'package:geeksynergy_avadhesh/utils/base/cubit.dart';
import 'package:geeksynergy_avadhesh/utils/input_utils.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit(context),
      child: BlocConsumer<RegistrationCubit, BlocState>(
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
                      context.read<RegistrationCubit>().onClickBack(context),
                  child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      appBar: AppBar(
                        centerTitle: true,
                        title: const Text("Registration"),
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
        _getForm(context.read<RegistrationCubit>()),
        const Spacer(),
        getButton(context.read<RegistrationCubit>())
      ],
    );
  }

  Widget _getForm(RegistrationCubit cubit) {
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
                    stream: cubit.companyNameStream,
                    builder: (context, snapshot) {
                      return TextField(
                        maxLength: 30,
                        controller: _companyNameController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          InputUtils.filteringTextNumbersAndSpacesFormatter(),
                          InputUtils.filteringTextTwoConsecutiveFormatter(),
                          InputUtils.filteringNumberTwoConsecutiveFormatter(),
                        ],
                        onChanged: (text) => {cubit.updateCompanyName(text)},
                        decoration: _getBorderDecoration(
                            cubit,
                            "Enter company name",
                            snapshot.hasError,
                            snapshot.error as String?,
                            false,
                            snapshot.hasData,"Company Name"),
                      );
                    }),
                const SizedBox(
                  height: 16,
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
                    stream: cubit.phoneStream,
                    builder: (context, snapshot) {
                      return TextField(
                        maxLength: 11,
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          InputUtils.filteringIntegerNumberInputFormatter(),
                        ],
                        onChanged: (text) => {cubit.updatePhone(text)},
                        decoration: _getBorderDecoration(
                            cubit,
                            "Enter phone number",
                            snapshot.hasError,
                            snapshot.error as String?,
                            false,
                            snapshot.hasData,"Phone Number"),
                      );
                    }),
                const SizedBox(
                  height: 16,
                ),
                StreamBuilder<String>(
                    stream: cubit.addressStream,
                    builder: (context, snapshot) {
                      return TextField(
                        maxLength: 50,
                        controller: _addressController,
                        keyboardType: TextInputType.text,
                        onChanged: (text) => {cubit.updateAddress(text)},
                        decoration: _getBorderDecoration(
                            cubit,
                            "Enter address",
                            snapshot.hasError,
                            snapshot.error as String?,
                            false,
                            snapshot.hasData,"Address"),
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

  getButton(RegistrationCubit cubit) {
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("submit"),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _getBorderDecoration(RegistrationCubit cubit, String hintText, bool hasError,
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
