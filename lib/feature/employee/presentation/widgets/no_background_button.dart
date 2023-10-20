import 'package:flutter/material.dart';

class NoBackGroundButton extends StatelessWidget {
  final void Function(BuildContext context) onPressed;
  final String buttonText;
  const NoBackGroundButton(
      {super.key, required this.onPressed, required this.buttonText});
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => onPressed(context),
        style: TextButton.styleFrom(
          textStyle: const TextStyle(fontSize: 13),
          shape: null,
          backgroundColor: null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: const TextStyle(color: Color(0xFFFF9C00)),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.arrow_right_alt,
              size: 20,
              color: Colors.white,
            )
          ],
        ));
  }
}
