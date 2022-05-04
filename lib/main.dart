import 'dart:async';

import 'package:brainbug/controls.dart';
import 'package:brainbug/editor.dart';
import 'package:brainbug/interpreter.dart';
import 'package:brainbug/io.dart';
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

class _BrainBugState extends State<BrainBug> {
  final Interpreter interpreter = Interpreter();
  final EditorController ec = EditorController();
  final EditorController ic = EditorController();
  Duration delay = const Duration(milliseconds: 10);
  Timer? timer;

  void step([int stepsize = 1]) {
    final bool isDone = interpreter.step(stepsize);
    ec.mark = interpreter.cPtr;
    ic.mark = interpreter.iPtr;
    if (isDone) pause();
    setState(() {});
  }

  void play() {
    timer = Timer.periodic(delay, (Timer timer) {
      step();
    });
  }

  void pause() {
    if (timer != null) timer!.cancel();
    setState(() {});
  }

  void stop() {
    interpreter.reset();
    ec.mark = interpreter.cPtr;
    ic.mark = interpreter.iPtr;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrainBug',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        primaryColorDark: Colors.deepPurple[800],
        scaffoldBackgroundColor: const Color(0xFF121212),
        backgroundColor: const Color(0xFF222222),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Editor(interpreter, controller: ec),
                    ),
                    Expanded(
                      child: Controls(
                        interpreter,
                        step: step,
                        play: play,
                        pause: pause,
                        stop: stop,
                        isRunning: timer != null && timer!.isActive,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                IO(interpreter, controller: ic),
                const SizedBox(height: 25),
                TapeView(interpreter),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
