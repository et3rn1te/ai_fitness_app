import '../entity/user.dart';

abstract class AuthRepository {
  Future<String> login(String email, String password);

  Future<String> register({
    required String name,
    required String email,
    required String password,
  });

  Future<String> handleGoogleSignIn();

  Future<User> getUserFromToken(String token);

  // You can add more methods here later, like logout()
}
