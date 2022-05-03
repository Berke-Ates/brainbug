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
        cursorColor: Colors.white10,
        cursorWidth: 4,
        cursorRadius: const Radius.circular(5),
        maxLines: null,
        minLines: 10,
        controller: controller,
        onChanged: (String? s) {
          if (s != null) {
            interpreter.code = controller.text;
            interpreter.reset();
            interpreter.analyze();
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
    return TextSpan(
      style: style,
      children: mark < 0 || mark >= text.length
          ? <TextSpan>[TextSpan(text: text)]
          : <TextSpan>[
              if (mark > 0) TextSpan(text: text.substring(0, mark)),
              TextSpan(
                text: text[mark],
                style: style!.copyWith(
                  backgroundColor: Theme.of(context).primaryColorDark,
                ),
              ),
              TextSpan(text: text.substring(mark + 1)),
            ],
    );
  }
}
