import 'package:flutter/material.dart';

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
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/logowhite.png',
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: "Epilogue",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {},
                          ),
                          TextFormField(
                            validator: (value) {},
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Log In"),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text("Forgot Password?")),
                          Row(
                            children: [
                              Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {},
                                child: Text("Sign Up"),
                              )
                            ],
                          ),
                          ElevatedButton.icon(
                            style: ButtonStyle(),
                            onPressed: () {},
                            icon: Icon(Icons.gpp_good_rounded),
                            label: Text("Sign In with Google"),
                          )
                          // Add other login elements here
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
