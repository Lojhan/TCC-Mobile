import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/authentication/domain/models/providers_enum.dart';
import 'package:mobile/app/presentation/BloC/authentication/authentication_bloc.dart';
import 'package:mobile/app/presentation/components/misc/app_bar.dart';
import 'package:mobile/app/presentation/components/misc/image_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authBloc = Modular.get<AuthenticationBloc>();

    void signOut() {
      authBloc.add(const AuthenticationSignOutEvent(
        provider: AuthenticationProvider.google,
      ));
    }

    Widget profilePictureContainer(String? photoUrl) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(100),
            width: 120,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: getImageProvider(photoUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      );
    }

    Widget nameContainer(String? name) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        );

    Widget emailContainer(String? email) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              email ?? '',
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        );

    Widget signOutButton() => Center(
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            ),
            onPressed: signOut,
            child: const Text('Sign Out'),
          ),
        );

    return BlocBuilder(
      bloc: authBloc,
      builder: (context, AuthenticationState state) {
        return Scaffold(
          appBar: const ApplicationBar(),
          body: ListView(
            children: [
              profilePictureContainer(state.user?.photoUrl),
              nameContainer(state.user?.name),
              const SizedBox(height: 10),
              emailContainer(state.user?.email),
              const SizedBox(height: 40),
              signOutButton(),
            ],
          ),
        );
      },
    );
  }
}
