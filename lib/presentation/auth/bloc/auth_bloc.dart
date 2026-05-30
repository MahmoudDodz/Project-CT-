import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SelectRoleEvent>(_onSelectRole);
    on<StartVerificationEvent>(_onStartVerification);
    on<VerificationCompleteEvent>(_onVerificationComplete);
    on<LogoutEvent>(_onLogout);
  }

  void _onSelectRole(SelectRoleEvent event, Emitter<AuthState> emit) {
    emit(RoleSelectedState(event.role));
  }

  Future<void> _onStartVerification(
    StartVerificationEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(VerifyingIdentityState(role: event.role, name: event.name));
    await Future.delayed(const Duration(seconds: 3));
    emit(IdentityVerifiedState(role: event.role, name: event.name));
    await Future.delayed(const Duration(seconds: 2));
    emit(AuthenticatedState(role: event.role, name: event.name));
  }

  void _onVerificationComplete(
    VerificationCompleteEvent event,
    Emitter<AuthState> emit,
  ) {
    if (state is IdentityVerifiedState) {
      final s = state as IdentityVerifiedState;
      emit(AuthenticatedState(role: s.role, name: s.name));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
