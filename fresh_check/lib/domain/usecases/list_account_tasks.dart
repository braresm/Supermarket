import 'package:fresh_check/data/repositories/task_repository.dart';
import 'package:fresh_check/domain/models/task.dart';

class ListAccountTasksUseCase {
  final TaskRepository repository;

  ListAccountTasksUseCase(this.repository);

  Future<List<Task>> call(int accountId) async {
    DateTime deadline = DateTime.now();
    return repository.listAccountTasks(accountId, deadline);
  }
}
