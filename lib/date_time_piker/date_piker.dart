// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class DatePickerUltra extends StatefulWidget {
  Color color;
  Color iconColor;
  Color textColor;
  DateTime selectedDate;
  Function(DateTime) onChange;
  DatePickerUltra({
    super.key,
    required this.onChange,
    this.iconColor = Colors.grey,
    this.color = Colors.white,
    DateTime? selectedDate,
    this.textColor = Colors.black
  }) : selectedDate = selectedDate ?? DateTime.now();
  @override
  State<DatePickerUltra> createState() => _DatePickerUltraState();
}

class _DatePickerUltraState extends State<DatePickerUltra> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Theme(
        data: Theme.of(context).copyWith(
      colorScheme: ColorScheme.dark(
        primary: widget.color, // header background color
        onPrimary: widget.textColor, // header text color
        onSurface: widget.color,
      )),
        child: CalendarDatePicker(
            initialDate: widget.selectedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            onDateChanged: (picked) {
              if (picked != widget.selectedDate) {
                setState(() {
                  widget.selectedDate = picked;
                });

                widget.onChange(picked);
              }
            }),
      ),
    );
  }


}
