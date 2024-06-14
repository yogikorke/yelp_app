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
      margin: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: (businessModel.isClosed ?? true)
              ? Colors.red
              : Colors.green.shade600,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      child: Text(
        (businessModel.isClosed ?? true) ? 'CLOSED' : 'OPEN',
        style: GoogleFonts.openSans(
          fontSize: 32.r,
          fontWeight: FontWeight.w500,
          color: (businessModel.isClosed ?? true)
              ? Colors.red
              : Colors.green.shade600,
        ),
      ),
    );
  }
}
