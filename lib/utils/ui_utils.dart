import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UiUtils {
  static void showInformationalDialog(
    BuildContext context,
    String title,
    String content, {
    Function? onOkPressed,
  }) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (onOkPressed != null) {
                  onOkPressed();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
