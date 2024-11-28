part of 'email_and_password_cubit.dart';

@immutable
sealed class EmailAndPasswordState {}

final class EmailAndPasswordInitial extends EmailAndPasswordState {}
final class EmailAndPasswordLoginLoading extends EmailAndPasswordState {}
final class EmailAndPasswordLoginSuccess extends EmailAndPasswordState {}
final class EmailAndPasswordLoginError extends EmailAndPasswordState {
  String msg;
  EmailAndPasswordLoginError(this.msg);

}


final class EmailAndPasswordSignUpLoading extends EmailAndPasswordState {}
final class EmailAndPasswordSignUpSuccess extends EmailAndPasswordState {}
final class EmailAndPasswordSignUpError extends EmailAndPasswordState {
  String msg;
  EmailAndPasswordSignUpError(this.msg);

}

final class EmailAndPasswordLougOUtLoading extends EmailAndPasswordState {}
final class EmailAndPasswordLougOUtSuccess extends EmailAndPasswordState {}


final class ResetPassLoading extends EmailAndPasswordState {}
final class ResetPassSuccess extends EmailAndPasswordState {}
final class ResetPassError extends EmailAndPasswordState {
  String msg;

  ResetPassError(this.msg);
}