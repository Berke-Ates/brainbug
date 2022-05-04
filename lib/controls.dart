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
          onTap: step,
        ),
        if (!isRunning)
          ControlButton(
            icon: Icons.play_arrow_rounded,
            onTap: play,
          ),
        if (isRunning)
          ControlButton(
            icon: Icons.pause_rounded,
            onTap: pause,
          ),
        ControlButton(
          icon: Icons.stop_rounded,
          onTap: stop,
        ),
      ],
    );
  }
}

class ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ControlButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
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
    );
  }
}
