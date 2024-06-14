import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/business_model.dart';
import '../../utils/functional_utils.dart';

class DistanceWidget extends StatelessWidget {
  final BusinessModel businessModel;
  final double size;

  const DistanceWidget({
    super.key,
    required this.businessModel,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.w),
      child: Row(
        children: [
          Icon(
            Icons.delivery_dining_outlined,
            size: size,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.r),
            child: Text(
              '${FunctionalUtils.meterToKilometer(
                businessModel.distance ?? 0,
              ).toStringAsFixed(2)} km',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                fontSize: 40.r,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
