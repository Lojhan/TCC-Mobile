part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationSignInEvent extends AuthenticationEvent {
  final AuthenticationProvider provider;
  final CredentialsPayload? credentialspPayload;

  const AuthenticationSignInEvent({
    required this.provider,
    this.credentialspPayload,
  });
}

class AuthenticationSignOutEvent extends AuthenticationEvent {
  final AuthenticationProvider provider;
  const AuthenticationSignOutEvent({required this.provider});
}

class AuthenticationSignUpEvent extends AuthenticationEvent {
  final AuthenticationProvider provider;
  final CredentialsPayload? credentialspPayload;
  const AuthenticationSignUpEvent({
    required this.provider,
    this.credentialspPayload,
  });
}
