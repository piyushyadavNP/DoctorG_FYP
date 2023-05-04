import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../common/text_style.dart';
import '../widget/button.dart';
import '../widget/logo_container.dart';
import '../widget/textField.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController =
      TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
          const SizedBox(
            height: 40,
          ),
          Text("Forgot Password ?", style: AppTextStyle.headline3),
          const SizedBox(
            height: 15,
          ),
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
          MaterialCommonButton(
            isImage: false,
            onPressed: () {},
            size: MediaQuery.of(context).size.width * 0.9,
            color: Theme.of(context).primaryColor,
            text: "Reset Password",
          ),
        ],
      )),
    );
  }
}
