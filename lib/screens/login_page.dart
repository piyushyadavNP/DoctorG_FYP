import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/constant/colors.dart';
import 'package:doctor/screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widget/button.dart';
import '../widget/logo_container.dart';
import '../widget/textField.dart';
import '../common/text_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String message;
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
    message = "Login";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary,
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
                      text: 'New to doctorG? ', style: AppTextStyle.subtitle2),
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
                    labelText: "Email Address",
                    controller: _emailController,
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Email Address";
                      }
                      return null;
                    },
                  ),
                  CommonTextField(
                    labelText: "Password",
                    controller: _passwordController,
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Password";
                      }
                      return null;
                    },
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
            const SizedBox(
              height: 30,
            ),
            MaterialCommonButton(
              isImage: false,
              onPressed: () => login(),
              size: MediaQuery.of(context).size.width * 0.9,
              color: Colors.blue,
              text: message,
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        bool? isDoctor = await checkUserType(userCredential);

        if (userCredential.user == null) {}
        if (isDoctor!) {
          Navigator.pushNamed(context, '/doctorPage',
              arguments: {"isDoctor": isDoctor});
          return;
        }
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'user-not-found' || ex.code == 'wrong-password') {
          setState(() {
            message = "Invalid Credentials";
          });
          log('No user found for that email.');
        } else if (ex.code == 'wrong-password') {
          setState(() {
            message = "Login Failed";
          });
          log('Wrong password provided for that user.');
        }
      }
    }
  }

  String? validateButton(String? value) {
    if (value!.isEmpty) {
      return 'Please Enter Some Text';
    } else {}
    return null;
  }

  Future<bool?> checkUserType(UserCredential userCredential) async {
    bool? result;
    log("user ${userCredential.user!.uid}");
    try {
      await FirebaseFirestore.instance
          .collection("doctor")
          .doc(userCredential.user!.uid.toString())
          .get()
          .then((value) {
        log("Value ${value.data()!['isDoctor']}");
        result = value.data()!['isDoctor'];
      });
      return result;
    } catch (ex) {
      log(ex.toString());
    }
    return false;
  }
}
