import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../services/interfaces/auth_service.dart';
import '../services/interfaces/encryption_service.dart';
import 'dart:async';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class CheckAuthStatus extends AuthEvent {}
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  const LoginRequested(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}
class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  const RegisterRequested(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}
class LogoutRequested extends AuthEvent {}
class AuthStateChanged extends AuthEvent {
  final String? userId;
  const AuthStateChanged(this.userId);
  @override
  List<Object> get props => [userId ?? ""];
}

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class Authenticated extends AuthState {
  final String userId;
  const Authenticated(this.userId);
  @override
  List<Object> get props => [userId];
}
class Unauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object> get props => [message];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final EncryptionService _encryptionService;
  StreamSubscription? _authSub;

  AuthBloc(this._authService, this._encryptionService) : super(AuthInitial()) {
    on<CheckAuthStatus>((event, emit) {
      _authSub = _authService.authStateChanges.listen((userId) {
        add(AuthStateChanged(userId));
      });
    });
    
    on<AuthStateChanged>((event, emit) {
      if (event.userId != null) {
        emit(Authenticated(event.userId!));
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.signIn(event.email, event.password);
        final userId = _authService.currentUserId;
        if (userId != null) {
           await _encryptionService.initKey(userId, event.password);
           emit(Authenticated(userId));
        } else {
           emit(const AuthError("Failed to authenticate"));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authService.register(event.email, event.password);
        final userId = _authService.currentUserId;
        if (userId != null) {
           await _encryptionService.initKey(userId, event.password);
           emit(Authenticated(userId));
        } else {
           emit(const AuthError("Failed to register"));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
       emit(AuthLoading());
       await _authService.signOut();
       emit(Unauthenticated());
    });
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    return super.close();
  }
}
