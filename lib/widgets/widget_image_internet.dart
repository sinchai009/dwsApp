// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dwrapp/widgets/widget_image.dart';
import 'package:dwrapp/widgets/widget_progress.dart';
import 'package:flutter/material.dart';

class WidgetImageInternet extends StatelessWidget {
  final String url;
  const WidgetImageInternet({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(fit: BoxFit.cover,
      imageUrl: url,
      placeholder: (context, url) {
        return const WidgetProgress();
      },
      errorWidget: (context, url, error) {
        return const WidgetImage();
      },
    );
  }
}
