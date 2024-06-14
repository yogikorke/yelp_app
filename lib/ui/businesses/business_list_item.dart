import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yelp_app/ui/common_widgets/cached_network_image_widget.dart';
import 'package:yelp_app/ui/common_widgets/distance_widget.dart';
import 'package:yelp_app/ui/common_widgets/open_closed_widget.dart';
import 'package:yelp_app/ui/common_widgets/ratingbar_widget.dart';

import '../../model/business_model.dart';
import '../business/business_details_page.dart';

class BusinessListItem extends StatefulWidget {
  final BusinessModel businessModel;

  const BusinessListItem(this.businessModel, {super.key});

  @override
  State<BusinessListItem> createState() => _BusinessListItemState();
}

class _BusinessListItemState extends State<BusinessListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessDetailsPage(
              businessModel: widget.businessModel,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 32.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(32.r),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImageWidget(
                      widget.businessModel.imageUrl ?? '',
                      width: 300.r,
                      height: 300.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: ScreenUtil().screenWidth * 0.60,
                        child: Text(
                          widget.businessModel.name ?? 'Name',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 40.r,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      OpenClosedWidget(businessModel: widget.businessModel),
                      DistanceWidget(
                        businessModel: widget.businessModel,
                        size: 64.r,
                      ),
                      RatingBarWidget(businessModel: widget.businessModel),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
