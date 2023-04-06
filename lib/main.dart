import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override

  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';

  var answer = '';

  // Array of button

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Simple Calculator ",
          style: TextStyle(fontSize: 35, color: Color.fromARGB(255, 45, 1, 1)),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                _showDialog(context, "App Developer", "SANTOSH ADHIKARI ");
              },
              icon: const Icon(Icons.info))
        ],
      ), //AppBar

      backgroundColor: const Color.fromARGB(230, 247, 8, 8),

      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: const TextStyle(
                          fontSize: 18, color: Color.fromARGB(255, 15, 13, 13)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: const TextStyle(
                          fontSize: 30,
                          color: Color.fromRGBO(10, 10, 11, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button

                  if (index == 0) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput = '';

                          answer = '0';
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromARGB(255, 121, 20, 22),
                      textColor: Colors.black,
                    );
                  }

                  // +/- button

                  else if (index == 1) {
                    return MyButton(
                      buttonText: buttons[index],
                      color: const Color.fromARGB(255, 165, 221, 10),
                      textColor: const Color.fromARGB(255, 153, 29, 29),
                    );
                  }

                  // % Button

                  else if (index == 2) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromARGB(255, 103, 107, 110),
                      textColor: Colors.black,
                    );
                  }

                  // Delete Button

                  else if (index == 3) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromARGB(255, 42, 73, 95),
                      textColor: Colors.black,
                    );
                  }

                  // Equal_to Button

                  else if (index == 18) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: const Color.fromARGB(255, 128, 90, 51),
                      textColor: Colors.white,
                    );
                  }

                  //  other buttons

                  else {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? const Color.fromARGB(255, 21, 116, 26)
                          : const Color.fromARGB(255, 158, 80, 80),
                      textColor: isOperator(buttons[index])
                          ? const Color.fromARGB(255, 141, 6, 6)
                          : Colors.black,
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }

    return false;
  }

// function to calculate the input operation

  void equalPressed() {
    String finaluserinput = userInput;

    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();

    Expression exp = p.parse(finaluserinput);

    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }
}

// Dialog Start
_showDialog(context, String title, String body) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      scrollable: true,
      title: Text(title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            body,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: const Text("Ok"),
        ),
      ],
    ),
  );
}
