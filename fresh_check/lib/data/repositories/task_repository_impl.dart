import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:fresh_check/data/repositories/task_repository.dart';
import 'package:fresh_check/domain/models/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl();

  /// Get a list of tasks for an account with deadline
  @override
  Future<List<Task>> listAccountTasks(int accountId, DateTime deadline) async {
    String formattedDeadline = DateFormat('yyyy-MM-dd').format(deadline);

    final response = await Supabase.instance.client
        .from('tasks')
        .select()
        .eq('user_id', accountId)
        .eq('deadline', formattedDeadline);

    return response.map((task) {
      return Task(
        id: task['id'],
        title: task['task_title'],
        categoty: task['category'],
        completed: task['completed'],
      );
    }).toList();
  }

  /// Mark a task as completed or uncompleted
  @override
  Future<void> completeTask(Task task) async {
    await Supabase.instance.client.from('tasks').update({
      'completed': task.completed,
    }).eq('id', task.id);
  }
}
