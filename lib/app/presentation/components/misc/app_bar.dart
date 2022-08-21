import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/presentation/BloC/authentication/authentication_bloc.dart';
import 'package:mobile/app/presentation/components/misc/image_provider.dart';
import 'package:mobile/errors/errors.dart';

class ApplicationBar extends StatelessWidget implements PreferredSizeWidget {
  const ApplicationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authBloc = Modular.get<AuthenticationBloc>();

    Widget showProfileIcon(
      BuildContext context,
      AuthenticationState authState,
    ) {
      return Row(
        children: [
          InkWell(
            onTap: () => Modular.to.pushReplacementNamed('/login'),
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

    return BlocListener(
      bloc: authBloc,
      listener: (context, AuthenticationState state) {
        if (state.user == null) {
          Modular.to.pushReplacementNamed('/login');
        }
        if (state.failure is Failure) {
          Modular.to.pushReplacementNamed('/login');
        }
      },
      child: AppBar(
        title: const Text('Healthy'),
        actions: <Widget>[
          showProfileIcon(context, authBloc.state),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
