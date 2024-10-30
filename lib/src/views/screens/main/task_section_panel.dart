import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/src/controllers/task_controller.dart';
import 'package:todo/src/views/screens/main/widgets/bottom_bordered_task_tile.dart';

class TaskSectionPanel extends StatefulWidget {
  const TaskSectionPanel({super.key});

  @override
  State<TaskSectionPanel> createState() => _TaskSectionPanelState();
}

class _TaskSectionPanelState extends State<TaskSectionPanel> {
  final TaskController taskController = Get.find<TaskController>();

  @override
  void initState() {
    super.initState();
    taskController.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _buildStatSection()
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Tasks",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ).vP4,
            const SizedBox(
              height: 23,
            ),
            _buildTaskList()
          ],
        ),
      ),
    );
  }

  Widget _buildStatSection(){
    return SliverToBoxAdapter(
      child: Column(
        children: [
          AppBar(
            backgroundColor: whiteColor,
            leading: Container(
              width: 50,
              height: 50,
              color: unselectedFilterChip,
            ).round(50),
            title: Text(
              "Hi Jake👋",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  fontSize: 19.sp),
            ),
            actions: [
              IconButton.filled(
                  style: IconButton.styleFrom(
                      backgroundColor: lightGreyColor),
                  onPressed: () {},
                  iconSize: 22,
                  icon: const Icon(Icons.dashboard_outlined).p4)
            ],
          ).vP4,
          const SizedBox(
            height: 23,
          ),
          GetBuilder<TaskController>(
            builder: (controller) {
              return Wrap(
                direction: Axis.horizontal,
                spacing: 12,
                runSpacing: 12,
                children: [
                  generateTopSection(
                      color: ligthFaceBookColor,
                      icon: const Icon(
                        CupertinoIcons.restart,
                        color: whiteColor,
                      ),
                      taskCountOfStatus: controller.allTasks
                          .where((e) => e.status == 0)
                          .toList()
                          .length,
                      title: "On Going"),

                  //Not worked on this
                  // generateTopSection(
                  //     color: CupertinoColors.systemYellow,
                  //     icon: const Icon(
                  //       CupertinoIcons.time,
                  //       color: whiteColor,
                  //     ),
                  //     title: "In Process"),

                  generateTopSection(
                      color: Colors.teal.withOpacity(0.7),
                      icon: const Icon(
                        CupertinoIcons.restart,
                        color: whiteColor,
                      ),
                      taskCountOfStatus: controller.allTasks
                          .where((e) => e.status == 2)
                          .toList()
                          .length,
                      title: "Completed"),

                  //Not worked on this
                  // generateTopSection(
                  //     color: Colors.red.withOpacity(0.8),
                  //     icon: const Icon(
                  //       CupertinoIcons.restart,
                  //       color: whiteColor,
                  //     ),
                  //     title: "Cancelled"),
                ],
              ).center();
            },
          ),
          const SizedBox(
            height: 23,
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(){
    return GetBuilder<TaskController>(
      builder: (controller) {
        if (controller.allTasks.isNotEmpty) {
          return Expanded(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.allTasks.length,
                itemBuilder: (context, index) {
                  return BottomBorderedTaskTile(
                    task: controller.allTasks[index],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 13,
                ),
              ));
        }
        return const Text("No Tasks to show");
      },
    );
  }

  Widget generateTopSection(
      {required Icon icon,
      required String title,
      required Color color,
      int taskCountOfStatus = 0}) {
    return Container(
      color: color,
      width: MediaQuery.sizeOf(context).width / 2.2,
      child: Row(
        children: [
          IconButton.filled(
                  style: IconButton.styleFrom(
                      backgroundColor: lightGreyColor.withOpacity(0.3)),
                  onPressed: () {},
                  icon: icon)
              .rP4,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              Text("$taskCountOfStatus Tasks",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ).p(14),
    ).round(12);
  }
}
