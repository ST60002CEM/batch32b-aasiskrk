import 'package:flutter/material.dart';
import 'package:playforge/common/custom_elevated_button.dart';
import 'package:playforge/common/cutom_textform_field.dart';
import 'package:playforge/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController confirmPasswordFieldController =
      TextEditingController();
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
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
              child: _buildForm(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Row(
      children: [
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
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            height: MediaQuery.of(context)
                .size
                .height, // Make container span full height
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
              "Create an account",
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
              textStyle: const TextStyle(color: Colors.black),
              prefixIconData: Icons.person,
              controller: nameFieldController,
              hintText: 'Enter your name',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              textStyle: const TextStyle(color: Colors.black),
              prefixIconData: Icons.email,
              controller: emailFieldController,
              hintText: 'Enter your email',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an email address';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              enableToggle: true,
              textStyle: const TextStyle(color: Colors.black),
              obscureText: true,
              prefixIconData: Icons.password,
              controller: passwordFieldController,
              hintText: 'Enter your password',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              enableToggle: true,
              textStyle: const TextStyle(color: Colors.black),
              obscureText: true,
              prefixIconData: Icons.password,
              controller: confirmPasswordFieldController,
              hintText: 'Confirm password',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please confirm your password';
                } else if (value != passwordFieldController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print("Signed in");
                } else {
                  print("Put all fields");
                }
              },
              text: 'Sign Up',
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Genera'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     if (_formKey.currentState!.validate()) {
            //       print("Signed in");
            //     } else {
            //       print("Put all fields");
            //     }
            //   },
            //   child: Text("Sign Up"),
            // ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  child: const Text("Log In",
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
