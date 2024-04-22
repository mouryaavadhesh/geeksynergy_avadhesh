import 'package:geeksynergy_avadhesh/data/database/user.dart';

class Sql {
  static SqlUser userDetail = SqlUser();
  static String userTable = 'users';


  static String createUserTable =
      'CREATE TABLE $userTable(${UserColumn.id} INTEGER PRIMARY KEY, ${UserColumn.companyName} TEXT, '
      '${UserColumn.email} TEXT,  ${UserColumn.phoneNumber} TEXT,'
      ' ${UserColumn.address} TEXT, ${UserColumn.password} TEXT)';

}

class UserColumn {
  static String id = 'id';
  static String companyName = 'company_name';
  static String email = 'email';
  static String phoneNumber = 'phone_number';
  static String address = 'address';
  static String password = 'password';
}