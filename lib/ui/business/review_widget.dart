import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/ui_utils.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(
        vertical: 32.h,
        horizontal: 4.w,
      ),
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Customer Name',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.r,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.h,
                    horizontal: 8.w,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '4.5',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.normal,
                          fontSize: 32.r,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Icon(
                          Icons.star,
                          size: 32.r,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                '"I am really long long review so if you try to read me then you will just waste you time"',
                style: GoogleFonts.openSans(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                  fontSize: 40.r,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  UiUtils.getDateTimeFormatter().format(
                    DateTime.now(),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 32.r,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
