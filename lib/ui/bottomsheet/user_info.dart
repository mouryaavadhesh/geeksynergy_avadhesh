import 'package:flutter/material.dart';
import 'package:geeksynergy_avadhesh/data/database/user.dart';
import 'package:geeksynergy_avadhesh/utils/template/text.dart';


class UserInfoBottomSheet {


  Future<bool?> show(
    context,SqlUser user
  ) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    GeekAvaText.textBold(text: "Company Name: ", fontSize: 14),
                    Flexible(
                      child: GeekAvaText.textMedium(
                        text: user.companyName!,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GeekAvaText.textBold(text: "Address: ", fontSize: 14),
                    Flexible(
                      child: GeekAvaText.textMedium(
                        text: user.address!,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GeekAvaText.textBold(text: "Phone: ", fontSize: 14),
                    Flexible(
                      child: GeekAvaText.textMedium(
                        text: user.phone!,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GeekAvaText.textBold(text: "Email: ", fontSize: 14),
                    Flexible(
                      child: GeekAvaText.textMedium(
                        text: user.email!,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
