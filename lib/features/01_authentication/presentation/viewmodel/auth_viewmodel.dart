import 'package:flutter/material.dart';
import '../../domain/repository/auth_repository.dart';

// 1. Enum for our UI state
enum AuthState { idle, loading, success, error }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);

  // 2. Private state variables
  AuthState _state = AuthState.idle;
  String? _errorMessage;
  String? _token;

  // 3. Public getters for the UI to listen to
  AuthState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _token != null;

  // 4. Helper method to manage state changes
  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  // --- Public Methods for the UI to call ---

  Future<void> login(String email, String password) async {
    _setState(AuthState.loading);
    _errorMessage = null;

    try {
      final token = await _authRepository.login(email, password);
      _token = token;
      _setState(AuthState.success);
      // We would also save the token to secure storage here
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _setState(AuthState.error);
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _setState(AuthState.loading);
    _errorMessage = null;

    try {
      final token = await _authRepository.register(
        name: name,
        email: email,
        password: password,
      );
      _token = token;
      _setState(AuthState.success);
      // We would also save the token to secure storage here
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _setState(AuthState.error);
    }
  }

  Future<void> handleGoogleSignIn() async {
    _setState(AuthState.loading);
    _errorMessage = null;

    try {
      // This will launch the URL and listen for the redirect
      final token = await _authRepository.handleGoogleSignIn();
      _token = token;
      _setState(AuthState.success);
      // We would also save the token to secure storage here
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _setState(AuthState.error);
    }
  }
}
