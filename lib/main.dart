import 'package:brainbug/interpreter.dart';
import 'package:brainbug/tapeview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BrainBug());
}

class BrainBug extends StatefulWidget {
  const BrainBug({Key? key}) : super(key: key);

  @override
  State<BrainBug> createState() => _BrainBugState();
}

class _BrainBugState extends State<BrainBug>
    with SingleTickerProviderStateMixin {
  final Interpreter interpreter = Interpreter(
      '++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.',
      '12341234');
  int el = 0;

  @override
  void initState() {
    super.initState();

    createTicker((Duration elapsed) {
      if (!interpreter.isDone()) {
        interpreter.step();
        setState(() {});
        print(interpreter.output);
      }
    }).start();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainBug',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 2,
              bodyColor: Colors.white,
            ),
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: TapeView(interpreter),
        ),
      ),
    );
  }
}
