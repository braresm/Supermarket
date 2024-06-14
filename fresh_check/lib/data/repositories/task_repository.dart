import 'package:fresh_check/domain/models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> listAccountTasks(int accountId, DateTime deadline);
  Future<void> completeTask(Task task);
}
