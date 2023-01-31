import 'package:doctor/common/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constant/colors.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  TextEditingController dateTimeController = TextEditingController();

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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            UserInfo(name: "Dr. Manohar Ray", profileIcon: false),
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
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Book Appointment")),
            )
          ],
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
}
