import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app_module.dart';
import 'package:mobile/navigator.dart';

void main() async {
  runApp(ModularApp(
    module: AppModule(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = Modular.get();

    return MaterialApp.router(
      title: 'Prediction App',
      theme: ThemeData.dark(),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      key: navigationService.navigationKey,
    ); //added by extension
  }
}
