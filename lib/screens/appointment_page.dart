import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/common/alert_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../common/user_info_card.dart';
import '../constant/colors.dart';

class AppointmentPage extends StatefulWidget {
  final String? doctorName;
  final String? specialization;
  final String? doctorId;
  const AppointmentPage(
      {Key? key, this.doctorName, this.specialization, this.doctorId})
      : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController _symptomsController = TextEditingController();

  String? selectedTime;
  @override
  void initState() {
    _selectedDay = _focusedDay;
    dateTimeController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              UserInfoCard(name: widget.doctorName, profileIcon: false),
              const SizedBox(
                height: 40,
                child: Text("Select Your Date"),
              ),
              TableCalendar(
                rowHeight: 30,
                focusedDay: DateTime.now(),
                firstDay: DateTime(2010),
                lastDay: DateTime(2070),
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
                weekendDays: const [
                  DateTime.saturday
                ], // Disable According To Doctor's Availiability
              ),
              Text("${DateFormat("yyyy-MM-dd").format(_selectedDay!)}"),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  readOnly: true,
                  controller: dateTimeController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.timer), //icon of text field
                      labelText: "Enter Time" //label text of field
                      ),
                  onTap: () => _selectTime(),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _symptomsController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.info), //icon of text field
                      labelText: "Mention any symptoms" //label text of field
                      ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {
                      saveAppointmentDetails();
                    },
                    child: const Text("Book Appointment")),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        dateTimeController.text = newTime.format(context);
      });
    }
  }

  void saveAppointmentDetails() async {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    final date = DateFormat("yyyy-MM-dd").format(_selectedDay!);
    final todayDate = DateFormat("yyy-MM-dd").format(DateTime.now());
    if (dateTimeController.text.isEmpty) {
      AlertInfo(message: "Missed To Select Time.").showInfo(context);
      return;
    }
    if (!_selectedDay!.isBefore(DateTime.now())) {
      try {
        await db.collection('appointmentDetails').add({
          "userId": user!.uid,
          "date": date,
          "time": dateTimeController.text,
          "doctor": widget.doctorName,
          "doctorId": widget.doctorId,
          "symptoms": _symptomsController.text.trim(),
          "userName": user.displayName
        }).then((value) =>
            AlertInfo(message: "Appointment Booked").showInfo(context));
      } on FirebaseException catch (ex) {
        log(ex.toString());
        AlertInfo(message: "Some Error Occured").showInfo(context);
      } catch (ex) {
        AlertInfo(message: "Some Error Occured").showInfo(context);
      }
    } else {
      AlertInfo(message: "Date Can't Be In Past").showInfo(context);
    }
  }
}
