import 'package:eazr/core/injectable_modules/injection_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

final di = GetIt.I;

@InjectableInit()
Future<void> configureDependencies() async {
  di.init();
}

// Future<void> configureHives() async {
//   await Hive.initFlutter();
//
//   await Hive.openBox<dynamic>(HiveConstants.userBox);
// }