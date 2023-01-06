import 'package:doctor/common/categories_card.dart';
import 'package:doctor/common/doctorCard.dart';
import 'package:doctor/constant/colors.dart';
import 'package:doctor/mock/doctorList.dart';
import 'package:doctor/screens/counter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [
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
                    children: const [
                      Text(
                        "Hi Mamit !",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "How are you feeling today ?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Container(
                    height: 40,
                    width: 40,
                    child: IconButton(
                      icon: Image.asset(
                        "assets/man.png",
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Positioned(
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
                          hintStyle:
                              TextStyle(fontSize: 17, color: Colors.white),
                          hintText: 'Search your doctor',
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(height: 150, child: const CategoriesCard()),
          const Text(
            "Available Doctors",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Flexible(
              child: InkWell(
                  onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CounterPage(),
                        ),
                      ),
                  child: DoctorCard())),
        ],
      )),
    );
  }
}
