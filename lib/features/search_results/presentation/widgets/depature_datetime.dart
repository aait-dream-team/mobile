// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bus_navigation/core/utils/utils.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    this.onSave,
  }) : super(key: key);
  final Function(int depature, DateTime date)? onSave;

  @override
  State<DatePicker> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime dateTime = DateTime.now();
  DateTime mindateTime = DateTime.now();
  int selected = 0;

  Widget customRadio(String text, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => {setState(() => selected = index)},
        child: Text(
          text,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: (selected == index)
                  ? AppColors.blackAccent
                  : AppColors.greyAccent),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      height: 350,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customRadio("Departure", 0),
              const Icon(Icons.arrow_right_sharp),
              customRadio("Arrival", 1),
            ],
          ),
          SizedBox(
            height: 250,
            child: CupertinoDatePicker(
              minimumDate: mindateTime,
              backgroundColor: AppColors.white,
              initialDateTime: mindateTime,
              onDateTimeChanged: (DateTime newTime) {
                setState(() {
                  dateTime = newTime;
                });
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonColor,
              elevation: 0,
            ),
            onPressed: () {
              widget.onSave!(selected, dateTime);
            },
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.blackAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
