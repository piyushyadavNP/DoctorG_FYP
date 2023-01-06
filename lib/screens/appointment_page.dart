import 'package:doctor/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            TabBarView(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top:
                          132.0), //note that without this padding the content of the page will apear behind the TabBar
                  color: Colors.teal[400],
                ),
                Container(
                  color: Colors.orange[500],
                ),
                Container(
                  color: Colors.pink[500],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 50.0),
                Text(
                  'Title', //A text to represent the title of the image
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                TabBar(
                  isScrollable: false,
                  indicatorColor: Colors.white,
                  indicatorWeight: 5,
                  onTap: (index) {},
                  tabs: [
                    Tab(text: 'Home'),
                    Tab(text: 'Groups'),
                    Tab(text: 'Profile'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
