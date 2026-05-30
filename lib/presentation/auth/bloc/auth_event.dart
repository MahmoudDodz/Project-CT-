import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SelectRoleEvent extends AuthEvent {
  final String role;
  const SelectRoleEvent(this.role);
  @override
  List<Object?> get props => [role];
}

class StartVerificationEvent extends AuthEvent {
  final String role;
  final String name;
  final String email;
  const StartVerificationEvent({
    required this.role,
    required this.name,
    required this.email,
  });
  @override
  List<Object?> get props => [role, name, email];
}

class VerificationCompleteEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
