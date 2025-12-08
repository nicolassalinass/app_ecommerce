import 'package:flutter/material.dart';

class SelectionPeriod extends StatefulWidget {
  const SelectionPeriod({super.key});

  @override
  State<SelectionPeriod> createState() => _SelectionPeriodState();
}
//enum Period { sevenDays, thirtyDays }
class _SelectionPeriodState extends State<SelectionPeriod> {


  String selectedPeriod = "7D";


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = "7D";
                });
              },
              child: Container(
                alignment: AlignmentGeometry.center,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selectedPeriod == "7D" ? Theme.of(context).colorScheme.onPrimaryContainer : Colors.transparent,

                ),
                child: Text("7D"),

              ),
            ),
          ),

          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = "30D";
                });
              },
              child: Container(
                alignment: AlignmentGeometry.center,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selectedPeriod == "30D" ? Theme.of(context).colorScheme.onPrimaryContainer : Colors.transparent,
                ),
                child: Text("30D"),

              ),
            ),
          )
        ]
      ),

    );
  }
}
