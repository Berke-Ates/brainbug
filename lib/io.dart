import 'package:brainbug/interpreter.dart';
import 'package:flutter/material.dart';

class IO extends StatelessWidget {
  final Interpreter interpreter;

  const IO(this.interpreter);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
            maxLines: null,
            onChanged: (String? s) {
              if (s != null) {
                interpreter.input = s;
                interpreter.reset();
                interpreter.analyze();
              }
            },
            decoration: InputDecoration(
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 3,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 3,
                ),
              ),
              floatingLabelStyle: Theme.of(context).textTheme.labelMedium,
              labelText: 'Input',
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
            maxLines: null,
            readOnly: true,
            controller: TextEditingController(text: interpreter.output),
            decoration: InputDecoration(
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 3,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 3,
                ),
              ),
              floatingLabelStyle: Theme.of(context).textTheme.labelMedium,
              labelText: 'Ouput',
            ),
          ),
        ),
      ],
    );
  }
}
