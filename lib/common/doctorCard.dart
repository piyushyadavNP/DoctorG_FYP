import 'dart:convert';
import 'dart:developer';

import 'package:doctor/mock/doctorList.dart';
import 'package:doctor/model/Doctors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  DoctorCard({Key? key}) : super(key: key);

  DatabaseReference dataBaseRefrence = FirebaseDatabase.instance.ref('doctor');
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: doctorList.length,
        itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: 200,
                height: 80,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    child: ListTile(
                      leading: Image.network(
                        "https://royalphnompenhhospital.com/royalpp/storage/app/uploads/2/2022-06-30/dr_sarisak_01.jpg",
                        fit: BoxFit.fitHeight,
                      ),
                      title: Text(doctorList[index]['name']),
                      subtitle: Text(doctorList[index]['specialities']),
                    ),
                  ),
                ]),
              ),
            ));
  }
}
