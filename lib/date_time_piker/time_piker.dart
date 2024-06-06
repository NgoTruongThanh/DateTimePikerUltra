// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TimeSelectorUltra extends StatefulWidget {
  int selectedHour;
  int selectedMinute;
  Color color;
  Color iconColor;
  Color colorText;
  Function(TimeOfDay) onChange;
  double borderRadius;
  double textBoxwidth;
  TimeSelectorUltra(
      {super.key,
      this.selectedHour = 1,
      this.selectedMinute = 1,
      required this.onChange,
      this.iconColor = Colors.grey,
      this.color = Colors.orangeAccent,
      this.borderRadius = 6,
      required this.colorText,
      this.textBoxwidth = 60});

  @override
  State<TimeSelectorUltra> createState() => _TimeSelectorUltraState();
}

class _TimeSelectorUltraState extends State<TimeSelectorUltra> {

  late TextEditingController _controllerStart;
  late TextEditingController _controllerEnd;


  @override
  void initState() {
    super.initState();
    _controllerStart = TextEditingController(text: widget.selectedHour.toString());
    _controllerEnd = TextEditingController(text: widget.selectedMinute.toString());

  }

  @override
  void dispose() {
    _controllerStart.dispose();
    _controllerEnd.dispose();
    super.dispose();
  }

  void _incrementHour() {
    setState(() {
      widget.selectedHour =widget.selectedHour == 24 ? 1 : (widget.selectedHour ) + 1;
    });
    _controllerStart.text = widget.selectedHour.toString();
    _controllerStart.selection = TextSelection.fromPosition(TextPosition(offset: _controllerStart.text.length));
  }

  void _decrementHour() {
    setState(() {
      widget.selectedHour =
          widget.selectedHour == 0 ? 24 : widget.selectedHour - 1;
    });
    _controllerStart.text = widget.selectedHour.toString();
    _controllerStart.selection = TextSelection.fromPosition(TextPosition(offset: _controllerStart.text.length));
  }

  void _incrementMinute() {
    setState(() {
      widget.selectedMinute = (widget.selectedMinute % 60) + 1;
    });
    _controllerEnd.text = widget.selectedMinute.toString();
    _controllerEnd.selection = TextSelection.fromPosition(TextPosition(offset: _controllerEnd.text.length));
  }

  void _decrementMinute() {
    setState(() {
      widget.selectedMinute =
          widget.selectedMinute == 0 ? 60 : widget.selectedMinute - 1;
    });
    _controllerEnd.text = widget.selectedMinute.toString();
    _controllerEnd.selection = TextSelection.fromPosition(TextPosition(offset: _controllerEnd.text.length));
  }


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: ColorScheme.light(primary: widget.color),
          iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                  iconColor: WidgetStatePropertyAll(widget.iconColor))),
          iconTheme: IconThemeData(color: widget.iconColor)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: widget.color, width: 1),
                  color: widget.color.withOpacity(0.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: widget.textBoxwidth,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style:  TextStyle(fontSize: 24,color: widget.colorText),
                        controller: _controllerStart,
                        textAlign: TextAlign.center,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                         onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              int newValue = int.parse(value);
                              if (newValue > 24) {
                                widget.selectedHour = 24;
                              } else if (newValue < 1) {
                                widget.selectedHour = 0;
                              } else {
                                widget.selectedHour = newValue;
                              }

                            });
                          }
                          else{
                            setState(() {
                              widget.selectedHour = 0;
                            });
                          }
                          _controllerStart.text = widget.selectedHour.toString();
                          _controllerStart.selection = TextSelection.fromPosition(TextPosition(offset: _controllerStart.text.length));
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            widget.borderRadius,
                          ),
                          bottomRight: Radius.circular(
                            widget.borderRadius,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: _incrementHour,
                            child: const Icon(Icons.keyboard_arrow_up_rounded),
                          ),
                          InkWell(
                            onTap: _decrementHour,
                            child:
                                const Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Text(':',style: TextStyle(fontSize: 25),),
              const SizedBox(width: 10),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: widget.color, width: 1),
                  color: widget.color.withOpacity(0.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius),
                  ),
                ),
                child: Row(
                  children: [

                    SizedBox(
                      width: widget.textBoxwidth,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: _controllerEnd,
                        textAlign: TextAlign.center,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        style:  TextStyle(fontSize: 24,color: widget.colorText),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              int newValue = int.parse(value);
                              if (newValue > 60) {
                                widget.selectedMinute = 60;
                              } else if (newValue < 1) {
                                widget.selectedMinute = 0;
                              } else {
                                widget.selectedMinute = newValue;
                              }

                            });
                          }
                          else{
                            setState(() {
                              widget.selectedMinute = 0;
                            });
                          }
                          _controllerEnd.text = widget.selectedMinute.toString();
                          _controllerEnd.selection = TextSelection.fromPosition(TextPosition(offset: _controllerEnd.text.length));
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            widget.borderRadius,
                          ),
                          bottomRight: Radius.circular(
                            widget.borderRadius,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: _incrementMinute,
                            child: const Icon(Icons.keyboard_arrow_up_rounded),
                          ),
                          InkWell(
                            onTap: _decrementMinute,
                            child:
                                const Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ],
                      ),
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
}
