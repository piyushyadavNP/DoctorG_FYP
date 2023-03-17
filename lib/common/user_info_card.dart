import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';

class UserInfo extends StatelessWidget {
  bool? profileIcon;
  String? name;

  UserInfo({
    this.name,
    this.profileIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Stack(children: [
      Card(
        margin: const EdgeInsets.all(10),
        elevation: 10,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientCardColor)),
        ),
      ),
      Positioned(
        left: 10,
        top: 40,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi ${user != null ? user.displayName : ""}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              profileIcon == true
                  ? const Text(
                      "How are you feeling today ?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  : Column(
                      children: const [
                        Text(
                          "Neurologist",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "NMC:1485623",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
      profileIcon == true
          ? Positioned(
              right: 10,
              top: 10,
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: IconButton(
                    icon: Image.asset(
                      "assets/man.png",
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      if (FirebaseAuth.instance.currentUser == null) {
                        Navigator.pushNamed(context, '/');
                      }
                    },
                  ),
                ),
              ),
            )
          : const SizedBox(),
      profileIcon == true
          ? Positioned(
              right: 10,
              left: 10,
              bottom: 40,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                        hintStyle: TextStyle(fontSize: 17, color: Colors.white),
                        hintText: 'Search your doctor',
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
            )
          : const SizedBox()
    ]);
  }
}
