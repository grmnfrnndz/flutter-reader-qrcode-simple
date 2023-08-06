import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/router/app_router.dart';
import 'package:qr_app/config/theme/app_theme.dart';
import 'package:qr_app/presentation/providers/providers.dart';


void main() => runApp(const AppState());


class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => ThemeProvider(), ),
        ChangeNotifierProvider(create:(context) => UiProvider(), ),
        ChangeNotifierProvider(create:(context) => ScanListProvider(), ),
      ],
      child: const MyApp(),
      );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeProvider(:colorSelected, :isDarkMode) = context.watch<ThemeProvider>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'QR Code Reader App',
      theme: AppTheme(colorSelected: colorSelected, isDarKMode: isDarkMode).getTHeme(),
    );
  }
}