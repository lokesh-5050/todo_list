import 'dart:convert';

import 'package:flutter/material.dart';

enum TaskStatus {
  ongoing, //0
  inProcess, //1
  completed, //2
  canceled, //3
}

class Task {
  final int? id;
  final String title;
  final String description;
  final int numberOfTasks;
  final double progress;
  final Color color;
  final int status;
  final List<SubTask> subTasks;
  final DateTime date;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'numberOfTasks': numberOfTasks,
      'progress': progress,
      'color': color.value,
      'status': status,
      'subTasks':
          jsonEncode(subTasks.map((subTask) => subTask.toMap()).toList()),
      'date': date.toIso8601String(), // Convert DateTime to String for storage
    };
  }

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.numberOfTasks,
    required this.progress,
    required this.color,
    required this.status,
    required this.subTasks,
    required this.date,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      numberOfTasks: map['numberOfTasks'] as int,
      progress: (map['progress'] as num).toDouble(),
      color: Color(int.parse(map['color'].toString())),
      // Convert color to int if stored as string
      status: int.parse(map['status'].toString()),
      // Ensure status is parsed as integer
      subTasks: map['subTasks'] != null
          ? (jsonDecode(map['subTasks']) as List)
              .map((subTask) => SubTask.fromMap(subTask))
              .toList()
          : [],
      date: DateTime.parse(map['date'] as String),
    );
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    int? numberOfTasks,
    double? progress,
    Color? color,
    int? status,
    List<SubTask>? subTasks,
    DateTime? date,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      numberOfTasks: numberOfTasks ?? this.numberOfTasks,
      progress: progress ?? this.progress,
      color: color ?? this.color,
      status: status ?? this.status,
      subTasks: subTasks ?? this.subTasks,
      date: date ?? this.date,
    );
  }
}

class SubTask {
  final int id;
  final String title;
  final bool isCompleted;

  SubTask({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
