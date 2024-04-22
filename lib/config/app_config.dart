class AppConfig {
  static const bool isFullProduction = bool.fromEnvironment('isProduction');
  static const bool isTestingMode = !bool.fromEnvironment('isProduction');
  static const String version =
      String.fromEnvironment('versionname', defaultValue: '1.06');
  static const int testingVersion =
      int.fromEnvironment('buildnumber', defaultValue: 6);
  static const bool enableLogging = true;
  static const List<String> filterApi = [];

  static const bool isApiProduction = bool.fromEnvironment('isProduction');
  static const bool isPaymentApiProduction =
      bool.fromEnvironment('isProduction');
  static const bool isCashfreeProduction = bool.fromEnvironment('isProduction');

  static const bool printAllApi = !bool.fromEnvironment('isProduction');
  static const bool printApi = !bool.fromEnvironment('isProduction');
  static const bool printPaymentApi = !bool.fromEnvironment('isProduction');
  static const bool isControlGroupForPaymentsEnabled = true;
  static const bool isTransactionPaymentsEnabled = false;
  static const kGoogleApiKey = 'AIzaSyCFQJ5_CEFm07io0EMwOfEYBUwEtqvAdEw';
}
