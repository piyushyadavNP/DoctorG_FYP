import 'package:doctor/screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../common/text_style.dart';
import '../widget/button.dart';
import '../widget/logo_container.dart';
import '../widget/textField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
  @override
  void initState() {
    _emailController.text = "";
    _passwordController.text = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff101340),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: LogoName(
                height: 20,
                width: 20,
                textSize: 18,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text("Login", style: AppTextStyle.headline3),
            SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: 'New to Headspace? ',
                      style: AppTextStyle.subtitle2),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup()));
                        },
                      text: 'Sign up for free ',
                      style: AppTextStyle.inkWellLink),
                ]),
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CommonTextField(
                    // validator: validateButton(_firstnameController.text),
                    labelText: "Email Address",
                    controller: _emailController,
                    textInputType: TextInputType.name,
                  ),
                  CommonTextField(
                    // validator: validateButton(_lastnameController.text),
                    labelText: "Password",
                    controller: _passwordController,
                    textInputType: TextInputType.name,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Text(
                    "Forgot your password?",
                    style: AppTextStyle.inkWell,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MaterialCommonButton(
              isImage: false,
              onPressed: () => login(),
              size: MediaQuery.of(context).size.width * 0.9,
              color: Color.fromARGB(255, 60, 63, 104),
              text: "Login",
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      if (userCredential.user == null) {}
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (ex.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
