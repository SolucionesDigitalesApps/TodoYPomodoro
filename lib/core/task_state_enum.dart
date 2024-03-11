enum TaskState {pending, completed, deleted}

extension TaskStateExtension on TaskState {
  String get value {
    switch (this) {
      case TaskState.pending:
        return 'Pendiente';
      case TaskState.completed:
        return 'Completado';
      case TaskState.deleted:
        return 'Eliminado';
      default:
        return 'none';
    }
  }
}