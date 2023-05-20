import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/constant/colors.dart';
import 'package:doctor/provider/TimeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentTime extends StatefulWidget {
  final String? doctorId;
  final String? dateSelected;
  const AppointmentTime({super.key, this.doctorId, this.dateSelected});

  @override
  State<AppointmentTime> createState() => _AppointmentTimeState();
}

class _AppointmentTimeState extends State<AppointmentTime> {
  List<String> appointmentTime = [];
  List availableTime = [];

  final db = FirebaseFirestore.instance;

  Color? chipColor;
  String? timeSelected;
  int? _selectedIndex;
  bool? isDisabled;
  TimeProvider? onDateSelected;

  @override
  void initState() {
    super.initState();
    getAppointmentRange();
    isDisabled = false;
    chipColor = Colors.blue;
    timeSelected = "0.0";
  }

  @override
  Widget build(BuildContext context) {
    checkForBookedTime(context);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 80, childAspectRatio: 3 / 2),
      shrinkWrap: true,
      itemCount: appointmentTime.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return GestureDetector(
          onTap: () => setState(() {
            timeSelected = appointmentTime[index];
            _selectedIndex = index;
            Provider.of<TimeProvider?>(context, listen: false)!
                .selectTime(timeSelected);
          }),
          child: Chip(
            backgroundColor: index == _selectedIndex
                ? Colors.blue.withOpacity(0.6)
                : Colors.blue,
            label: Text(
              appointmentTime[index],
              style: const TextStyle(color: white),
            ),
          ),
        );
      },
    );
  }

  // Getting the Time Range For Doctors
  generateTimeRange(String timeRange) {
    List<String> timeSlot = timeRange.split("-");
    DateTime start = DateTime.parse('2000-01-01T${timeSlot.first}:00Z');
    DateTime end = DateTime.parse('2000-01-01T${timeSlot.last}:00Z');
    Duration interval = const Duration(minutes: 20);
    while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
      String formattedTime =
          '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
      start = start.add(interval);
      appointmentTime.add(formattedTime);
    }
  }

  getAppointmentRange() async {
    log("Getting Appointment Range");
    try {
      await db.collection("doctor").doc(widget.doctorId).get().then((value) {
        setState(() {
          if (value.data() != null) {
            generateTimeRange(value.data()!['vistingTime']);
          } else {
            generateTimeRange("10:00-16:00");
          }
        });
        log(value.data()!['vistingTime']);
      });
    } catch (ex) {
      log(ex.toString());
    }
  }

  checkForBookedTime(BuildContext context) async {
    log("Checking If Time Slot is Taken");
    onDateSelected = Provider.of<TimeProvider>(context, listen: false);
    try {
      List data = await db.collection("appointmentDetails").get().then(
          (value) => value.docs
              .where((item) => widget.doctorId == item['doctorId'])
              .toList());
      for (var item in data) {
        log(item['date']);
        if (onDateSelected!.dateSelected == item['date']) {
          appointmentTime.remove(item['time']);
        }
      }
    } on FirebaseFirestore catch (e) {
      log(e.toString());
    }
  }
}
