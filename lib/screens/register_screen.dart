import 'package:flutter/material.dart';
import 'package:playforge/common/cutom_textform_field.dart';

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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 27, 27, 1),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                    SizedBox(height: 20),
                    CustomTextFormField(
                      textStyle: TextStyle(color: Colors.black),
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
                    SizedBox(height: 10),
                    CustomTextFormField(
                      textStyle: TextStyle(color: Colors.black),
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
                    SizedBox(height: 10),
                    CustomTextFormField(
                      textStyle: TextStyle(color: Colors.black),
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
                    SizedBox(height: 10),
                    CustomTextFormField(
                      textStyle: TextStyle(color: Colors.black),
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
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Sign Up"),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print("Signed in");
                            } else {
                              print("Put all fields");
                            }
                          },
                          child: Text("Log In",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
