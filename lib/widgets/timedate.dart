import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todolist/widgets/inputtext.dart';
// import 'package:meddyme/widgets/input_box.dart';

class AddDialog extends StatefulWidget {
  AddDialog({
    Key? key,
    required this.symptoms,
    required this.clinic,
    required this.patientName,
    required this.height,
    required this.weight,
    required this.clinicId,
  }) : super(key: key);
  //
  final TextEditingController symptoms;
  final String clinic;
  final String patientName;
  final String clinicId;
  final double height;
  final double weight;

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  late Time _time = Time.fromTimeOfDay(
    Time(hour: DateTime.now().hour, minute: DateTime.now().minute),
    12,
  );
  late DateTime date;
  late String userDate;
  bool isCar = false;
  final _todoController = TextEditingController();

  @override
  void initState() {
    date = DateTime.now();
    String today = DateFormat("dd/MM/yyyy").format(date);
    userDate = today;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int changedHour = _time.hour % 12;
    String changedMin = _time.minute.toString().padLeft(2, '0');
    String changedDay = _time.hour < 13 ? "AM" : "PM";
    String userTime = "$changedHour : $changedMin $changedDay";
    // final edittingController = TextEditingController();
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text("Add Task",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Clinic : ${widget.clinic}"),
            //     Icon(Icons.holiday_village),
            //   ],
            // ),
            // SizedBox(height: 10,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Patient : ${widget.patientName}"),
            //     Icon(Icons.holiday_village)
            //   ],
            // ),
            // SizedBox(height: 10,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text("Height : ${widget.height}"),
            //     Text("Weight : ${widget.weight}"),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InputText(
                  titleOff: true,
                  icon: Icons.calendar_month,
                  title: "Date",
                  onPressed: () async {
                    DateTime? pickDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2030));
                    if (pickDate != null) {
                      setState(() {
                        userDate = DateFormat("dd/MM/yyyy").format(pickDate);
                      });
                    }
                  },
                  readOnly: true,
                  hintText: userDate,
                ),
                InputText(
                  titleOff: true,
                  readOnly: true,
                  // textEditingController: _timeEditingController,
                  icon: Icons.schedule,
                  title: "Time",
                  onPressed: () {
                    return Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: _time,
                        onChange: (timeChanged) {
                          setState(() {
                            _time = timeChanged;
                          });
                        },
                        displayHeader: true,
                        blurredBackground: true,
                      ),
                    );
                  },
                  hintText: userTime,
                ),
              ],
            ),
            InputText(
              width: 300,
              widthMain: 280,
              title: "Add Task",
              onPressed: () {},
              icon: Icons.abc,
              hintText: "Type Here..!",
              showIcon: false,
              titleOff: true,
              textWidth: 260,
            ),
            const SizedBox(
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(
                  text: "Cancel",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  invertedColors: true,
                ),
                SimpleBtn1(text: "ADD", onPressed: () {
                  Navigator.of(context).pop(
              //       TextField(
              // controller: _todoController,)
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  SimpleBtn1(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      Key? key})
      : super(key: key);
  final primaryColor = Colors.black;
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            alignment: Alignment.center,
            side: MaterialStateProperty.all(
                BorderSide(width: 1, color: primaryColor)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.only(right: 25, left: 25, top: 0, bottom: 0)),
            backgroundColor: MaterialStateProperty.all(
                invertedColors ? accentColor : primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: invertedColors ? primaryColor : accentColor, fontSize: 16),
   ));
}
}