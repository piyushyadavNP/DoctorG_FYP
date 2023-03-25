import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timelines/timelines.dart';

class AppointmentInfoCard extends StatefulWidget {
  const AppointmentInfoCard({super.key});

  @override
  State<AppointmentInfoCard> createState() => _AppointmentInfoCardState();
}

class _AppointmentInfoCardState extends State<AppointmentInfoCard> {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection('appointmentDetails')
              .where('doctorId', isEqualTo: user)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.docs.map(
                (doc) {
                  return Card(
                    child: ListTile(
                      leading: Text(doc['userName']),
                      trailing: Text(doc['symptoms']),
                      title: Text(doc['date']),
                      subtitle: Text(doc['time']),
                    ),
                  );
                },
              ).toList());
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
