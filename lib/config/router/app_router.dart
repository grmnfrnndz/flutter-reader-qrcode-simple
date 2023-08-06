import 'package:go_router/go_router.dart';
import 'package:qr_app/infrastructure/models/scan_model.dart';

import '../../presentation/screens/screens.dart';


final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home', name: HomeScreen.name, builder: (context, state) => const HomeScreen(),),
    GoRoute(path: '/map', name: MapScreen.name, builder: (context, state) => MapScreen(scan: state.extra! as ScanModel),),
  ],
);