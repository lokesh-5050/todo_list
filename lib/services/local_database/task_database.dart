import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo/src/models/task_model.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();

  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    debugPrint('Database :::: ${_database?.isOpen}');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      numberOfTasks INTEGER NOT NULL,
      progress REAL NOT NULL,
      color TEXT NOT NULL,
      status TEXT NOT NULL,
      date TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE sub_tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      isCompleted INTEGER NOT NULL,
      taskId INTEGER NOT NULL,
      FOREIGN KEY (taskId) REFERENCES tasks (id) ON DELETE CASCADE
    )
    ''');
  }

  // CRUD operations for Tasks

  Future<int> createTask(Task task) async {
    final db = await instance.database;

    // Insert main task without subTasks
    final taskId = await db.insert('tasks', task.toMap()..remove('subTasks'));

    // Insert subTasks separately in the sub_tasks table
    for (var subTask in task.subTasks) {
      await createSubTask(subTask, taskId);
    }

    return taskId;
  }

  Future<Task?> readTask(int id) async {
    final db = await instance.database;

    // Fetch the task
    final taskMaps = await db.query(
      'tasks',
      columns: [
        'id',
        'title',
        'description',
        'numberOfTasks',
        'progress',
        'color',
        'status',
        'date' // Include date column
      ],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (taskMaps.isNotEmpty) {
      // Convert the task map to a Task object
      Task task = Task.fromMap(taskMaps.first);

      // Fetch subtasks for the current task
      List<SubTask> subtasks = await readSubTasks(task.id!);

      // Attach subtasks to the task
      task = task.copyWith(subTasks: subtasks);

      return task;
    } else {
      return null;
    }
  }

  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;

    // Fetch all tasks
    final taskResult = await db.query('tasks');

    // Create a list to hold the tasks with their associated subtasks
    List<Task> tasks = [];

    for (var taskMap in taskResult) {
      // Convert task map to Task object
      Task task = Task.fromMap(taskMap);

      // Fetch subtasks for the current task
      List<SubTask> subtasks = await readSubTasks(task.id!);

      // Attach subtasks to the task
      task = task.copyWith(subTasks: subtasks);

      // Add the task with its subtasks to the list
      tasks.add(task);
    }

    return tasks;
  }

  Future<int> updateTask(Task task) async {
    final db = await instance.database;

    return await db.update(
      'tasks',
      task.toMap()..remove('subTasks'),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;

    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CRUD operations for SubTasks

  Future<int> createSubTask(SubTask subTask, int taskId) async {
    final db = await instance.database;
    return await db.insert('sub_tasks', {
      'title': subTask.title,
      'isCompleted': subTask.isCompleted ? 1 : 0,
      'taskId': taskId,
    });
  }

  Future<List<SubTask>> readSubTasks(int taskId) async {
    final db = await instance.database;

    final result = await db.query(
      'sub_tasks',
      where: 'taskId = ?',
      whereArgs: [taskId],
    );

    return result.map((json) => SubTask.fromMap(json)).toList();
  }

  Future<int> updateSubTask(SubTask subTask) async {
    final db = await instance.database;

    return await db.update(
      'sub_tasks',
      {
        'title': subTask.title,
        'isCompleted': subTask.isCompleted ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [subTask.id],
    );
  }

  Future<int> deleteSubTask(int id) async {
    final db = await instance.database;

    return await db.delete(
      'sub_tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
