import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/infrastructure/models/scan_model.dart';

import 'package:qr_app/presentation/providers/providers.dart';
import 'package:qr_app/presentation/screens/qr/directions_screen.dart';
import 'package:qr_app/presentation/widgets/widgets.dart';

import '../screens.dart';



class HomeScreen extends StatelessWidget {

  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final themeProvider = context.watch<ThemeProvider>();
    final scanListProvider = context.watch<ScanListProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(onPressed: () {
            
            scanListProvider.deleteAllScans();

          }, icon: Icon(Icons.delete_forever_outlined, color: colors.primary)),
          IconButton(onPressed: () {
              themeProvider.isDarkMode = !themeProvider.isDarkMode;

          }, icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode), color: colors.primary)
        ],
        elevation: 0,
      ),
      body: _HomeView(),

      bottomNavigationBar: const CustomNavigatorbar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final UiProvider(:selectedMenuOption) = context.watch<UiProvider>();
    final scanListProvider = context.watch<ScanListProvider>();

    switch(selectedMenuOption) {
      
      case 0:
        scanListProvider.loadScansByType(ScanType.geo);
        
        return const MapsScreen();
      case 1:
        scanListProvider.loadScansByType(ScanType.http);
        return const DirectionsScreen();
      default:
        scanListProvider.loadScansByType(ScanType.http);
        return const MapsScreen();
    }

  }
}

