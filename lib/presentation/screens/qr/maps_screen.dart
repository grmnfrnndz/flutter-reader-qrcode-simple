import 'package:flutter/material.dart';

import '../../../infrastructure/models/models.dart';
import '../../widgets/widgets.dart';



class MapsScreen extends StatelessWidget {

  static const String name = 'maps_screen';

  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanListTile(type: ScanType.geo);
  }
}

