import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/common/alert_info.dart';
import 'package:doctor/constant/colors.dart';
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

class DoctorSignup extends StatefulWidget {
  const DoctorSignup({Key? key}) : super(key: key);

  @override
  State<DoctorSignup> createState() => _DoctorSignupState();
}

class _DoctorSignupState extends State<DoctorSignup> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paswordController = TextEditingController();
  final TextEditingController _nmcNo = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _specialization = TextEditingController();
  final TextEditingController _vistingDays = TextEditingController();

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
                  ),
                  CommonTextField(
                    labelText: "Last Name",
                    controller: _lastnameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Last Name Can't Be Empty";
                      }
                      return null;
                    },
                  ),
                  CommonTextField(
                    labelText: "Email Address",
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email Address Can't Be Empty";
                      }
                      return null;
                    },
                  ),
                  CommonTextField(
                    labelText: "Password",
                    controller: _paswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password Can't Be Empty";
                      }
                      return null;
                    },
                  ),
                  CommonTextField(
                    labelText: "NMC No",
                    controller: _nmcNo,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "MNC No Can't Be Empty";
                      }
                      return null;
                    },
                  ),
                  CommonTextField(
                    labelText: "Mobile Number",
                    controller: _mobile,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mobile Number Can't Be Empty";
                      }
                      return null;
                    },
                  ),
                  CommonTextField(
                    labelText: "Specilization",
                    controller: _specialization,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Specialization Can't Be Empty";
                      }
                      return null;
                    },
                  ),
                  CommonTextField(
                    labelText: "Visting Hospital/Clinic",
                    controller: _vistingDays,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field Can't Be Empty";
                      }
                      return null;
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
                  DoctorSignup();
                },
                size: MediaQuery.of(context).size.width * 0.9),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                "Customize your visting date and time after signup.",
                style: AppTextStyle.subtitle2,
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

  Future<void> DoctorSignup() async {
    if (!_formKey.currentState!.validate()) {
      log("Form Validation Error");
      return;
    }
    try {
      final UserCredential userCredential;
      final db = FirebaseFirestore.instance;
      // Doctor Registration
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _paswordController.text);

      // Set Doctor Display Name
      userCredential.user!.updateDisplayName(
          "${_firstnameController.text.trim()} ${_lastnameController.text.trim()}");

      // Store Doctor Additional Info to doctor
      db.collection('doctor').doc(userCredential.user!.uid).set({
        "name":
            "${_firstnameController.text.trim()} ${_lastnameController.text.trim()}",
        "email": _emailController.text.trim(),
        "nmcNo": _nmcNo.text.trim(),
        "mobile": _mobile.text.trim(),
        "specialization": _specialization.text.trim(),
        "visitingDays": _vistingDays.text.trim(),
        "isAdmin": true,
      }).then((value) =>
          AlertInfo(message: "Registration Success.").showInfo(context));
    } catch (ex) {
      log(ex.toString());
      AlertInfo(message: "Registration Failed.").showInfo(context);
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
