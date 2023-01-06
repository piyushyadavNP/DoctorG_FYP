import 'package:doctor/mock/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categoriesList.length,
        itemBuilder: (context, index) => Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      height: 80,
                      width: 100,
                      child: ListTile(
                        leading:
                            Image.asset("${categoriesList[index]['image']}"),
                      ),
                    ),
                  ]),
                ),
                Text(categoriesList[index]['name']),
              ],
            ));
  }
}
