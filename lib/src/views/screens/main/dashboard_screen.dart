import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/services/router/route_names.dart';

class DashboardScreen extends StatefulWidget {
  final StatefulNavigationShell child;

  const DashboardScreen({super.key, required this.child});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(child: widget.child).hP8,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: whiteColor,
          onPressed: () {
            context.pushNamed(RouteNames.createTask);
          },
          child: const Icon(
            CupertinoIcons.add,
            color: unselectedFilterChip,
          )),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: whiteColor,
          onTap: (value) {
            widget.child.goBranch(value);
          },
          currentIndex: widget.child.currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: "Home",
                activeIcon: Icon(
                  CupertinoIcons.house_fill,
                  color: unselectedFilterChip,
                )),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: "Profile",
                activeIcon: Icon(
                  CupertinoIcons.person_fill,
                  color: unselectedFilterChip,
                )),
          ]),
    );
  }
}
