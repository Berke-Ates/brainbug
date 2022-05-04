import 'package:brainbug/interpreter.dart';
import 'package:flutter/material.dart';

class Controls extends StatelessWidget {
  final Interpreter interpreter;
  final VoidCallback step;
  final VoidCallback play;
  final VoidCallback pause;
  final VoidCallback stop;
  final bool isRunning;

  const Controls(
    this.interpreter, {
    required this.step,
    required this.play,
    required this.pause,
    required this.stop,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ControlButton(
          icon: Icons.arrow_forward_ios_rounded,
          message: 'Step',
          onTap: step,
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
