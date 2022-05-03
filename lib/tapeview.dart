import 'package:brainbug/interpreter.dart';
import 'package:flutter/material.dart';

class TapeView extends StatelessWidget {
  final Interpreter interpreter;

  const TapeView(this.interpreter);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: interpreter.tape.entries
          .map(
            (MapEntry<int, int> e) => MemoryCell(
              pos: e.key,
              val: e.value,
              sym: interpreter.byte2Ascii(e.value),
              selected: e.key == interpreter.tPtr,
            ),
          )
          .toList(),
    );
  }
}

class MemoryCell extends StatelessWidget {
  final int pos;
  final int val;
  final String sym;
  final bool selected;

  const MemoryCell({
    required this.pos,
    required this.val,
    required this.sym,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(4),
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(
          color: selected
              ? Theme.of(context).primaryColor
              : Theme.of(context).dividerColor,
          width: 8,
        ),
      ),
      duration: const Duration(milliseconds: 50),
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).dividerColor,
                      width: 4,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(val.toString()),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 4,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(pos.toString()),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(sym),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
