import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {

  AuthService._();

  static final AuthService instance =
      AuthService._();

  final FlutterSecureStorage storage =
      const FlutterSecureStorage();

  Future<bool> login({
    required String username,
    required String password,
  }) async {

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (
      username == 'mor_2314' &&
      password == '83r5^_'
    ) {

      await storage.write(
        key: 'token',
        value: 'fake_token',
      );

      return true;
    }

    return false;
  }

  Future<bool> isLogged() async {

    final token =
        await storage.read(key: 'token');

    return token != null;
  }

  Future<void> logout() async {

    await storage.delete(key: 'token');
  }
}