import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:playforge/core/common/custom_elevated_button.dart';
import 'package:playforge/core/common/custom_snackbar.dart';
import 'package:playforge/features/auth/presentation/view/register_view.dart';
import 'package:playforge/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/common/cutom_textform_field.dart';
import '../../../../core/common/my_snackbar.dart';
import '../../../dashboard/presentation/view/dashboard_screen.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  bool _isFingerprintEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
    _loadFingerprintPreference();
    _authenticateWithFingerprintIfEnabled();
  }

  Future<void> _checkBiometrics() async {
    _canCheckBiometrics = await _localAuth.canCheckBiometrics;
  }

  Future<void> _loadFingerprintPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isFingerprintEnabled = prefs.getBool('fingerprintEnabled') ?? false;
    setState(() {});
  }

  Future<void> _authenticateWithFingerprintIfEnabled() async {
    if (_isFingerprintEnabled && _canCheckBiometrics) {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate with fingerprint to log in',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        // Log in the user after successful fingerprint authentication
        // Use stored email and password from SharedPreferences or handle accordingly
        final prefs = await SharedPreferences.getInstance();
        String? storedEmail = prefs.getString('storedEmail');
        String? storedPassword = prefs.getString('storedPassword');

        if (storedEmail != null && storedPassword != null) {
          await ref.read(authViewModelProvider.notifier).loginUser(
                storedEmail,
                storedPassword,
              );
        }
      }
    }
  }

  Future<void> _handleFingerprintLogin() async {
    if (_canCheckBiometrics) {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate with fingerprint to log in',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        // Log in the user after successful fingerprint authentication
        final prefs = await SharedPreferences.getInstance();
        String? storedEmail = prefs.getString('storedEmail');
        String? storedPassword = prefs.getString('storedPassword');

        if (storedEmail != null && storedPassword != null) {
          await ref.read(authViewModelProvider.notifier).loginUser(
                storedEmail,
                storedPassword,
              );
        }
      } else {
        showMySnackBar(
            message: 'Fingerprint authentication failed', color: Colors.red);
      }
    } else {
      showMySnackBar(
          message: 'Biometric authentication is not available in your device');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 600) {
              // Mobile layout
              return _buildMobileLayout();
            } else {
              // Tablet layout
              return _buildTabletLayout();
            }
          },
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/images/logowhite.png'
                  : 'assets/images/logoblack.png',
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: _buildForm(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: _buildForm(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/images/logowhite.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 30),
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: "Epilogue",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            CustomTextFormField(
              key: const ValueKey('email'),
              prefixIconData: Icons.person,
              textStyle: const TextStyle(color: Colors.black),
              controller: emailFieldController,
              hintText: 'Enter your email',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              key: const ValueKey('password'),
              prefixIconData: Icons.password,
              textStyle: const TextStyle(color: Colors.black),
              obscureText: true,
              enableToggle: true,
              controller: passwordFieldController,
              hintText: 'Enter your password',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("Forgot Password?")),
                TextButton(
                  onPressed: () {
                    ref
                        .read(authViewModelProvider.notifier)
                        .openForgotPasswordView();
                  },
                  child: const Text(
                    'Reset Here',
                  ),
                ),
              ],
            ),
            CustomElevatedButton(
              color: const Color.fromRGBO(8, 113, 237, 1),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await ref.read(authViewModelProvider.notifier).loginUser(
                        emailFieldController.text,
                        passwordFieldController.text,
                      );

                  // Save email and password in SharedPreferences for fingerprint login
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      'storedEmail', emailFieldController.text);
                  await prefs.setString(
                      'storedPassword', passwordFieldController.text);
                }
              },
              text: 'Log In',
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: 'Genera',
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _handleFingerprintLogin,
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.fingerprint_rounded)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(authViewModelProvider.notifier).openRegisterView();
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
