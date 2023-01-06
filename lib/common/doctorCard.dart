import 'package:doctor/mock/doctorList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: doctorList.length,
        itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: 200,
                height: 80,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    child: ListTile(
                      leading: Image.network(
                        "https://royalphnompenhhospital.com/royalpp/storage/app/uploads/2/2022-06-30/dr_sarisak_01.jpg",
                        fit: BoxFit.fitHeight,
                      ),
                      title: Text(doctorList[index]['name']),
                      subtitle: Text(doctorList[index]['specialities']),
                    ),
                  ),
                ]),
              ),
            ));
  }
}
