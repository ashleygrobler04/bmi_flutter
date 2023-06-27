import 'package:flutter/material.dart';
import 'calc.dart';

const List<String> list = <String>['Metric', 'Imperial'];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Calculate c = Calculate();
  String weightInput = "";
  String heightInput = "";
  double bmi = 0.0;
  String status = "Waiting...";
  String dropdownValue = list.first;

  void handlePress() {
    setState(() {
      try {
        if (weightInput.isEmpty || heightInput.isEmpty) {
          throw "Input fields shouldn't be empty";
        }

        switch (dropdownValue) {
          case 'Metric':
            bmi = c.calculateBmi(
                double.parse(weightInput), double.parse(heightInput));
            break;
          case 'Imperial':
            bmi = c.calculateBMIImperial(
                double.parse(weightInput), double.parse(heightInput));
            break;
        }
        status = c.output(bmi);
      } catch (FormatException) {
        status =
            "Invalid format. Please ensure only numbers and a fullstop or a comma is entered.";
      } catch (e) {
        status = "There was an error while calculating your BMI: $e";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("BMI: $bmi"),
            Text("Status: $status"),
            DropdownButton(
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              value: dropdownValue,
            ),
            Semantics(
              textField: true,
              label:
                  "Enter weight in ${(dropdownValue == 'Metric') ? 'Killograms' : 'Pounds'}",
              child: TextField(
                decoration: InputDecoration(
                    labelText:
                        "Enter weight in ${(dropdownValue == 'Metric') ? 'Killograms' : 'Pounds'}"),
                onChanged: (value) => {
                  setState(() {
                    weightInput = value;
                  })
                },
              ),
            ),
            Semantics(
              textField: true,
              label:
                  "Enter height in ${(dropdownValue == 'Metric') ? 'Centimeters' : 'inch'}",
              child: TextField(
                decoration: InputDecoration(
                    labelText:
                        "Enter height in ${(dropdownValue == 'Metric') ? 'Centimeters' : 'inch'}"),
                onChanged: (value) => {
                  setState(() {
                    heightInput = value;
                  })
                },
              ),
            ),
            TextButton(onPressed: handlePress, child: Text("Calculate BMI"))
          ],
        ),
      ),
    );
  }
}
