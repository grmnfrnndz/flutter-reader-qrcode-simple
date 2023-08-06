import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../infrastructure/models/models.dart';
import '../../presentation/screens/screens.dart';


Future<void> launchURL(BuildContext context, ScanModel scanModel) async {
  

  // open website
  if(scanModel.type == ScanType.http) {
    final uri =  Uri.parse(scanModel.value);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri)      ;
    } else {
      throw Exception('Could not launch ${scanModel.value}');
    }
  } else {
    context.pushNamed(MapScreen.name, extra: scanModel);
  }
}
