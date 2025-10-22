import '../../domain/entity/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../api/auth_api.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl(this.authApi);

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await authApi.login(email, password);
      return response.data['token'];
    } catch (e) {
      // TODO: Handle Dio errors and re-throw custom exceptions
      throw Exception('Login Failed: $e');
    }
  }

  @override
  Future<String> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await authApi.register(
        name: name,
        email: email,
        password: password,
      );
      return response.data['token'];
    } catch (e) {
      // TODO: Handle Dio errors
      throw Exception('Registration Failed: $e');
    }
  }

  @override
  Future<String> handleGoogleSignIn() async {
    // This is the complex part we'll tackle next.
    // 1. Launch the Google Sign-In URL from authApi
    await authApi.startGoogleSignInFlow();

    // 2. Listen for the redirect back to the app (e.g., 'myapp://oauth2/redirect?token=...')
    // We'll need a package like uni_links for this.

    // 3. Extract the token from the redirect URL
    final token = await _listenForRedirectToken();
    return token;
  }

  @override
  Future<User> getUserFromToken(String token) async {
    try {
      final response = await authApi.getUserProfile(token);
      // Parse the JSON response into our UserModel
      final userModel = UserModel.fromJson(response.data);
      // Convert the UserModel (DTO) into a clean User entity
      return userModel.toEntity();
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  // Placeholder for the deep-link listening logic
  Future<String> _listenForRedirectToken() async {
    // TODO: Implement deep link listener (e.g., uni_links)
    // This will wait for the app to open via a URL
    // and parse the 'token' from it.
    await Future.delayed(const Duration(seconds: 10)); // Simulating wait
    return 'fake_token_from_google_redirect';
  }
}
