import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/presentation/BloC/authentication/authentication_bloc.dart';
import 'package:mobile/errors/errors.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    AuthenticationBloc authBloc = Modular.get<AuthenticationBloc>();

    final state = authBloc.state;

    if (state.user == null) {
      Modular.to.pushReplacementNamed('/login');
    }

    if (state.failure is Failure) {
      Modular.to.pushReplacementNamed('/login');
    }

    return true;
  }
}
