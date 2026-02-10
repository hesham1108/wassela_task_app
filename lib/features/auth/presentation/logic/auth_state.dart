part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {
  final String sentence;
  const AuthLoading({  this.sentence = ""});
  @override
  List<Object> get props => [sentence];
}
final class AuthSuccess extends AuthState {
  final dynamic authResponse;
  const AuthSuccess({ required this.authResponse});
  @override
  List<Object> get props => [authResponse];
}




final class AuthFailure extends AuthState {
  final String errorMessage;
  final bool isPop;
  const AuthFailure({
    required this.errorMessage,
    this.isPop = false,
  });
  @override
  List<Object> get props => [
        errorMessage,
        isPop,
      ];
}
