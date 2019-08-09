// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:wedding_planner/model/task_model.dart';

class ApiTaskService {
  final String baseUrl = "https://us-central1-wedding-planner-64948.cloudfunctions.net/v1/";
  
  Dio dio = new Dio();
  Response response;

//  Future<List<Task>> getTasks() async {
//    response = await dio.get("$baseUrl/tasks?user_id=8lrVGc7Y1HO1qw7xQg5tilJ7faQ2");
//     if (response.statusCode == 200) {
//       return taskFromJson(response.data.toString());
//     } else {
//       return null;
//     }
//  }

Future<bool> createTask(Task data) async {
    final response = await dio.post(
      "$baseUrl/tasks",
      // headers: {"content-type": "application/json"},
      data: taskToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

 Future<bool> updateTask(Task data) async {
    final response = await dio.put(
      "$baseUrl/tasks/${data.id}",
      // headers: {"content-type": "application/json"},
      data: taskToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

   Future<bool> deleteTask(String id) async {
    final response = await dio.delete(
      "$baseUrl/task/$id",
      // headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}