import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/presentation/providers/providers.dart';

class CustomNavigatorbar extends StatelessWidget {
  const CustomNavigatorbar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final uiProvider = context.watch<UiProvider>();

    return BottomNavigationBar(
      elevation: 0,
      currentIndex: uiProvider.selectedMenuOption,
      onTap: (int value) => uiProvider.selectedMenuOption = value,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined, color: colors.primary), label: 'Maps'),
        BottomNavigationBarItem(icon: Icon(Icons.compare_sharp, color: colors.primary), label: 'Directions'),
      ],
    );
  }
}

