import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _gap = SizedBox(
    height: 20,
  );
  TextEditingController emailFieldController = TextEditingController();

  TextEditingController passwordFieldController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(73, 78, 83, 100),
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                _gap,
                _gap,
                _gap,
                _gap,
                _gap,
                _gap,
                _gap,
                _gap,
                _gap,
                _gap,
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/images/logo.png'),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(0, 0, 0, 100),
                  ),
                  height: 445,
                  width: MediaQuery.of(context).size.width,
                  child: const Column(
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 32,
                            fontFamily: "Epilogue",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
