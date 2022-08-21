import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/authentication/authentication_module.dart';
import 'package:mobile/app/main/main_module.dart';
import 'package:mobile/app/presentation/guards/auth_guard.dart';
import 'package:mobile/app/presentation/screens/login_page.dart';
import 'package:mobile/app/presentation/screens/profile_page.dart';
import 'package:mobile/app/presentation/screens/sign_up_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((inject) => Dio(
              BaseOptions(
                connectTimeout: 1000,
                sendTimeout: 1000,
                receiveTimeout: 1000,
              ),
            )),
        ...AuthenticationModule.binds,
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: MainModule(),
          guards: [AuthGuard()],
        ),
        ChildRoute(
          '/profile',
          child: (_, __) => const ProfilePage(),
          guards: [AuthGuard()],
          transition: TransitionType.defaultTransition,
        ),
        ChildRoute(
          '/login',
          child: (_, __) => const LoginPage(),
        ),
        ChildRoute(
          '/sign-up',
          child: (_, __) => const SignUpPage(),
        ),
      ];
}
