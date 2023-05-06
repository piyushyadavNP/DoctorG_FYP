import 'package:doctor/common/appointment_list.dart';
import 'package:doctor/common/user_info_card.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  bool? isDoctor;
  String? doctorName;
  String? specialization;
  String? nmcNo;

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    isDoctor = arguments['isDoctor'];
    specialization = arguments['specialization'];
    nmcNo = arguments['nmcNo'];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserInfoCard(
                profileIcon: false,
                specialization: specialization,
                nmcNo: nmcNo,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Your Appointment List",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Center(
                child: AppointmentInfoCard(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
