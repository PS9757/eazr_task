import 'package:eazr/core/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@module

/// Network Injectabl eModule to inject lib to make http requests,
/// InternetConnectionChecker and API via DI (Dependency injection)
abstract class NetworkInjectableModule {
  /// Networking Library
  @LazySingleton()
  http.Client get client => http.Client();

  // /// Library to check if device has active internet connection
  // @LazySingleton()
  // InternetConnectionChecker get internetConnectionChecker =>
  //     InternetConnectionChecker();

  // /// API
//  final reader =ConfigReader.initialize();
  @LazySingleton()
  API get api => API();
}
