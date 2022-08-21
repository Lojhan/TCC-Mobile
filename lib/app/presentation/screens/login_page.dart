import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/authentication/domain/models/providers_enum.dart';
import 'package:mobile/app/presentation/BloC/authentication/authentication_bloc.dart';
import 'package:mobile/errors/errors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authBloc = Modular.get<AuthenticationBloc>();

    Widget googleButton() {
      return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        ),
        child: const Text('Login with Google'),
        onPressed: () {
          authBloc.add(const AuthenticationSignInEvent(
            provider: AuthenticationProvider.google,
          ));
        },
      );
    }

    return Scaffold(
      body: BlocListener(
        bloc: authBloc,
        listener: (context, AuthenticationState state) {
          if (state.failure is Failure) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Authentication Failure'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }

          if (state.isAuthenticated) {
            Modular.to.pushReplacementNamed('/');
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              googleButton(),
            ],
          ),
        ),
      ),
    );
  }
}
