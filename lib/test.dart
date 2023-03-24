import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

void main(List<String> args) {
  final date = Timestamp.now();
  final dateCon = DateTime.parse(date.toDate().toString());

  print("Date is $dateCon");
}
