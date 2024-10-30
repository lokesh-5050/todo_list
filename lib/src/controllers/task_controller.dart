import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/services/local_database/task_database.dart';
import 'package:todo/src/models/task_model.dart';

enum TaskAddingStatus { loading, failed, success }

class TaskController extends GetxController {
  List<Task> allTasks = <Task>[];

  List<TextEditingController> _creatingSubTaskController =
      <TextEditingController>[];

  List<TextEditingController> get creatingSubTaskController =>
      _creatingSubTaskController;

  set creatingSubTaskController(List<TextEditingController> data) {
    _creatingSubTaskController = data;
    update();
  }

  TaskAddingStatus _taskAddingStatus = TaskAddingStatus.success;

  TaskAddingStatus get taskAddingStatus => _taskAddingStatus;

  set taskAddingStatus(TaskAddingStatus status) {
    _taskAddingStatus = status;
  }

  void removeCreatingSubTask(int index) {
    _creatingSubTaskController.removeAt(index);
    update();
  }

  void updateTaskStatus(int taskId, int status) async {
    // Find the task with the matching taskId
    List<Task> list = allTasks.where((e) => e.id == taskId).toList();

    if (list.isNotEmpty) {
      // if not empty then take the first one [0]
      Task taskToUpdate = list.first;

      //  copy of the task with the new status
      Task updatedTask = taskToUpdate.copyWith(status: status);

      // update the task in the database
      await TaskDatabase.instance.updateTask(updatedTask);

      // update the,task in the allTasks list
      int index = allTasks.indexWhere((e) => e.id == taskId);
      if (index != -1) {
        allTasks[index] = updatedTask;
      }

      update();
    }
  }

  void getAllTasks() async {
    List<Task> tasks = await TaskDatabase.instance.readAllTasks();
    debugPrint('Tasks Retrived from ldb  :${tasks.length}');
    allTasks.assignAll(tasks.reversed);
    update();
  }

  Future<bool> addTask(Task task) async {
    try {
      int taskId = await TaskDatabase.instance.createTask(task);

      if (taskId > 0) {
        Task createdTask = task.copyWith(id: taskId);

        allTasks.insert(0, createdTask);
        update();

        debugPrint('Task Added: ${createdTask.title}');
        taskAddingStatus = TaskAddingStatus.success;
        return true;
      } else {
        taskAddingStatus = TaskAddingStatus.failed;
        return false;
      }
    } catch (e) {
      debugPrint('Failed to add task: $e');
      taskAddingStatus = TaskAddingStatus.failed;
      return false;
    }
  }

  void deleteTask(int taskId) async {
    await TaskDatabase.instance.deleteTask(taskId);

    allTasks.removeWhere((task) => task.id == taskId);

    update();
  }
}
