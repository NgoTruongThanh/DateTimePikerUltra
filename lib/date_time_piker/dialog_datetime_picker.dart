// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'time_piker.dart';
import 'date_piker.dart';

class DateTimePickerUltraDialog extends StatefulWidget {
  Color color;
  Color iconColor;
  Color dialogBoxColor;
  bool showDatePicker;
  Widget? titleWidget;
  bool showTimePicker;
  Function(DateTime)? onChangeDate;
  Function(DateTime)? onChangeTime;
  Function(DateTime)? onPress;
  double borderRadius;
  double textBoxwidth;
  DateTime selectedDate;
  TimeOfDay initialTime;
  Widget widget;
  String titleCancel;
  String titleConfirm;
  Color colorText;
  DateTimePickerUltraDialog({
    super.key,
    this.showDatePicker = true,
    this.showTimePicker = true,
    this.titleWidget,
    this.onChangeDate,
    this.onChangeTime,
    this.onPress,
    this.iconColor = Colors.grey,
    this.color = Colors.orangeAccent,
    this.dialogBoxColor = Colors.white,
    this.borderRadius = 6,
    this.textBoxwidth = 60,
    required this.widget,
    DateTime? selectedDate,
    TimeOfDay? initialTime,
    this.titleCancel = "Cancel",
    this.titleConfirm = "Confirm",
    this.colorText = Colors.black
  })  : selectedDate = selectedDate ?? DateTime.now(),
        initialTime = initialTime ?? TimeOfDay.now() {
    // Set the default value for initialTime if it's not provided
    // This code executes in the constructor body
    // This approach ensures the object is fully initialized
  }

  @override
  State<DateTimePickerUltraDialog> createState() =>
      _DateTimePickerUltraDialogState();
}

class _DateTimePickerUltraDialogState extends State<DateTimePickerUltraDialog> {
  OverlayEntry? _overlayEntry;

  DateTime mergeDateTimeAndTimeOfDay() {
    DateTime dateTime = widget.selectedDate;
    TimeOfDay timeOfDay = widget.initialTime;
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    return DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute);
  }

  _toggleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius))),
        backgroundColor: widget.dialogBoxColor,
        actionsPadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(6),
        content: SizedBox(
          width: 350,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.showTimePicker)
                    TimeSelectorUltra(
                      colorText: widget.colorText,
                      selectedHour: (widget.initialTime.hour),
                      selectedMinute: widget.initialTime.minute,
                      iconColor: widget.iconColor,
                      color: widget.color,
                      borderRadius: widget.borderRadius,
                      textBoxwidth: widget.textBoxwidth,
                      onChange: (TimeOfDay time) {
                        setState(() {
                          widget.initialTime = time;
                        });
                        if (widget.onChangeTime != null) {
                          DateTime dateTime = mergeDateTimeAndTimeOfDay();
                          widget.onChangeTime!(dateTime);
                        }
                      },
                    ),
                  if (widget.showDatePicker)
                    DatePickerUltra(
                      selectedDate: widget.selectedDate,
                      onChange: (DateTime date) {
                        setState(() {
                          widget.selectedDate = date;
                        });
                        if (widget.onChangeDate != null) {
                          DateTime dateTime = mergeDateTimeAndTimeOfDay();
                          widget.onChangeDate!(dateTime);
                        }
                      },
                    )
                ],
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(widget.titleCancel,style: const TextStyle(color: Colors.red),),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.onPress != null) {
                          DateTime dateTime = mergeDateTimeAndTimeOfDay();
                          widget.onPress!(dateTime);
                        }
                        Navigator.of(context).pop();
                      },
                      child:  Text(widget.titleConfirm,style: const TextStyle(color: Colors.blue),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleDialog(context),
      child: widget.widget,
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }
}
