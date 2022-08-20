import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/authentication/authentication_module.dart';
import 'package:mobile/app/main/main_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((inject) => Dio(BaseOptions(
              connectTimeout: 1000,
              sendTimeout: 1000,
              receiveTimeout: 1000,
            ))),
        ...AuthenticationModule.binds
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: MainModule()),
      ];
}
