import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/src/controllers/task_controller.dart';
import 'package:todo/src/models/task_model.dart';

class BottomBorderedTaskTile extends StatelessWidget {
  final Task task;

  BottomBorderedTaskTile({super.key, required this.task});

  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.9),
            blurStyle: BlurStyle.inner,
            offset: Offset.fromDirection(1, 7),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  task.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(
                      CupertinoIcons.checkmark_circle,
                      color: Colors.black,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${task.numberOfTasks} Tasks',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.delete_outline).ripple(() {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text("Permanently delete the task"),
                            actions: [
                              CupertinoButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    context.pop();
                                  }),
                              CupertinoButton(
                                  child: Text("Procced"),
                                  onPressed: () {
                                    taskController.deleteTask(task.id ?? 0);
                                    context.pop();
                                  })
                            ],
                          );
                        },
                      );
                    })
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                color: task.status == 0
                    ? ligthFaceBookColor
                    : task.status == 2
                        ? Colors.teal.withOpacity(0.7)
                        : whiteColor,
                child: Text(
                  task.status == 0
                      ? 'On-Going'
                      : task.status == 2
                          ? 'Completed'
                          : '',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ).p(10),
              ).round(8),
              CupertinoCheckbox(
                  activeColor: darkBlackColor,
                  value: task.status == 2,
                  onChanged: (e) {
                    taskController.updateTaskStatus(
                        task.id ?? 0,
                        task.status == 0
                            ? 2
                            : task.status == 2
                                ? 0
                                : 0);
                  })
            ],
          ),
        ],
      ),
    );
  }
}
