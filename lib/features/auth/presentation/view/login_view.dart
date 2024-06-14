import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/core/common/custom_elevated_button.dart';
import 'package:playforge/core/common/custom_snackbar.dart';
import 'package:playforge/features/auth/presentation/view/register_view.dart';
import 'package:playforge/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../../../../core/common/cutom_textform_field.dart';
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
              width: MediaQuery.of(context).size.width *
                  0.4, // Adjust size as needed
              height: MediaQuery.of(context).size.width *
                  0.4, // Adjust size as needed
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
              width: MediaQuery.of(context).size.width, // Adjust size as needed
              height: MediaQuery.of(context).size.width *
                  0.3, // Adjust size as needed
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
            const Text(
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            CustomElevatedButton(
              color: Color.fromRGBO(8, 113, 237, 1),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await ref.read(authViewModelProvider.notifier).loginUser(
                        emailFieldController.text,
                        passwordFieldController.text,
                      );
                  // ref.read(authViewModelProvider.notifier).openDashboardView();
                  // showCustomSnackBar(
                  //   context,
                  //   'Loggged In',
                  //   textStyle: TextStyle(
                  //       color: Colors.green,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w900),
                  // );
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
            const SizedBox(height: 10),
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
                    style: TextStyle(color: Color.fromRGBO(48, 255, 81, 40)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              color: Colors.white,
              onPressed: () {},
              text: 'Sign In with Google',
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: 'Genera',
              ),
              image: Image.asset('assets/icons/google.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
              image: Image.asset('assets/icons/facebook.png'),
              color: Colors.white,
              onPressed: () {},
              text: 'Sign In with Facebook',
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: 'Genera',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
