import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/services/router/route_names.dart';
import 'package:todo/services/router/route_paths.dart';
import 'package:todo/src/views/screens/main/create_task_screen.dart';
import 'package:todo/src/views/screens/main/dashboard_screen.dart';
import 'package:todo/src/views/screens/main/profile/profile_screen.dart';
import 'package:todo/src/views/screens/main/task_section_panel.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root');

class MyAppRouterConfig {
  static GoRouter getRouter() {
    GoRouter router = GoRouter(
        navigatorKey: rootNavigatorKey,
        redirect: (context, state) async {},
        onException: (context, state, router) {},
        initialLocation: RoutePaths.allTask,
        debugLogDiagnostics: true,
        routes: [
          StatefulShellRoute.indexedStack(
              pageBuilder: (context, state, navigationShell) {
                return CupertinoPage(
                    child: DashboardScreen(child: navigationShell));
              },
              branches: [
                StatefulShellBranch(routes: [
                  GoRoute(
                      path: RoutePaths.allTask,
                      name: RouteNames.allTask,
                      pageBuilder: (context, state) {
                        return const CupertinoPage(child: TaskSectionPanel());
                      },
                      routes: [
                        GoRoute(
                          parentNavigatorKey: rootNavigatorKey,
                          path: RoutePaths.createTask,
                          name: RouteNames.createTask,
                          pageBuilder: (context, state) {
                            return CupertinoPage(child: CreateTaskScreen());
                          },
                        ),
                      ]),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: RoutePaths.profile,
                    name: RouteNames.profile,
                    pageBuilder: (context, state) {
                      return const CupertinoPage(child: ProfileScreen());
                    },
                  ),
                ]),
              ]),
        ]);
    return router;
  }
}
