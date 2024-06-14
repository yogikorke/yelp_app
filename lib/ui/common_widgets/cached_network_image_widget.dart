import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatefulWidget {
  final String? downloadUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const CachedNetworkImageWidget(
    this.downloadUrl, {
    this.fit,
    this.width,
    this.height,
    super.key,
  });

  @override
  CachedNetworkImageWidgetState createState() =>
      CachedNetworkImageWidgetState();
}

class CachedNetworkImageWidgetState extends State<CachedNetworkImageWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.downloadUrl != null && widget.downloadUrl!.trim().isNotEmpty
        ? CachedNetworkImage(
            imageUrl: widget.downloadUrl!,
            width: widget.width,
            height: widget.height,
            fit: widget.fit ?? BoxFit.cover,
            placeholder: (context, url) => const Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
            errorWidget: (context, url, error) {
              return Image.network(
                widget.downloadUrl!,
                fit: widget.fit ?? BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) {
                  //UiUtilities.showToast('Error occured : ${error.toString()}');
                  // //debugPrint('Error occured : ${error.toString()}');
                  return const Icon(
                    Icons.fastfood,
                    size: 128,
                    color: Colors.grey,
                  );
                },
              );
            },
          )
        : const Icon(
            Icons.fastfood,
            size: 48,
            color: Colors.grey,
          );
  }
}
