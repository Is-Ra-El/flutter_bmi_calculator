
import 'package:flutter/material.dart';
import 'dart:math';
// import 'package:flutter/rendering.dart';
// import "package:charcode/charcode.dart";

void main() {
  runApp(const BMICalculatorScreen());
}

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

//variable to hold result

  String result = "";
  String bmicategory = "";
//method to calculate BMI
  void calculateBMI() {

    final String heightText = heightController.text;
    final String weightText = weightController.text;
    if (heightText.isEmpty || weightText.isEmpty) {
      setState(() {
        result = 'Please Enter height or weight';
      });
      return;
    }

    double height = double.tryParse(heightText) ?? 0;
    double weight = double.tryParse(weightText) ?? 0;
    if (height <= 0 || weight <= 0) {
      setState(() {
        result = "Invalid Input";
      });
      return;
    }
    //
    double heightInMeter = height / 100;
    double bmi = weight / (pow(heightInMeter, 2));
    bmi = double.parse(bmi.toStringAsFixed(2));

    setState(() {
      result = "Your Body Mass Index  is: $bmi kg/m2";

      if(bmi <18.5){
        bmicategory = 'Underweight';
      }else if(bmi < 25){
        bmicategory = "Normal Weight";
      }else if(bmi < 30){
        bmicategory = "OverWeight";
      }else{
        bmicategory = "Obese";
      }
    });

  }
  Widget buildInputField({
    required String label,
    required TextEditingController controller,
  }){
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0)
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BMI Calculator",
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(

          appBar: AppBar(
            title: const Text(
              "BMI Calculator",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
          ),
          backgroundColor: Colors.grey,

          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildInputField(label: "Height(cm)",
                    controller: heightController),
                const SizedBox(
                  height: 10.0,
                ),

                buildInputField(label: "Weight(kg)",
                    controller: weightController),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: calculateBMI,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                    )
                  ),
                  child: const Text("Calculate BMI",
                  style: TextStyle(fontSize: 18.0),),
                ),
                Text(result,
                textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(bmicategory,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                )
              ],
            ),
          )),
    );
  }
}
