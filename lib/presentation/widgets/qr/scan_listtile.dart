import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/helpers/utils.dart';
import '../../../infrastructure/models/models.dart';
import '../../providers/providers.dart';


class ScanListTile extends StatelessWidget {

  final ScanType type;

  const ScanListTile({
    super.key, 
    required this.type,
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final scanListProvider = context.watch<ScanListProvider>();
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (BuildContext context, int index) {
          final scan = scans[index];
          return Dismissible(
            key: Key(scan.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (DismissDirection direction) async {

              await scanListProvider.deleteScanById(scan.id!);

            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 30),
              color: colors.onInverseSurface,
              child: Icon(Icons.delete, color: colors.primary),
            ),
            child: ListTile(
              leading: Icon(type == ScanType.http ? Icons.map_outlined : Icons.home_outlined, color: colors.primary,),
              title: Text(scan.value),
              subtitle: Text('cod: ${scan.id}'),
              trailing: Icon(Icons.keyboard_arrow_right_outlined, color: colors.primary,),
              onTap: () => launchURL(context, scan),
            ),
          );
      });
  }
}