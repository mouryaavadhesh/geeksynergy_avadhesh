import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geeksynergy_avadhesh/utils/print_utils.dart';

class Utils {
  static Future<void> captureException(
      Object exception, StackTrace stackTrace) async {
    PrintUtils.printColorText(
        'Logging Exception: $exception====>$stackTrace', PrintColor.Red,
        isException: true);
  }

  static normalPrint(String value) {
    PrintUtils.printColorText('-----Start-------', PrintColor.Yellow);
    PrintUtils.printColorText(value, PrintColor.Black);
    PrintUtils.printColorText('-----End-------', PrintColor.Cyan);
  }

  static  Color convertColorTextToColor(String colorText) {
    switch (colorText.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.greenAccent;
      case 'blue':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  static  List<String> extractStringsAssociatedWithDollarSign(String input) {
    RegExp regex = RegExp(r'\$\d+');
    List<String> extractedStrings = [];

    regex.allMatches(input).forEach((match) {
      extractedStrings.add(match.group(0)!);
    });

    return extractedStrings;
  }
  static printAPIRequest(RequestOptions? requestOptions, List<String>? urls,
      {bool headerRequired = false, bool responseRequired = false}) {
    try {
      if (urls != null && urls.isNotEmpty) {
        urls
            .where(
                (element) => requestOptions!.uri.toString().contains(element))
            .forEach((element) {
          _printRequest(requestOptions,
              headerRequired: headerRequired,
              responseRequired: responseRequired);
        });
      } else {
        _printRequest(requestOptions,
            headerRequired: headerRequired, responseRequired: responseRequired);
      }
    } catch (exception, stackTrace) {
      Utils.captureException(exception, stackTrace);
    }
  }
  static _printRequest(RequestOptions? requestOptions,
      {bool headerRequired = false, bool responseRequired = false}) {
    if (requestOptions != null) {
      PrintUtils.printColorText(
          "API====>${requestOptions.uri}", PrintColor.Magenta);
      PrintUtils.printColorText(
          "REQUEST TYPE====>${requestOptions.method}", PrintColor.Magenta);
      PrintUtils.printColorText(
          "TOKEN====>${requestOptions.headers["token"]}", PrintColor.Magenta);
      PrintUtils.printColorText(
          "PAYLOAD====>${requestOptions.data is FormData ? (requestOptions.data as FormData).fields.toString() : requestOptions.data}",
          PrintColor.Magenta);
      if (headerRequired) {
        PrintUtils.printColorText(
            "HEADER==>${requestOptions.headers}", PrintColor.Magenta);
      }
    }
  }



}
