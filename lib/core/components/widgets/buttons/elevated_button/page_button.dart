import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LogInElevatedButton extends StatelessWidget {
  final bool status;
  final ValueChanged<bool> onSelectedd;
  final Color color;
  final String title;
  const LogInElevatedButton(
      {Key key, this.status, this.onSelectedd, this.color, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.07),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: context.highBorderRadius,
            ))),
        onPressed: () {
          if (title == 'Sign in') {
            onSelectedd(true);
          } else {
            onSelectedd(false);
          }
        },
        child: Text(
          title,
          style: context.textTheme.headline6,
        ),
      ),
    );
  }
}
