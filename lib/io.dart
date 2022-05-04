import 'package:brainbug/editor.dart';
import 'package:brainbug/interpreter.dart';
import 'package:flutter/material.dart';

class IO extends StatelessWidget {
  final Interpreter interpreter;
  final EditorController controller;

  const IO(this.interpreter, {required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(4),
            color: Theme.of(context).backgroundColor,
            child: TextField(
              controller: controller,
              cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
              maxLines: null,
              onChanged: (String? s) {
                if (s != null) {
                  interpreter.input = s;
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
                labelText: 'Input',
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(4),
            color: Theme.of(context).backgroundColor,
            child: TextField(
              cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
              maxLines: null,
              readOnly: true,
              controller: TextEditingController(text: interpreter.output),
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
                labelText: 'Output',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
