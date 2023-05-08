import 'package:chat/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double firstNum = 0.0;
  double lastNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';

  onbuttonClick(value) {
    // if value is AC
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
      }
    } else {
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      input,
                      style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      output,
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                button(text: "AC", tcolor: orangeColor, bcolor: operatorColor),
                button(text: "<", tcolor: orangeColor, bcolor: operatorColor),
                button(text: "", bcolor: Colors.black),
                button(text: "/", bcolor: operatorColor)
              ],
            ),
            Row(
              children: [
                button(text: "7"),
                button(text: "8"),
                button(text: "9"),
                button(text: "x", bcolor: operatorColor)
              ],
            ),
            Row(
              children: [
                button(text: "4"),
                button(text: "5"),
                button(text: "6"),
                button(text: "-", bcolor: operatorColor)
              ],
            ),
            Row(
              children: [
                button(text: "1"),
                button(text: "2"),
                button(text: "3"),
                button(text: "+", bcolor: operatorColor)
              ],
            ),
            Row(
              children: [
                button(text: "%", bcolor: operatorColor),
                button(text: "0"),
                button(text: "."),
                button(text: "=", bcolor: orangeColor)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button({
    text,
    bcolor = buttonColor,
    tcolor = Colors.white,
  }) {
    return Expanded(
      child: Container(
        height: 65,
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(22),
            primary: bcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          onPressed: () => onbuttonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
