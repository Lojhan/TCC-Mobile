import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/presentation/BloC/authentication/authentication_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authBloc = Modular.get<AuthenticationBloc>();

    return const Scaffold(
      body: Center(),
    );
  }
}
