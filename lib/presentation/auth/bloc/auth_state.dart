import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class RoleSelectedState extends AuthState {
  final String role;
  const RoleSelectedState(this.role);
  @override
  List<Object?> get props => [role];
}

class VerifyingIdentityState extends AuthState {
  final String role;
  final String name;
  const VerifyingIdentityState({required this.role, required this.name});
  @override
  List<Object?> get props => [role, name];
}

class IdentityVerifiedState extends AuthState {
  final String role;
  final String name;
  const IdentityVerifiedState({required this.role, required this.name});
  @override
  List<Object?> get props => [role, name];
}

class AuthenticatedState extends AuthState {
  final String role;
  final String name;
  const AuthenticatedState({required this.role, required this.name});
  @override
  List<Object?> get props => [role, name];
}
