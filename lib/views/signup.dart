import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/constants.dart';
import '../services/auth.dart';
import '../services/database.dart';
import '../widget/widget.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  final Function toogleView;

  const SignUp({super.key, required this.toogleView});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService authService = AuthService();
  DatabaseService databaseService = DatabaseService(uid: '');
  final _formKey = GlobalKey<FormState>();

  // text feild
  bool _loading = false;
  String email = '', password = '', name = "";

  getInfoAndSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      await authService
          .signUpWithEmailAndPassword(email, password)
          .then((value) {
        Map<String, String> userInfo = {
          "userName": name,
          "email": email,
        };

        databaseService.addData(userInfo);

        Constants.saveUserLoggedInSharedPreference(true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const AppLogo(),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        //brightness: Brightness.li,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const Spacer(),
                  Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? "Enter an Name" : null,
                            decoration: const InputDecoration(hintText: "Name"),
                            onChanged: (val) {
                              name = val;
                            },
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            validator: (val) => validateEmail(email)
                                ? null
                                : "Enter correct email",
                            decoration: const InputDecoration(hintText: "Email"),
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) => val!.length < 6
                                ? "Password must be 6+ characters"
                                : null,
                            decoration: const InputDecoration(hintText: "Password"),
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              getInfoAndSignUp();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have and account? ',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 17)),
                              GestureDetector(
                                onTap: () {
                                  widget.toogleView();
                                },
                                child: Container(
                                  child: const Text('Sign In',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          decoration: TextDecoration.underline,
                                          fontSize: 17)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  return (!regex.hasMatch(value)) ? false : true;
}
