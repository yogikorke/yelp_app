import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/business_model.dart';

class OpenClosedWidget extends StatelessWidget {
  final BusinessModel businessModel;

  const OpenClosedWidget({super.key, required this.businessModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: (businessModel.isClosed ?? true)
              ? Colors.red
              : Colors.green.shade600,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.w),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.w,
      ),
      child: Text(
        (businessModel.isClosed ?? true) ? 'CLOSED' : 'OPEN',
        style: GoogleFonts.openSans(
          fontSize: 32.sp,
          fontWeight: FontWeight.w500,
          color: (businessModel.isClosed ?? true)
              ? Colors.red
              : Colors.green.shade600,
        ),
      ),
    );
  }
}
