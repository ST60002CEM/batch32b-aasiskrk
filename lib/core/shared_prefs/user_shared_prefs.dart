import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../failure/failure.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  return UserSharedPrefs();
});

class UserSharedPrefs {
  final LocalAuthentication _localAuth = LocalAuthentication();
  late SharedPreferences _sharedPreferences;
  Future<bool> isDeviceSupported() async {
    return await _localAuth.canCheckBiometrics;
  }

  // Set user token
  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('token', token);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get user token
  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('token');
      return right(token);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete token
  Future<Either<Failure, bool>> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('token');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Set user ID
  Future<Either<Failure, bool>> setUserId(String userId) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('userId', userId);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get user ID
  Future<Either<Failure, String?>> getUserId() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final userId = _sharedPreferences.getString('userId');
      return right(userId);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete user ID
  Future<Either<Failure, bool>> deleteUserId() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('userId');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Set user info
  Future<Either<Failure, bool>> setUserName(String name) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('fullName', name);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, String?>> getFullName() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final name = _sharedPreferences.getString('fullName');
      return right(name);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Set fingerprint enabled status
  Future<Either<Failure, bool>> setFingerprintEnabled(bool isEnabled) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setBool('fingerprintEnabled', isEnabled);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get fingerprint enabled status
  Future<Either<Failure, bool>> getFingerprintEnabled() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final isEnabled =
          _sharedPreferences.getBool('fingerprintEnabled') ?? false;
      return right(isEnabled);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Authenticate user with fingerprint
  Future<Either<Failure, bool>> authenticateWithFingerprint() async {
    try {
      // Check if fingerprint authentication is available
      if (!(await isDeviceSupported())) {
        return left(
            Failure(error: 'Fingerprint authentication is not supported'));
      }

      // Perform fingerprint authentication
      bool authenticated = await _localAuth.authenticate(
          localizedReason: 'Please authenticate to login',
          options: AuthenticationOptions(biometricOnly: true));

      return right(authenticated);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Login with fingerprint authentication
  Future<Either<Failure, bool>> loginWithFingerprint() async {
    final isEnabledResult = await getFingerprintEnabled();
    if (isEnabledResult.isLeft()) {
      return left(Failure(error: 'Failed to retrieve fingerprint settings'));
    }

    final isEnabled = isEnabledResult.getOrElse(() => false);
    if (!isEnabled) {
      return left(Failure(error: 'Fingerprint authentication is not enabled'));
    }

    return await authenticateWithFingerprint();
  }
}
