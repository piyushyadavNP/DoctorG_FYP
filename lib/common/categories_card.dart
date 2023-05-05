import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  CategoriesCard({super.key});

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: db.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs
                  .map((doc) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          SizedBox(
                            height: 80,
                            width: 100,
                            child: ListTile(
                              title: Text(doc['label']),
                            ),
                          ),
                        ]),
                      ))
                  .toList(),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
