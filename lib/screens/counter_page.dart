import 'dart:developer';

import 'package:doctor/provider/counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    log("object");
    int count = 0;
    setState(() {
      count = Provider.of<CountNumber>(context).getCount();
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Text("Counter Value $count"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Provider.of<CountNumber>(context, listen: false).updateCount(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
