import 'package:brainbug/editor.dart';
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
  final Interpreter interpreter = Interpreter();
  final EditorController ec = EditorController();

  @override
  void initState() {
    super.initState();

    createTicker((Duration elapsed) {
      if (elapsed.inMilliseconds % 100 == 0 && !interpreter.isDone()) {
        interpreter.step();
        ec.mark = interpreter.cPtr;
        setState(() {});
      }
    }).start();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainBug',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        primaryColorDark: Colors.deepPurple[800],
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(
              labelMedium: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white70),
            )
            .apply(
              fontSizeFactor: 2,
              bodyColor: Colors.white70,
              fontFamily: 'SourceCodePro',
            ),
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Editor(interpreter, controller: ec),
                const SizedBox(height: 50),
                TapeView(interpreter),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
