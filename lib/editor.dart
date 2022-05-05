import 'package:brainbug/interpreter.dart';
import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final Interpreter interpreter;
  final EditorController controller;

  const Editor(this.interpreter, {required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      color: Theme.of(context).backgroundColor,
      child: TextField(
        cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
        cursorWidth: 4,
        cursorRadius: const Radius.circular(5),
        maxLines: null,
        minLines: 10,
        controller: controller,
        onChanged: (String? s) {
          if (s != null) {
            interpreter.code = controller.text;
          }
        },
        decoration: InputDecoration(
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: Divider.createBorderSide(context, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: Divider.createBorderSide(context, width: 3),
          ),
          floatingLabelStyle: Theme.of(context).textTheme.labelMedium,
          labelText: 'Code',
        ),
      ),
    );
  }
}

class EditorController extends TextEditingController {
  int mark = 0;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final String ps =
        text.padRight(mark + 1, text.isEmpty && mark == 0 ? ' ' : '\$');

    final List<TextSpan> colored = ps.split('').map((String e) {
      switch (e) {
        case '>':
          return TextSpan(
            text: e,
            style: style!.copyWith(color: Colors.blue[600]),
          );
        case '<':
          return TextSpan(
            text: e,
            style: style!.copyWith(color: Colors.yellow[900]),
          );
        case '+':
          return TextSpan(
            text: e,
            style: style!.copyWith(color: Colors.green[600]),
          );
        case '-':
          return TextSpan(
            text: e,
            style: style!.copyWith(color: Colors.red[600]),
          );
        case '[':
          return TextSpan(
            text: e,
            style: style!.copyWith(color: Colors.purpleAccent[700]),
          );
        case ']':
          return TextSpan(
            text: e,
            style: style!.copyWith(color: Colors.purpleAccent[700]),
          );
        case '.':
          return TextSpan(
            text: e,
            style: style!.copyWith(color: Colors.white70),
          );
        case ',':
          return TextSpan(
            text: e,
            style: style!.copyWith(color: Colors.white70),
          );
      }

      return TextSpan(
        text: e,
        style: style!.copyWith(color: Colors.white38),
      );
    }).toList();

    if (mark >= 0) {
      colored[mark] = TextSpan(
        text: colored[mark].text,
        style: style!.copyWith(
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    }

    return TextSpan(
      style: style,
      children: colored,
    );
  }
}
