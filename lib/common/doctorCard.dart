import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/appointment_page.dart';

class DoctorCard extends StatelessWidget {
  DoctorCard({Key? key}) : super(key: key);

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: db.collection('doctor').snapshots(),
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
                          doctorName:"Dr." + doc['name'],
                          specialization: doc['specialization'],
                        ),
                      ),
                    ),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(
                          "https://royalphnompenhhospital.com/royalpp/storage/app/uploads/2/2022-06-30/dr_sarisak_01.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                        title: Text(doc['name']),
                        subtitle: Text(doc['specialization']),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
