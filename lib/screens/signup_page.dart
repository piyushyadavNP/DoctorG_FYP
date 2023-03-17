import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../common/text_style.dart';
import '../widget/button.dart';
import '../widget/logo_container.dart';
import '../widget/textField.dart';
import 'login_page.dart';
import 'navbar.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isValidate = false;
  bool formIsValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff101340),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: LogoName(
                height: 20,
                width: 20,
                textSize: 18,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text("Sign Up", style: AppTextStyle.headline2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                "Create an account to access meditations, sleep,\n sounds, music to help you focus, and more.",
                style: AppTextStyle.subtitle1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have an account?",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 15),
                  ),   
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: GestureDetector(
                      child: Text(
                        "Login",
                        style: AppTextStyle.inkWellLink,
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              onChanged: () => setState(
                  () => formIsValid = _formKey.currentState!.validate()),
              child: Column(
                children: [
                  CommonTextField(
                    validator: validateButton,
                    labelText: "First Name",
                    controller: _firstnameController,
                  ),
                  CommonTextField(
                    validator: validateButton,
                    labelText: "Last Name",
                    controller: _lastnameController,
                  ),
                  CommonTextField(
                    validator: validateButton,
                    labelText: "Email Address",
                    controller: _emailController,
                  ),
                  CommonTextField(
                    validator: validateButton,
                    labelText: "Password",
                    controller: _paswordController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(9.5),
              child: GestureDetector(
                onTap: () {},
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'By continuing, you agree to Headspace\'s\ ',
                        style: AppTextStyle.subtitle2),
                    TextSpan(
                        text: 'Terms And Conditions ',
                        style: AppTextStyle.inkWellLink),
                    TextSpan(text: 'and ', style: AppTextStyle.subtitle2),
                    TextSpan(
                        text: 'Privacy Policy.',
                        style: AppTextStyle.inkWellLink)
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialCommonButton(
                isImage: false,
                color: Colors.blue,
                text: "Create an account",
                onPressed: () {
                  signUp();
                },
                size: MediaQuery.of(context).size.width * 0.9),
            SizedBox(
              height: 15,
            ),
            MaterialCommonButton(
                isImage: false,
                color: Color.fromARGB(255, 60, 63, 104),
                text: "Create with SSO",
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                },
                size: MediaQuery.of(context).size.width * 0.9),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                textAlign: TextAlign.center,
                "Link an account to log in faster in the future",
                style: AppTextStyle.subtitle2,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialCommonButton(
                      isImage: true,
                      image: Image.asset(
                        "assets/man.png",
                        height: 30,
                      ),
                      color: Colors.white,
                      onPressed: () {},
                      size: MediaQuery.of(context).size.width * 0.25),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialCommonButton(
                      isImage: true,
                      image: Image.asset(
                        "assets/man.png",
                        height: 30,
                      ),
                      color: Color(0xff1877F2),
                      onPressed: () {},
                      size: MediaQuery.of(context).size.width * 0.25),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialCommonButton(
                      isImage: true,
                      image: Image.asset(
                        "assets/man.png",
                        height: 30,
                        color: Colors.white,
                      ),
                      color: Color.fromARGB(255, 15, 15, 15),
                      onPressed: () {},
                      size: MediaQuery.of(context).size.width * 0.25),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    try {
      // final UserCredential userCredential;
      // final CollectionReference databaseReference =
      //     FirebaseFirestore.instance.collection("users");
      // userCredential = await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(
      //         email: _emailController.text, password: _paswordController.text);
      // userCredential.user!.updateDisplayName(
      //     _firstnameController.text.trim() + _lastnameController.text.trim());
      // databaseReference.child(userCredential.user!.uid).set({
      //   "name":
      //       _firstnameController.text.trim() + _lastnameController.text.trim(),
      //   "email": _emailController.text.trim(),
      //   "role": "User",
      // });
    } catch (ex) {
      log(ex.toString());
    }
  }

  String? validateButton(String? value) {
    if (value!.isNotEmpty) {
      _isValidate;
    } else {
      return 'Please Enter Some Text';
    }
    return null;
  }
}
