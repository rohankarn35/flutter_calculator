import 'package:flutter/material.dart';
import 'package:flutter_calculator/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcUI extends StatefulWidget {
  const CalcUI({Key? key}) : super(key: key);

  @override
  State<CalcUI> createState() => _CalcUIState();
}

class _CalcUIState extends State<CalcUI> {
  String userQuestion = '';
  String userAns = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '√',      // Square root
    '^',      // Exponentiation
    'sin',    // Sine
    'cos',    
    'tan',    
    'log',    
    'ln', 
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '00',
    '.',
    '(',
  ')',
    'ANS',
    '=',
     
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
          
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 30),
                  Container(
                    // color: Colors.amber,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      userQuestion,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      userAns,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return MyButtons(
                      onTap: () {
                        setState(() {
                          userQuestion = '';
                          userAns = '';
                        });
                      },
                      color: Colors.green,
                      textColor: Colors.black,
                      buttonText: buttons[index],
                    );
                  } else if (index == 1) {
                    return MyButtons(
                      onTap: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      },
                      color: Colors.redAccent,
                      textColor: Colors.black,
                      buttonText: buttons[index],
                    );
                  } 
                  else if (index == buttons.length - 2) {
                    return MyButtons(
                      onTap: () {
                        setState(() {
                          userQuestion = userAns;
                          userAns = '';
                        });
                      },
                      color: Colors.redAccent,
                      textColor: Colors.black,
                      buttonText: buttons[index],
                    );
                  } 
                  else if (index == buttons.length - 1) {
                    return MyButtons(
                      onTap: () {
                        setState(() {
                          evaluate();
                        });
                      },
                      color: Colors.redAccent,
                      textColor: Colors.black,
                      buttonText: buttons[index],
                    );
                  } else {
                    return MyButtons(
                      onTap: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      color: isOperator(buttons[index])
                          ? Colors.orange
                          : Colors.white,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                      buttonText: buttons[index],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String s) {
    if (s == '%' || s == '/' || s == 'x' || s == '-' || s == '+' || s == '=') {
      return true;
    } else {
      return false;
    }
  }

 void evaluate() {
  try {
    String finalQuestion = userQuestion;

    // Replace custom symbols with standard mathematical symbols
    finalQuestion = finalQuestion.replaceAll('x', '*');
    finalQuestion = finalQuestion.replaceAll('√', 'sqrt');
    finalQuestion = finalQuestion.replaceAll('^', '**');
    finalQuestion = finalQuestion.replaceAll('sin', 'sin(');
    finalQuestion = finalQuestion.replaceAll('cos', 'cos(');
    finalQuestion = finalQuestion.replaceAll('tan', 'tan(');
    finalQuestion = finalQuestion.replaceAll('log', 'log(');
    finalQuestion = finalQuestion.replaceAll('ln', 'ln(');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    String result = eval.toStringAsFixed(10);
    result = result.replaceAll(RegExp(r'(?<=\d)0*$'), '');

    userAns = result;
    if (eval % 1 == 0) {
      userAns = eval.toInt().toString();
    }
  } catch (e) {
    userAns = 'Error';
  }
}


}
