import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PomodoroButton extends StatelessWidget {
  const PomodoroButton({super.key, required this.onPressed, required this.text, required this.fontSize});
  final Function() onPressed;
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.white),
      ).copyWith(
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white10;
            }
            return null;
          },
        ),
      ),
      child: FittedBox(
        child: Text(
          text,
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
