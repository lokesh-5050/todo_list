import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/core/utils/messenger.dart';
import 'package:todo/services/router/route_names.dart';
import 'package:todo/src/controllers/task_controller.dart';
import 'package:todo/src/models/task_model.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? dateTime;
  final TaskController taskController = Get.find<TaskController>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3024),
    );

    if (selectedDate != null) {
      dateTime = selectedDate;
      setState(() {});
    }
  }

  void _addTask() {
    if (taskController.taskAddingStatus != TaskAddingStatus.loading) {
      debugPrint(
          'taskController.creatingSubTaskController.length  :${taskController.creatingSubTaskController.any((e) => e.text.trim().isEmpty)}');
      // return;
      if (titleController.text.trim().isEmpty) {
        return Messenger.showMessage("Please fill the title", "");
      } else if (dateTime?.year == null) {
        return Messenger.showMessage("Please enter the date", "");
      } else if (descriptionController.text.trim().isEmpty) {
        return Messenger.showMessage("Please fill the description", "");
      } else if (taskController.creatingSubTaskController.isNotEmpty) {
        if (taskController.creatingSubTaskController
            .any((e) => e.text.trim().isEmpty)) {
          return Messenger.showMessage("SubTask cannot be empty", "");
        }
      }
      taskController
          .addTask(Task(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              numberOfTasks: taskController.creatingSubTaskController.length,
              progress: 0,
              color: ligthFaceBookColor,
              status: 0,
              subTasks: taskController.creatingSubTaskController
                  .map((e) => SubTask(id: 0, title: e.text.trim()))
                  .toList(),
              date: dateTime!))
          .then((e) {
        if (e) {
          taskController.creatingSubTaskController = [];
          context.pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        leading: IconButton.filled(
            style: IconButton.styleFrom(backgroundColor: lightGreyColor),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("This will discard this task!"),
                    actions: [
                      CupertinoButton(
                        child: Text("Cancel"),
                        onPressed: () => context.pop(),
                      ),
                      CupertinoButton(
                        child: Text("Proceed"),
                        onPressed: () {
                          context.goNamed(RouteNames.allTask);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            iconSize: 22,
            icon: const Icon(Icons.close).p4),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Tasks",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ).vP16,
              const SizedBox(
                height: 23,
              ),
              bottomBorderedField(
                hintText: "Task Title",
                controller: titleController,
              ),
              const SizedBox(
                height: 23,
              ),
              bottomBorderedField(
                hintText: dateTime?.year == null
                    ? 'Select Date'
                    : DateFormat('MMM dd, yyyy')
                        .format(dateTime ?? DateTime.now()),
                enabled: false,
                onTap: () {
                  _selectDate(context);
                },
              ),
              const SizedBox(
                height: 23,
              ),
              bottomBorderedField(
                  hintText: "Task Description",
                  maxLines: 6,
                  controller: descriptionController),
              const SizedBox(
                height: 30,
              ),
              GetBuilder<TaskController>(
                builder: (controller) =>
                    controller.creatingSubTaskController.isNotEmpty
                        ? Text(
                            "Sub Tasks",
                            style: Theme.of(context).textTheme.titleMedium,
                          ).vp(5)
                        : const SizedBox(),
              ),
              GetBuilder<TaskController>(
                builder: (controller) {
                  if (controller.creatingSubTaskController.isNotEmpty) {
                    return Column(
                      children: controller.creatingSubTaskController.map((e) {
                        int index =
                            controller.creatingSubTaskController.indexOf(e);
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            bottomBorderedField(
                                    hintText: "Sub-Task ${index + 1}",
                                    controller: controller
                                        .creatingSubTaskController[index])
                                .vP8
                                .paddingOnly(top: 17),
                            IconButton.outlined(
                                onPressed: () {
                                  controller.removeCreatingSubTask(index);
                                },
                                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)))),
                                icon: const Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.red,
                                )),
                          ],
                        );
                      }).toList(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Row(
                children: [
                  Text(
                    "Add subtasks",
                    style: Theme.of(context).textTheme.titleMedium,
                  ).rP8,
                  IconButton.outlined(
                    onPressed: () {
                      if (taskController.creatingSubTaskController.isEmpty) {
                        taskController.creatingSubTaskController = [
                          TextEditingController()
                        ];
                      } else {
                        taskController.creatingSubTaskController = [
                          ...taskController.creatingSubTaskController,
                          TextEditingController()
                        ];
                      }
                    },
                    icon: const Icon(Icons.add),
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              12), // Adjust the radius as needed
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.2,
              ),
            ],
          ).hP8,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: unselectedFilterChip),
        child: GetBuilder<TaskController>(
          builder: (controller) {
            if (controller.taskAddingStatus == TaskAddingStatus.success) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create Task",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2),
                  ).vP16,
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: whiteColor,
                ).vp(9),
              ],
            );
          },
        ),
      ).p(24).ripple(() {
        _addTask.call();
      }),
    );
  }

  Widget bottomBorderedField(
      {required String hintText,
      Function()? onTap,
      TextEditingController? controller,
      bool enabled = true,
      int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.9),
            blurStyle: BlurStyle.inner,
            offset: Offset.fromDirection(1, 7),
            blurRadius: 8,
          ),
        ],
      ),
      child: TextField(
        maxLines: maxLines,
        controller: controller,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          enabled: enabled,
          hintText: "| $hintText",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    ).ripple(() {
      if (!enabled) {
        onTap?.call();
      }
    });
  }
}
