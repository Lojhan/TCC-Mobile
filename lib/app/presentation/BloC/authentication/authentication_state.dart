part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationProvider? provider;
  final UserModel? user;
  final Failure? failure;

  const AuthenticationState({
    required this.provider,
    required this.user,
    required this.failure,
  });

  factory AuthenticationState.copyWith(
    AuthenticationState state,
    AuthenticationState? newState,
  ) {
    return AuthenticationState(
      provider: newState?.provider ?? state.provider,
      user: newState?.user ?? state.user,
      failure: newState?.failure ?? state.failure,
    );
  }

  factory AuthenticationState.initial() {
    return const AuthenticationState(
      provider: null,
      user: null,
      failure: null,
    );
  }

  factory AuthenticationState.failure(Failure failure) {
    return AuthenticationState(
      provider: null,
      user: null,
      failure: failure,
    );
  }

  factory AuthenticationState.login(
    UserModel user,
    AuthenticationProvider provider,
  ) {
    return AuthenticationState(
      provider: provider,
      user: user,
      failure: null,
    );
  }

  factory AuthenticationState.signUp(
    UserModel user,
    AuthenticationProvider provider,
  ) {
    return AuthenticationState.login(user, provider);
  }

  @override
  List<Object?> get props => [user, failure];

  bool get isAuthenticated {
    if (failure is Failure) {
      return false;
    }

    if (provider == null) {
      return false;
    }

    if (user is UserModel) {
      return true;
    }

    return false;
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider?.toString(),
      'user': user?.toJson(),
      'failure': failure ?? '',
    };
  }

  static AuthenticationState? fromJson(Map<String, dynamic>? json) {
    Failure? failure = mapToFailure(json?['failure']);

    if (json == null) {
      return AuthenticationState.initial();
    }

    if (failure is Failure) {
      return AuthenticationState.initial();
    }

    if (json['user'] == null) {
      return AuthenticationState.initial();
    }

    final provider = mapToProvider(json['provider']);
    final user = UserModel.fromJson(json['user']);

    return AuthenticationState(
      provider: provider,
      user: user,
      failure: failure,
    );
  }

  static AuthenticationProvider mapToProvider(String provider) {
    return AuthenticationProvider.values.firstWhere(
      (e) => e.toString() == provider,
      orElse: () => AuthenticationProvider.credentials,
    );
  }

  static Failure? mapToFailure(dynamic failure) {
    if (failure != null && failure is String && failure != '') {
      return Failure();
    }
    return null;
  }
}
