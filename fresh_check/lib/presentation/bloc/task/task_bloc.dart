import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_check/domain/usecases/complete_task.dart';
import 'package:fresh_check/presentation/bloc/task/task_event.dart';
import 'package:fresh_check/presentation/bloc/task/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final CompleteTaskUseCase completeTaskUseCase;

  TaskBloc({required this.completeTaskUseCase}) : super(TaskInitial()) {
    on<CompleteTask>(_onCompleteTask);
  }

  Future<void> _onCompleteTask(
      CompleteTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await completeTaskUseCase(event.task);

      emit(TaskCompleted());
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
