import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/presentation/BloC/authentication/authentication_bloc.dart';
import 'package:mobile/app/presentation/components/misc/image_provider.dart';

class ApplicationBar extends StatelessWidget implements PreferredSizeWidget {
  const ApplicationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authBloc = Modular.get<AuthenticationBloc>();

    Widget showProfileIcon(
      BuildContext context,
      AuthenticationState authState,
    ) {
      if (Modular.to.path.contains('profile')) {
        return const SizedBox();
      }
      return Row(
        children: [
          InkWell(
            onTap: () => Modular.to.pushNamed('/profile'),
            child: CircleAvatar(
              backgroundImage: getImageProvider(
                authState.user?.photoUrl ?? '',
              ),
              radius: 15,
            ),
          ),
          const SizedBox(width: 15),
        ],
      );
    }

    String? getBarTitle() {
      return {
        '/': 'Predict Disease App',
        '/profile': 'Profile',
      }[Modular.to.path];
    }

    return BlocListener(
      bloc: authBloc,
      listener: (context, AuthenticationState state) {
        if (!state.isAuthenticated) {
          Modular.to.pushReplacementNamed('/login');
        }
      },
      child: AppBar(
        title: Text(getBarTitle() ?? ''),
        actions: <Widget>[
          showProfileIcon(context, authBloc.state),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
