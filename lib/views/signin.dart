import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import '../services/auth.dart';
import '../widget/widget.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;

  const SignIn({super.key, required this.toogleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // final AuthService _authService = AuthService();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
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
        child: Column(
          children: [
            const Spacer(),
            Column(
              children: [
                const TextField(
                  decoration: InputDecoration(hintText: "Email"),
                ),
                const SizedBox(
                  height: 6,
                ),
                const TextField(
                  decoration: InputDecoration(hintText: "Password"),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? ',
                        style: TextStyle(color: Colors.black87, fontSize: 17)),
                    GestureDetector(
                      onTap: () {
                        widget.toogleView();
                      },
                      child: const Text('Sign Up',
                          style: TextStyle(
                              color: Colors.black87,
                              decoration: TextDecoration.underline,
                              fontSize: 17)),
                    ),
                  ],
                ),
              ],
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
