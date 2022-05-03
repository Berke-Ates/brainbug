import 'package:brainbug/interpreter.dart';
import 'package:flutter/material.dart';

class Controls extends StatelessWidget {
  final Interpreter interpreter;

  const Controls(this.interpreter);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ControlButton(),
        ControlButton(),
        ControlButton(),
        ControlButton(),
      ],
    );
  }
}

class ControlButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 6,
        ),
      ),
      child: const AspectRatio(
        aspectRatio: 1,
      ),
    );
  }
}
