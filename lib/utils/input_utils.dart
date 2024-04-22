import 'package:flutter/services.dart';

class InputUtils {
  static FilteringTextInputFormatter denySpaces() =>
      FilteringTextInputFormatter.deny(RegExp(r'\s'));

  static FilteringTextInputFormatter filteringTextInputFormatter() =>
      FilteringTextInputFormatter(RegExp("[a-zA-Z0-9_!@#%^&*()',.?:{}|<> ]"),
          allow: true);
  static RegExp emailValidator() => RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static FilteringTextInputFormatter filteringDoubleNumberInputFormatter() =>
      FilteringTextInputFormatter(RegExp('[0-9.]'), allow: true);

  static FilteringTextInputFormatter filteringIntegerNumberInputFormatter() =>
      FilteringTextInputFormatter(RegExp('[0-9]'), allow: true);

  static FilteringTextInputFormatter filteringAmountInputFormatter() =>
      FilteringTextInputFormatter(RegExp('[1-9]+[0-9]*'), allow: true);

  static FilteringTextInputFormatter filteringCapacityDecimalInputFormatter() =>
      FilteringTextInputFormatter(
          RegExp(r'[0-9]+$|[0-9]+[0-9][.]$|([0-9]+[0-9][.][0-9]{1,2}$)',
              multiLine: true),
          allow: true);

  static FilteringTextInputFormatter filteringLorryNumberInputFormatter() =>
      FilteringTextInputFormatter(RegExp('[a-zA-Z0-9]'), allow: true);

  static FilteringTextInputFormatter filteringTextOnlyInputFormatter() =>
      FilteringTextInputFormatter(RegExp('[a-zA-Z ]'), allow: true);

  static FilteringTextInputFormatter filteringTextNumbersAndSpacesFormatter() =>
      FilteringTextInputFormatter(RegExp('[a-zA-Z0-9 ]'), allow: true);

  static FilteringTextInputFormatter filteringTextTwoConsecutiveFormatter() =>
      FilteringTextInputFormatter(RegExp(r'([a-zA-Z ])\1\1'), allow: false);

  static FilteringTextInputFormatter filteringNumberTwoConsecutiveFormatter() =>
      FilteringTextInputFormatter(RegExp(r'([0-9][0-9][0-9])'), allow: false);

  static FilteringTextInputFormatter filteringDigitsAndCapitalLetter() =>
      FilteringTextInputFormatter.allow(RegExp("[0-9A-Z]"));
}
