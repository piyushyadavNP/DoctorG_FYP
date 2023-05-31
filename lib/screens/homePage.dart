import 'dart:developer';

import 'package:doctor/common/categories_card.dart';
import 'package:doctor/common/doctorCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common/user_info_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName = FirebaseAuth.instance.currentUser!.displayName;
  }

  String? query = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        UserInfoCard(
          height: MediaQuery.of(context).size.height / 4,
          name: userName!.isNotEmpty ? userName : "",
          profileIcon: true,
          onChanged: (value) {
            setState(() {
              query = value;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Categories",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(height: 100, child: CategoriesCard()),
        const Text(
          "Available Doctors",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Flexible(
            child: DoctorCard(
          search: true,
          query: query!,
        )),
      ],
    ));
  }
}
