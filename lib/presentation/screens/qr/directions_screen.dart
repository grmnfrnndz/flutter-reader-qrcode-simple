import 'package:flutter/material.dart';

import '../../../infrastructure/models/models.dart';
import '../../widgets/widgets.dart';


class DirectionsScreen extends StatelessWidget {

  static const String name = 'directions_screen';

  const DirectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const ScanListTile(type: ScanType.http);
  }
}