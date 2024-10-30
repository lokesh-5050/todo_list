import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/core/utils/app_constants.dart';
import 'package:todo/core/utils/injections.dart';
import 'package:todo/services/router/router_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectDependencies.inject();
  GoRouter router = MyAppRouterConfig.getRouter();

  runApp(MyApp(
    router: router,
  ));
}

class MyApp extends StatefulWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      final mediaQueryData = MediaQuery.of(context);
      final scale = mediaQueryData.textScaler
          .clamp(maxScaleFactor: 0.9, minScaleFactor: 0.8);
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: scale),
        child: MaterialApp.router(
          title: AppConstants.appName,
          routeInformationParser: widget.router.routeInformationParser,
          routeInformationProvider: widget.router.routeInformationProvider,
          routerDelegate: widget.router.routerDelegate,
          debugShowCheckedModeBanner: false,
        ),
      );
    });
  }
}
