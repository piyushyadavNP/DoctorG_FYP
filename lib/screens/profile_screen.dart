import 'dart:math';

import 'package:doctor/constant/colors.dart';
import '../common/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../common/card_design.dart';
import '../common/custom_clipper.dart';
import '../common/tabbar_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController;
    TabController tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    scrollController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    ClipPath(
                      clipper: ProfileClipper(),
                      child: Container(
                        height: 150,
                        color: card,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
                Circleavatar(
                  top: 60,
                  left: 160,
                  radius: 40,
                  iconChild: IconButton(
                    icon: Icon(Icons.person_outlined),
                    onPressed: () {},
                  ),
                ),
                Circleavatar(
                  top: 50,
                  left: 40,
                  radius: 20,
                  iconChild: IconButton(
                    icon: Icon(Icons.cancel_outlined),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Circleavatar(
                  top: 50,
                  right: 40,
                  radius: 20,
                  iconChild: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Piyush Yadav",
              style: AppTextStyle.headline2,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Joined in 2022",
              style: AppTextStyle.subtitle1,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Welcome!",
                    style: AppTextStyle.headline3,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CommonSingleCard(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Activitiy history",
                        style: AppTextStyle.headline3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CommonTabbar(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "My Progress",
                        style: AppTextStyle.headline3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Activitiy history",
                        style: AppTextStyle.headline3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CommonTabbar(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "My Progress",
                        style: AppTextStyle.headline3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // TabBar(controller: tabController, tabs: [
            //   Tab(child: Text("Stress")),
            //   Tab(
            //     child: Text("Anxiety"),
            //   )
            // ]),
            // TabBarView(controller: tabController, children: [
            //   Expanded(child: CommonSingleCard()),
            //   Expanded(child: CommonSingleCard())
            // ])
          ],
        ),
      ),
    );
  }
}

class Circleavatar extends StatelessWidget {
  double? top;
  double? left;
  double? right;
  double? radius;
  Widget? iconChild;

  Circleavatar({
    Key? key,
    required this.iconChild,
    this.left,
    this.right,
    required this.radius,
    required this.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: white, width: 2),
          color: Colors.white,
        ),
        child: CircleAvatar(
          backgroundColor: primary,
          radius: radius,
          child: iconChild,
        ),
      ),
    );
  }
}
