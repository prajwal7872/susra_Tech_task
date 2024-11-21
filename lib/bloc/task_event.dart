
import 'package:equatable/equatable.dart';
import 'package:susra_task/task.dart';


// Task Events
abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;
  AddTask(this.task);

  @override
  List<Object?> get props => [task];
}

class RemoveTask extends TaskEvent {
  final String taskId;
  RemoveTask(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class ToggleTaskCompletion extends TaskEvent {
  final String taskId;
  ToggleTaskCompletion(this.taskId);

  @override
  List<Object?> get props => [taskId];
}
}
