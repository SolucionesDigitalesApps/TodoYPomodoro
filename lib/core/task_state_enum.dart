enum TaskState {pending, completed, deleted}

extension TaskStateExtension on TaskState {
  String get value {
    switch (this) {
      case TaskState.pending:
        return 'pending';
      case TaskState.completed:
        return 'completed';
      case TaskState.deleted:
        return 'deleted';
      default:
        return 'none';
    }
  }
}