import 'package:fresh_check/data/repositories/task_repository.dart';
import 'package:fresh_check/domain/models/task.dart';

class CompleteTaskUseCase {
  final TaskRepository repository;

  CompleteTaskUseCase(this.repository);

  Future<void> call(Task task) async {
    await repository.completeTask(task);
  }
}
