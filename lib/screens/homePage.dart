import 'package:doctor/common/categories_card.dart';
import 'package:doctor/common/doctorCard.dart';
import 'package:doctor/constant/colors.dart';
import 'package:doctor/mock/doctorList.dart';
import 'package:doctor/screens/appointment_page.dart';
import 'package:flutter/material.dart';

import '../common/user_info_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          UserInfoCard(
            name: "Mamit",
            profileIcon: true,
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
          Container(height: 150, child: CategoriesCard()),
          const Text(
            "Available Doctors",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Flexible(child: DoctorCard()),
        ],
      )),
    );
  }
}
