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
        padding: EdgeInsets.only(top: 16.w),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 100.w,
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
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.getLightThemeData(Brightness.light)
                        .colorScheme
                        .onSurface,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.getLightThemeData(Brightness.light)
                        .colorScheme
                        .primary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      decoration: BoxDecoration(
                        color: AppTheme.getLightThemeData(Brightness.light)
                            .colorScheme
                            .primary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            widget.businessModel.rating.toString(),
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.sp,
                              color:
                                  AppTheme.getLightThemeData(Brightness.light)
                                      .colorScheme
                                      .onPrimary,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Icon(
                              Icons.star,
                              size: 16,
                              color:
                                  AppTheme.getLightThemeData(Brightness.light)
                                      .colorScheme
                                      .onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 2, 4, 4),
                      child: Column(
                        children: [
                          Text(
                            widget.businessModel.reviewCount.toString(),
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.normal,
                              fontSize: 32.sp,
                            ),
                          ),
                          Text(
                            'Reviews',
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.normal,
                              fontSize: 32.sp,
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
        padding: EdgeInsets.only(left: 16.w),
        child: DistanceWidget(
          businessModel: widget.businessModel,
          size: 100.w,
        ),
      ),
    );
    silverListWidgets.add(
      Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Row(
          children: [
            Icon(
              Icons.room_service_outlined,
              size: 100.w,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: widget.businessModel.transactions!.map((label) {
                    return Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text(label),
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
        padding: EdgeInsets.only(left: 16.w),
        child: Row(
          children: [
            Icon(
              Icons.category_outlined,
              size: 100.w,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 32.w),
                child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: widget.businessModel.categories!.map((category) {
                    return Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text(category.title ?? ''),
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
        padding: EdgeInsets.only(top: 32.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                IconButton.outlined(
                  onPressed: () async {
                    await FlutterPhoneDirectCaller.callNumber(
                      widget.businessModel.displayPhone ?? '',
                    );
                  },
                  icon: const Icon(Icons.phone),
                ),
                Text(
                  'Call',
                  style: TextStyle(fontSize: 40.sp),
                )
              ],
            ),
            Column(
              children: [
                IconButton.outlined(
                  onPressed: () async {
                    final Uri url = Uri.parse(widget.businessModel.url ?? '');
                    debugPrint('URL: $url');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  icon: const Icon(Icons.launch),
                ),
                Text(
                  'Website',
                  style: TextStyle(fontSize: 40.sp),
                )
              ],
            ),
            Column(
              children: [
                IconButton.outlined(
                  onPressed: () async {
                    await MapsLauncher.launchCoordinates(
                      widget.businessModel.coordinates!.latitude!,
                      widget.businessModel.coordinates!.longitude!,
                    );
                  },
                  icon: const Icon(Icons.directions_outlined),
                ),
                Text(
                  'Directions',
                  style: TextStyle(fontSize: 40.sp),
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
            floating: true,
            pinned: true,
            snap: false,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              centerTitle: true,
              titlePadding: EdgeInsets.only(left: 16.w, bottom: 32.w),
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
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                          fontSize: 56.sp,
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
                fit: BoxFit.fill,
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
