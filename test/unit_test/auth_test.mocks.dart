// Mocks generated by Mockito 5.4.4 from annotations
// in playforge/test/unit_test/auth_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:io' as _i6;

import 'package:dartz/dartz.dart' as _i2;
import 'package:local_auth/local_auth.dart' as _i12;
import 'package:local_auth_android/local_auth_android.dart' as _i13;
import 'package:local_auth_darwin/local_auth_darwin.dart' as _i14;
import 'package:local_auth_windows/local_auth_windows.dart' as _i15;
import 'package:mockito/mockito.dart' as _i1;
import 'package:playforge/core/failure/failure.dart' as _i5;
import 'package:playforge/core/shared_prefs/user_shared_prefs.dart' as _i11;
import 'package:playforge/features/auth/domain/entity/auth_entity.dart' as _i7;
import 'package:playforge/features/auth/domain/usecases/auth_usecase.dart'
    as _i3;
import 'package:playforge/features/auth/presentation/navigator/login_navigator.dart'
    as _i8;
import 'package:playforge/features/auth/presentation/navigator/register_navigator.dart'
    as _i10;
import 'package:playforge/features/dashboard/presentation/navigator/dashboard_navigator.dart'
    as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthUseCase extends _i1.Mock implements _i3.AuthUseCase {
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> uploadProfilePicture(
          _i6.File? file) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadProfilePicture,
          [file],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #uploadProfilePicture,
            [file],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, String>>.value(
                _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #uploadProfilePicture,
            [file],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> registerUser(
          _i7.AuthEntity? user) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerUser,
          [user],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #registerUser,
            [user],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #registerUser,
            [user],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> loginUser(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #loginUser,
          [
            email,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #loginUser,
            [
              email,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #loginUser,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.AuthEntity>> getCurrentUser() =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentUser,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i7.AuthEntity>>.value(
            _FakeEither_0<_i5.Failure, _i7.AuthEntity>(
          this,
          Invocation.method(
            #getCurrentUser,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i7.AuthEntity>>.value(
                _FakeEither_0<_i5.Failure, _i7.AuthEntity>(
          this,
          Invocation.method(
            #getCurrentUser,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.AuthEntity>>);
}

/// A class which mocks [LoginViewNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginViewNavigator extends _i1.Mock
    implements _i8.LoginViewNavigator {}

/// A class which mocks [DashboardViewNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockDashboardViewNavigator extends _i1.Mock
    implements _i9.DashboardViewNavigator {}

/// A class which mocks [RegisterViewNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockRegisterViewNavigator extends _i1.Mock
    implements _i10.RegisterViewNavigator {}

/// A class which mocks [UserSharedPrefs].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserSharedPrefs extends _i1.Mock implements _i11.UserSharedPrefs {
  @override
  _i4.Future<bool> isDeviceSupported() => (super.noSuchMethod(
        Invocation.method(
          #isDeviceSupported,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> setUserToken(String? token) =>
      (super.noSuchMethod(
        Invocation.method(
          #setUserToken,
          [token],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #setUserToken,
            [token],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #setUserToken,
            [token],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String?>> getUserToken() =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserToken,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String?>>.value(
            _FakeEither_0<_i5.Failure, String?>(
          this,
          Invocation.method(
            #getUserToken,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, String?>>.value(
                _FakeEither_0<_i5.Failure, String?>(
          this,
          Invocation.method(
            #getUserToken,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String?>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> deleteUserToken() =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteUserToken,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteUserToken,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteUserToken,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> setUserId(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #setUserId,
          [userId],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #setUserId,
            [userId],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #setUserId,
            [userId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String?>> getUserId() =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserId,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String?>>.value(
            _FakeEither_0<_i5.Failure, String?>(
          this,
          Invocation.method(
            #getUserId,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, String?>>.value(
                _FakeEither_0<_i5.Failure, String?>(
          this,
          Invocation.method(
            #getUserId,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String?>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> deleteUserId() =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteUserId,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteUserId,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteUserId,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> setUserName(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #setUserName,
          [name],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #setUserName,
            [name],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #setUserName,
            [name],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String?>> getFullName() =>
      (super.noSuchMethod(
        Invocation.method(
          #getFullName,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String?>>.value(
            _FakeEither_0<_i5.Failure, String?>(
          this,
          Invocation.method(
            #getFullName,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, String?>>.value(
                _FakeEither_0<_i5.Failure, String?>(
          this,
          Invocation.method(
            #getFullName,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String?>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> setFingerprintEnabled(
          bool? isEnabled) =>
      (super.noSuchMethod(
        Invocation.method(
          #setFingerprintEnabled,
          [isEnabled],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #setFingerprintEnabled,
            [isEnabled],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #setFingerprintEnabled,
            [isEnabled],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> getFingerprintEnabled() =>
      (super.noSuchMethod(
        Invocation.method(
          #getFingerprintEnabled,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #getFingerprintEnabled,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #getFingerprintEnabled,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> authenticateWithFingerprint() =>
      (super.noSuchMethod(
        Invocation.method(
          #authenticateWithFingerprint,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #authenticateWithFingerprint,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #authenticateWithFingerprint,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> loginWithFingerprint() =>
      (super.noSuchMethod(
        Invocation.method(
          #loginWithFingerprint,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #loginWithFingerprint,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #loginWithFingerprint,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
}

/// A class which mocks [LocalAuthentication].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalAuthentication extends _i1.Mock
    implements _i12.LocalAuthentication {
  @override
  _i4.Future<bool> get canCheckBiometrics => (super.noSuchMethod(
        Invocation.getter(#canCheckBiometrics),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<bool> authenticate({
    required String? localizedReason,
    Iterable<_i13.AuthMessages>? authMessages = const [
      _i14.IOSAuthMessages(),
      _i13.AndroidAuthMessages(),
      _i15.WindowsAuthMessages(),
    ],
    _i12.AuthenticationOptions? options = const _i12.AuthenticationOptions(),
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #authenticate,
          [],
          {
            #localizedReason: localizedReason,
            #authMessages: authMessages,
            #options: options,
          },
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<bool> stopAuthentication() => (super.noSuchMethod(
        Invocation.method(
          #stopAuthentication,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<bool> isDeviceSupported() => (super.noSuchMethod(
        Invocation.method(
          #isDeviceSupported,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<List<_i12.BiometricType>> getAvailableBiometrics() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAvailableBiometrics,
          [],
        ),
        returnValue:
            _i4.Future<List<_i12.BiometricType>>.value(<_i12.BiometricType>[]),
        returnValueForMissingStub:
            _i4.Future<List<_i12.BiometricType>>.value(<_i12.BiometricType>[]),
      ) as _i4.Future<List<_i12.BiometricType>>);
}
