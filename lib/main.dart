import 'package:calculator_flutter/calc_button.dart';
import 'package:calculator_flutter/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var input = '';
  var answer = '';

  // Array of button
  final List<String> buttonSymbols = [
    'AC',
    '+/-',
    '%',
    ' / ',
    '7',
    '8',
    '9',
    ' x ',
    '4',
    '5',
    '6',
    ' - ',
    '1',
    '2',
    '3',
    ' + ',
    'DEL',
    '0',
    '.',
    '=',
  ];

@override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: CustomColors.richBlack
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CustomColors.richBlack,
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            input,
                            style: TextStyle(fontSize: 34, color: Colors.white, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            answer,
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: CustomColors.offBlack,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 36),
                    child: GridView.builder(
                    itemCount: 20,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (context, index) {
                        switch(index) {
                          // Clear
                          case 0:
                          return CalcButton(
                            buttonText: buttonSymbols[index], textColor: CustomColors.tiffany, textSize: 20,
                            buttonPressed: () {
                              setState(() {
                                input = '';
                                answer = '0';
                              });
                            },
                            buttonColor: CustomColors.buttonColor,);
                          // positive / negative
                          case 1:
                          return CalcButton(
                            buttonText: buttonSymbols[index], textColor: CustomColors.tiffany, textSize: 24,
                            buttonPressed: () {
                              
                            }, 
                            buttonColor: CustomColors.buttonColor,);
                          // percent
                          case 2:
                          return CalcButton(
                            buttonText: buttonSymbols[index], textColor: CustomColors.tiffany, textSize: 28, 
                            buttonPressed: () {
                              setState(() {
                                input += buttonSymbols[index];
                              });
                            }, 
                            buttonColor: CustomColors.buttonColor,);
                          // delete
                          case 16:
                          return CalcButton(
                            buttonText: buttonSymbols[index], textColor: Colors.white, textSize: 20, 
                            buttonPressed: () {
                              setState(() {
                                input = input.substring(0, input.length - 1);
                              });
                            }, 
                            buttonColor: CustomColors.buttonColor,);
                          // equal
                          case 19:
                          return CalcButton(
                            buttonText: buttonSymbols[index], textColor: CustomColors.amaranth, textSize: 36.0, 
                            buttonPressed: () {
                              setState(() {
                                calculateInput();
                              });
                            }, 
                            buttonColor: CustomColors.buttonColor,);
                          default:
                          return CalcButton(
                            buttonText: buttonSymbols[index], 
                            textColor: _isOperator(buttonSymbols[index]) ? CustomColors.amaranth : Colors.white, 
                            textSize: 24, 
                            buttonPressed: () {
                              setState(() {
                                input += buttonSymbols[index];
                              });
                            }, 
                            buttonColor: CustomColors.buttonColor,
                          );
                        }
                      }
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isOperator(String buttonText) {
    if (buttonText == ' / ' || buttonText == ' x ' || buttonText == ' - ' || buttonText == ' + ' || buttonText == '=') {
      return true;
    } else {
      return false;
    }
  }

  void calculateInput() {
    String finaluserinput = input;
    finaluserinput = input.replaceAll('x', '*');
  
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}