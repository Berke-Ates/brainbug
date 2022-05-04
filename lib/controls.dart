import 'package:brainbug/interpreter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Controls extends StatelessWidget {
  final Interpreter interpreter;
  final Function([int]) step;
  final VoidCallback play;
  final VoidCallback pause;
  final VoidCallback stop;
  final bool isRunning;
  final TextEditingController stepC;
  final TextEditingController delayC;

  const Controls(
    this.interpreter, {
    required this.step,
    required this.play,
    required this.pause,
    required this.stop,
    required this.isRunning,
    required this.stepC,
    required this.delayC,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4),
                color: Theme.of(context).backgroundColor,
                child: TextField(
                  controller: stepC,
                  cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
                  cursorWidth: 4,
                  cursorRadius: const Radius.circular(5),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
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
                    labelText: 'Step Size',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(4),
                color: Theme.of(context).backgroundColor,
                child: TextField(
                  controller: delayC,
                  cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
                  cursorWidth: 4,
                  cursorRadius: const Radius.circular(5),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
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
                    labelText: 'Delay (ms)',
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            ControlButton(
              icon: Icons.arrow_forward_ios_rounded,
              message: 'Step',
              onTap: () {
                if (int.tryParse(stepC.text) == null) stepC.text = '1';
                step(int.parse(stepC.text));
              },
            ),
            if (!isRunning)
              ControlButton(
                icon: Icons.play_arrow_rounded,
                message: 'Run',
                onTap: play,
              ),
            if (isRunning)
              ControlButton(
                icon: Icons.pause_rounded,
                message: 'Pause',
                onTap: pause,
              ),
            ControlButton(
              icon: Icons.stop_rounded,
              message: 'Reset',
              onTap: stop,
            ),
          ],
        ),
      ],
    );
  }
}

class ControlButton extends StatelessWidget {
  final IconData icon;
  final String message;
  final VoidCallback onTap;

  const ControlButton({
    required this.icon,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Tooltip(
          message: message,
          textStyle: Theme.of(context).textTheme.bodyMedium,
          margin: const EdgeInsets.only(top: 25),
          decoration: const BoxDecoration(color: Colors.transparent),
          child: InkWell(
            onTap: onTap,
            hoverColor: Theme.of(context).primaryColorDark,
            highlightColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 3,
                ),
              ),
              child: Icon(
                icon,
                size: 50,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
