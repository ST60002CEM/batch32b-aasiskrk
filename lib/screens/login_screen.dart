import 'package:flutter/material.dart';
import 'package:playforge/common/custom_elevated_button.dart';
import 'package:playforge/screens/register_screen.dart';

import '../common/cutom_textform_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(27, 27, 27, 1),
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
              'assets/images/logowhite.png',
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
            const SizedBox(height: 30),
            CustomTextFormField(
              prefixIconData: Icons.email_outlined,
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print("Logged in");
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const RegisterScreen()));
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
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
