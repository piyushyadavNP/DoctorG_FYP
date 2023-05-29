import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/common/pdf_report.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InvestigationReport extends StatefulWidget {
  const InvestigationReport({super.key});

  @override
  State<InvestigationReport> createState() => _InvestigationReportState();
}

class _InvestigationReportState extends State<InvestigationReport> {
  final db = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!.uid;
  Text? subtitle = const Text("");
  bool enabledForReport = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: StreamBuilder<QuerySnapshot?>(
          stream: db
              .collection('appointmentDetails')
              .where('userId', isEqualTo: user)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox(
                child: Center(child: Text("No Reports Found")),
              );
            } else if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.docs.map(
                (doc) {
                  Future.delayed(Duration.zero, () async {
                    getReportDetails(doc['date']);
                  });

                  return Card(
                    child: ListTile(
                      enabled: enabledForReport,
                      onTap: () => Navigator.pushNamed(context, '/pdfReport'),
                      trailing: subtitle,
                      title: Text("Dr. " + doc['doctor']),
                      subtitle: Text(doc['date'] + " " + doc['time']),
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

  getReportDetails(String date) {
    DateTime appointmentDate = DateTime.parse(date);
    if (appointmentDate.compareTo(DateTime.now()) > 0) {
      subtitle = const Text(
        "Upcoming",
        style: TextStyle(color: Colors.green),
      );
      setState(() {
        enabledForReport = false;
      });
    }
  }
}
