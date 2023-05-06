import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/appointment_page.dart';

class DoctorCard extends StatelessWidget {
  bool? doctorByCategory;
  String? specialization;
  DoctorCard({Key? key, this.doctorByCategory = false, this.specialization})
      : super(key: key);

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: doctorByCategory!
          ? AppBar(
              title: Text("$specialization"),
            )
          : null,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: doctorByCategory!
                ? db
                    .collection('doctor')
                    .where('specialization', isEqualTo: specialization)
                    .snapshots()
                : db.collection('doctor').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.docs.map(
                    (doc) {
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentPage(
                                doctorId: doc.id,
                                doctorName: "Dr." + doc['name'],
                                specialization:
                                    "${doc['specialization']} ${doc['qualification']}",
                                nmcNo: doc['nmcNo']),
                          ),
                        ),
                        child: Card(
                          child: ListTile(
                            leading: Image.network(
                              "https://royalphnompenhhospital.com/royalpp/storage/app/uploads/2/2022-06-30/dr_sarisak_01.jpg",
                              fit: BoxFit.fitHeight,
                            ),
                            title: Text("Dr. ${doc['name']}"),
                            subtitle: Text("${doc['specialization']} " +
                                doc['qualification']),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
