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
          vertical: 16.w,
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
                  padding: EdgeInsets.all(32.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.w),
                    child: CachedNetworkImageWidget(
                      widget.businessModel.imageUrl ?? '',
                      width: 300.w,
                      height: 300.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.w),
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
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      OpenClosedWidget(businessModel: widget.businessModel),
                      DistanceWidget(
                        businessModel: widget.businessModel,
                        size: 64.w,
                      ),
                      RatingBarWidget(businessModel: widget.businessModel),
                    ],
                  ),
                ),
              ],
            ),
            // widget.businessModel.categories?.isNotEmpty ?? false
            //     ? Padding(
            //         padding: EdgeInsets.only(left: 16.w, bottom: 32.w),
            //         child: SizedBox(
            //           height: 100.w,
            //           child: ListView.builder(
            //             shrinkWrap: true,
            //             scrollDirection: Axis.horizontal,
            //             itemCount: widget.businessModel.transactions!.length,
            //             itemBuilder: (context, index) {
            //               final transaction =
            //                   widget.businessModel.transactions![index];
            //               return Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            //                 child: Chip(
            //                   visualDensity: VisualDensity.compact,
            //                   padding: EdgeInsets.symmetric(horizontal: 4.w),
            //                   labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
            //                   label: Text(
            //                     transaction,
            //                     style: GoogleFonts.openSans(
            //                       fontSize: 32.sp,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       )
            //     : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
