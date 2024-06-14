import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/business_model.dart';

class RatingBarWidget extends StatelessWidget {
  final BusinessModel businessModel;

  const RatingBarWidget({super.key, required this.businessModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          RatingBar.builder(
            itemSize: 64.r,
            initialRating: businessModel.rating ?? 0.0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Theme.of(context).colorScheme.primary,
            ),
            onRatingUpdate: (rating) {},
            tapOnlyMode: true,
          ),
          Text(
            '(${businessModel.reviewCount} reviews)',
            style: GoogleFonts.openSans(
              fontSize: 40.r,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
