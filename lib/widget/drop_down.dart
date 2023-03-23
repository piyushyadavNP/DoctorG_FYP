import 'package:doctor/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DropDownField extends StatefulWidget {
  const DropDownField({super.key});

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  String? _chosenValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.white),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.060,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFFFFFFF).withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButton<String>(
              value: _chosenValue,
              dropdownColor: Colors.blue,
              isExpanded: true,
              iconEnabledColor: white,
              style: const TextStyle(fontSize: 12, color: Colors.white),
              items: <String>['Male', 'Female', 'Other']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value,
                    ),
                  ),
                );
              }).toList(),
              hint: const Text(
                "Gender",
                style: TextStyle(color: white, fontSize: 12),
              ),
              onChanged: (String? value) {
                setState(() {
                  _chosenValue = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
