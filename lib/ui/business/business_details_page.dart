import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yelp_app/ui/business/review_widget.dart';
import 'package:yelp_app/values/app_themes.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../model/business_model.dart';
import '../common_widgets/cached_network_image_widget.dart';
import '../common_widgets/distance_widget.dart';

class BusinessDetailsPage extends StatefulWidget {
  final BusinessModel businessModel;

  const BusinessDetailsPage({super.key, required this.businessModel});

  @override
  State<BusinessDetailsPage> createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  List<Widget> silverListWidgets = [];

  @override
  void initState() {
    super.initState();
    initializeSilverListWidget();
  }

  void initializeSilverListWidget() {
    silverListWidgets.add(
      Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 100.r,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Text(
                  widget.businessModel.location?.displayAddress?.join(', ') ??
                      '',
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                    fontSize: 40.r,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.getLightThemeData(Brightness.light)
                        .colorScheme
                        .primary,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.r),
                          topRight: Radius.circular(8.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            widget.businessModel.rating.toString(),
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.r,
                              color:
                                  AppTheme.getLightThemeData(Brightness.light)
                                      .colorScheme
                                      .primary,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Icon(
                              Icons.star,
                              size: 32.r,
                              color:
                                  AppTheme.getLightThemeData(Brightness.light)
                                      .colorScheme
                                      .primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1.h,
                      width: 200.r,
                      color: AppTheme.getLightThemeData(Brightness.light)
                          .colorScheme
                          .primary,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 4.h),
                      child: Column(
                        children: [
                          Text(
                            widget.businessModel.reviewCount.toString(),
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.normal,
                              fontSize: 32.r,
                            ),
                          ),
                          Text(
                            'Reviews',
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.normal,
                              fontSize: 32.r,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    silverListWidgets.add(
      Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: DistanceWidget(
          businessModel: widget.businessModel,
          size: 100.r,
        ),
      ),
    );
    silverListWidgets.add(
      Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Row(
          children: [
            Icon(
              Icons.room_service_outlined,
              size: 100.r,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 32.r),
                child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: widget.businessModel.transactions!.map((label) {
                    return Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text(
                        label,
                        style: GoogleFonts.openSans(
                          fontSize: 40.r,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    silverListWidgets.add(
      Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Row(
          children: [
            Icon(
              Icons.category_outlined,
              size: 100.r,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 32.r),
                child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: widget.businessModel.categories!.map((category) {
                    return Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text(
                        category.title ?? '',
                        style: GoogleFonts.openSans(
                          fontSize: 40.r,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    silverListWidgets.add(
      Padding(
        padding: EdgeInsets.only(top: 32.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton.outlined(
                  iconSize: 64.r,
                  onPressed: () async {
                    await FlutterPhoneDirectCaller.callNumber(
                      widget.businessModel.displayPhone ?? '',
                    );
                  },
                  icon: const Icon(
                    Icons.phone,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    'Call',
                    style: GoogleFonts.openSans(
                      fontSize: 40.r,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                IconButton.outlined(
                  iconSize: 64.r,
                  onPressed: () async {
                    final Uri url = Uri.parse(widget.businessModel.url ?? '');
                    debugPrint('URL: $url');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  icon: const Icon(Icons.launch),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    'Website',
                    style: GoogleFonts.openSans(
                      fontSize: 40.r,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                IconButton.outlined(
                  iconSize: 64.r,
                  onPressed: () async {
                    await MapsLauncher.launchCoordinates(
                      widget.businessModel.coordinates!.latitude!,
                      widget.businessModel.coordinates!.longitude!,
                    );
                  },
                  icon: const Icon(Icons.directions_outlined),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    'Directions',
                    style: GoogleFonts.openSans(
                      fontSize: 40.r,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );

    for (var v = 0; v < 15; v++) {
      silverListWidgets.add(const ReviewWidget());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            expandedHeight: 700.h,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              centerTitle: true,
              titlePadding: EdgeInsets.only(left: 16.w, bottom: 32.h),
              title: IntrinsicHeight(
                child: IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.8),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Align(
                      child: Text(
                        widget.businessModel.name ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 48.r,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              background: CachedNetworkImageWidget(
                widget.businessModel.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.w, horizontal: 32.w),
                  child: silverListWidgets[index],
                );
              },
              childCount: silverListWidgets.length,
            ),
          ),
        ],
      ),
    );
  }
}
