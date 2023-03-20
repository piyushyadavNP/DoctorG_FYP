import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/constant/colors.dart';
import 'package:doctor/screens/doctor_signup.dart';
import 'package:doctor/common/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
      backgroundColor: primary,
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
                "Create an account to access healthcare, and more.",
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
              child: Column(
                children: [
                  CommonTextField(
                    validator: (value) {
                      if (value!.isEmpty || value == null) {
                        return "First Name Can't Be Empty";
                      }
                      return null;
                    },
                    labelText: "First Name",
                    controller: _firstnameController,
                    errorText: validateButton(_firstnameController.text),
                  ),
                  CommonTextField(
                    labelText: "Last Name",
                    controller: _lastnameController,
                    validator: (value) {
                      return validateButton(value);
                    },
                  ),
                  CommonTextField(
                    labelText: "Email Address",
                    controller: _emailController,
                    validator: (value) {
                      return validateButton(value);
                    },
                  ),
                  CommonTextField(
                    labelText: "Password",
                    controller: _paswordController,
                    validator: (value) {
                      return validateButton(value);
                    },
                  ),
                ],
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                "For Health Professional",
                style: AppTextStyle.subtitle1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SignUp Here ! ",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: GestureDetector(
                      child: Text(
                        "SignUp",
                        style: AppTextStyle.inkWellLink,
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DoctorSignup()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    try {
      final UserCredential userCredential;
      final db = FirebaseFirestore.instance.collection("users");

      // User Registration
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _paswordController.text);

      // Set User Display Name
      userCredential.user!.updateDisplayName(
          "${_firstnameController.text.trim()} ${_lastnameController.text.trim()}");

      // Save Additional User Info to users collection
      db.doc(userCredential.user!.uid).set({
        "name":
            "${_firstnameController.text.trim()} ${_lastnameController.text.trim()}",
        "email": _emailController.text.trim(),
        "isAdmin": false,
      });
    } catch (ex) {
      log(ex.toString());
    }
  }

  String? validateButton(String? value) {
    log(value.toString());
    if (value!.isEmpty || value == null) {
      return 'Please Enter Some Text';
    }
    return null;
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _paswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
