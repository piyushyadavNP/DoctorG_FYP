import 'package:doctor/common/pdf_report.dart';
import 'package:doctor/provider/TimeProvider.dart';
import 'package:doctor/provider/counter.dart';
import 'package:doctor/screens/appointment_page.dart';
import 'package:doctor/screens/doctor_page.dart';
import 'package:doctor/screens/forgot_password.dart';
import 'package:doctor/screens/invstigation_report.dart';
import 'package:doctor/screens/login_page.dart';
import 'package:doctor/screens/profile_screen.dart';
import 'package:doctor/screens/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TimeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          // timePickerTheme: timePickerTheme,
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => const LoginPage(),
          '/signup': (context) => const Signup(),
          '/home': (context) => const MainPage(),
          '/report': (context) => const InvestigationReport(),
          '/book': (context) => AppointmentPage(),
          '/doctorPage': (context) => const DoctorPage(),
          '/profile': (context) => const ProfileScreen(),
          '/forgotPassword': (context) => const ForgotPassword(),
          '/pdfReport': (context) => PdfReport()
        },
      ),
    );
  }
}
