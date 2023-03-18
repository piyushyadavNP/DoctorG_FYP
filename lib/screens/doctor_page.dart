import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  bool? isDoctor;

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    isDoctor = arguments['isDoctor'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            isDoctor.toString(),
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
