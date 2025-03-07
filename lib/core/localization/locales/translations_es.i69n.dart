// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes
// GENERATED FILE, do not edit!
import 'package:i69n/i69n.dart' as i69n;
import 'translations.i69n.dart';

String get _languageCode => 'es';
String get _localeName => 'es';

String _plural(int count,
        {String? zero,
        String? one,
        String? two,
        String? few,
        String? many,
        String? other}) =>
    i69n.plural(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);
String _ordinal(int count,
        {String? zero,
        String? one,
        String? two,
        String? few,
        String? many,
        String? other}) =>
    i69n.ordinal(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);
String _cardinal(int count,
        {String? zero,
        String? one,
        String? two,
        String? few,
        String? many,
        String? other}) =>
    i69n.cardinal(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);

class Translations_es extends Translations {
  const Translations_es();
  GeneralTranslations_es get general => GeneralTranslations_es(this);
  ValidatorsTranslations_es get validators => ValidatorsTranslations_es(this);
  TimeTranslations_es get time => TimeTranslations_es(this);
  PagesTranslations_es get pages => PagesTranslations_es(this);
  WidgetsTranslations_es get widgets => WidgetsTranslations_es(this);
  UpdatesTranslations_es get updates => UpdatesTranslations_es(this);
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'general':
        return general;
      case 'validators':
        return validators;
      case 'time':
        return time;
      case 'pages':
        return pages;
      case 'widgets':
        return widgets;
      case 'updates':
        return updates;
      default:
        return super[key];
    }
  }
}

class GeneralTranslations_es extends GeneralTranslations {
  final Translations_es _parent;
  const GeneralTranslations_es(this._parent) : super(_parent);
  String get cancel => "Cancelar";
  String get accept => "Aceptar";
  String get close => "Cerrar";
  String get next => "Siguiente";
  String get error => "Ocurrió un error";
  String get dear => "Estimado usuario";
  String get disabled =>
      "Su cuenta se encuentra deshabilitada. Comuníquese con el administrador para más información";
  String get empty => "Sin resultados";
  String get create => "Crear";
  String get tasks => "Tareas y Pomodoro";
  String get edit => "Editar";
  String get update => "Actualizar";
  String get notNow => "Ahora no";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'cancel':
        return cancel;
      case 'accept':
        return accept;
      case 'close':
        return close;
      case 'next':
        return next;
      case 'error':
        return error;
      case 'dear':
        return dear;
      case 'disabled':
        return disabled;
      case 'empty':
        return empty;
      case 'create':
        return create;
      case 'tasks':
        return tasks;
      case 'edit':
        return edit;
      case 'update':
        return update;
      case 'notNow':
        return notNow;
      default:
        return super[key];
    }
  }
}

class ValidatorsTranslations_es extends ValidatorsTranslations {
  final Translations_es _parent;
  const ValidatorsTranslations_es(this._parent) : super(_parent);
  String get invalidEmail => "El correo electrónico no es válido";
  String get invalidPassword => "La contraseña no es válida";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'invalidEmail':
        return invalidEmail;
      case 'invalidPassword':
        return invalidPassword;
      default:
        return super[key];
    }
  }
}

class TimeTranslations_es extends TimeTranslations {
  final Translations_es _parent;
  const TimeTranslations_es(this._parent) : super(_parent);
  String get minute => "minuto";
  String get minutes => "minutos";
  String get hour => "hora";
  String get hours => "horas";
  String get day => "día";
  String get days => "días";
  String get and => " y ";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'minute':
        return minute;
      case 'minutes':
        return minutes;
      case 'hour':
        return hour;
      case 'hours':
        return hours;
      case 'day':
        return day;
      case 'days':
        return days;
      case 'and':
        return and;
      default:
        return super[key];
    }
  }
}

class PagesTranslations_es extends PagesTranslations {
  final Translations_es _parent;
  const PagesTranslations_es(this._parent) : super(_parent);
  SignInPagesTranslations_es get signIn => SignInPagesTranslations_es(this);
  SignUpPagesTranslations_es get signUp => SignUpPagesTranslations_es(this);
  RecoverPagesTranslations_es get recover => RecoverPagesTranslations_es(this);
  TaskHomePagesTranslations_es get taskHome =>
      TaskHomePagesTranslations_es(this);
  TasksArchivedPagesTranslations_es get tasksArchived =>
      TasksArchivedPagesTranslations_es(this);
  LanguageSheetPagesTranslations_es get languageSheet =>
      LanguageSheetPagesTranslations_es(this);
  PomodoroPagesTranslations_es get pomodoro =>
      PomodoroPagesTranslations_es(this);
  CreateTaskGroupSheetPagesTranslations_es get createTaskGroupSheet =>
      CreateTaskGroupSheetPagesTranslations_es(this);
  CreateTaskSheetPagesTranslations_es get createTaskSheet =>
      CreateTaskSheetPagesTranslations_es(this);
  OnboardingPagesTranslations_es get onboarding =>
      OnboardingPagesTranslations_es(this);
  UpdateTaskGroupSheetPagesTranslations_es get updateTaskGroupSheet =>
      UpdateTaskGroupSheetPagesTranslations_es(this);
  UpdateTaskSheetPagesTranslations_es get updateTaskSheet =>
      UpdateTaskSheetPagesTranslations_es(this);
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'signIn':
        return signIn;
      case 'signUp':
        return signUp;
      case 'recover':
        return recover;
      case 'taskHome':
        return taskHome;
      case 'tasksArchived':
        return tasksArchived;
      case 'languageSheet':
        return languageSheet;
      case 'pomodoro':
        return pomodoro;
      case 'createTaskGroupSheet':
        return createTaskGroupSheet;
      case 'createTaskSheet':
        return createTaskSheet;
      case 'onboarding':
        return onboarding;
      case 'updateTaskGroupSheet':
        return updateTaskGroupSheet;
      case 'updateTaskSheet':
        return updateTaskSheet;
      default:
        return super[key];
    }
  }
}

class SignInPagesTranslations_es extends SignInPagesTranslations {
  final PagesTranslations_es _parent;
  const SignInPagesTranslations_es(this._parent) : super(_parent);
  String get emailLabel => "Correo electrónico";
  String get passwordLabel => "Contraseña";
  String get forgetAccount => "¿Olvidaste tu contraseña?";
  String get signIn => "Iniciar sesión";
  String get signUp => "Crear cuenta";
  String get signingin => "Iniciando sesión...";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'emailLabel':
        return emailLabel;
      case 'passwordLabel':
        return passwordLabel;
      case 'forgetAccount':
        return forgetAccount;
      case 'signIn':
        return signIn;
      case 'signUp':
        return signUp;
      case 'signingin':
        return signingin;
      default:
        return super[key];
    }
  }
}

class SignUpPagesTranslations_es extends SignUpPagesTranslations {
  final PagesTranslations_es _parent;
  const SignUpPagesTranslations_es(this._parent) : super(_parent);
  String get title => "Crear cuenta";
  String get emailLabel => "Correo electrónico";
  String get passwordLabel => "Contraseña";
  String get signUp => "Crear cuenta";
  String get sigupingup => "Creando cuenta...";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'title':
        return title;
      case 'emailLabel':
        return emailLabel;
      case 'passwordLabel':
        return passwordLabel;
      case 'signUp':
        return signUp;
      case 'sigupingup':
        return sigupingup;
      default:
        return super[key];
    }
  }
}

class RecoverPagesTranslations_es extends RecoverPagesTranslations {
  final PagesTranslations_es _parent;
  const RecoverPagesTranslations_es(this._parent) : super(_parent);
  String get title => "Recuperar contraseña";
  String get emailLabel => "Correo electrónico";
  String get send => "Enviar correo";
  String get sending => "Enviando correo...";
  String get sentSuccess =>
      "Se ha enviado un correo a su dirección de correo electrónico";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'title':
        return title;
      case 'emailLabel':
        return emailLabel;
      case 'send':
        return send;
      case 'sending':
        return sending;
      case 'sentSuccess':
        return sentSuccess;
      default:
        return super[key];
    }
  }
}

class TaskHomePagesTranslations_es extends TaskHomePagesTranslations {
  final PagesTranslations_es _parent;
  const TaskHomePagesTranslations_es(this._parent) : super(_parent);
  String get updatingTasks => "Actualizando tareas...";
  String get newTask => "Nueva tarea";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'updatingTasks':
        return updatingTasks;
      case 'newTask':
        return newTask;
      default:
        return super[key];
    }
  }
}

class TasksArchivedPagesTranslations_es extends TasksArchivedPagesTranslations {
  final PagesTranslations_es _parent;
  const TasksArchivedPagesTranslations_es(this._parent) : super(_parent);
  String get title => "Tareas completadas";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'title':
        return title;
      default:
        return super[key];
    }
  }
}

class LanguageSheetPagesTranslations_es extends LanguageSheetPagesTranslations {
  final PagesTranslations_es _parent;
  const LanguageSheetPagesTranslations_es(this._parent) : super(_parent);
  String get title => "Seleccione lenguaje";
  String get spanish => "Español";
  String get english => "Inglés";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'title':
        return title;
      case 'spanish':
        return spanish;
      case 'english':
        return english;
      default:
        return super[key];
    }
  }
}

class PomodoroPagesTranslations_es extends PomodoroPagesTranslations {
  final PagesTranslations_es _parent;
  const PomodoroPagesTranslations_es(this._parent) : super(_parent);
  String get title => "Pomodoro";
  String get finished => "La tarea ha finalizado";
  String get focus => "Mantente enfocado por";
  String get completing => "Completando tarea";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'title':
        return title;
      case 'finished':
        return finished;
      case 'focus':
        return focus;
      case 'completing':
        return completing;
      default:
        return super[key];
    }
  }
}

class CreateTaskGroupSheetPagesTranslations_es
    extends CreateTaskGroupSheetPagesTranslations {
  final PagesTranslations_es _parent;
  const CreateTaskGroupSheetPagesTranslations_es(this._parent) : super(_parent);
  String get title => "Nuevo grupo de tareas";
  String get labelInput => "Ingrese el nombre del grupo";
  String get labelNotEmpty => "El nombre del grupo no puede estar vacío";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'title':
        return title;
      case 'labelInput':
        return labelInput;
      case 'labelNotEmpty':
        return labelNotEmpty;
      default:
        return super[key];
    }
  }
}

class CreateTaskSheetPagesTranslations_es
    extends CreateTaskSheetPagesTranslations {
  final PagesTranslations_es _parent;
  const CreateTaskSheetPagesTranslations_es(this._parent) : super(_parent);
  String get title => "Crear tarea";
  String get titleInput => "Título de la tarea";
  String get descriptionInput => "Descripción de la tarea (Opcional)";
  String get pomodoroInput => "Agregar pomodoro (Opcional)";
  String get selectTime => "Seleccione tiempo";
  String get titleNotEmpty => "El título de la tarea no puede estar vacío";
  String get create => "Crear tarea";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'title':
        return title;
      case 'titleInput':
        return titleInput;
      case 'descriptionInput':
        return descriptionInput;
      case 'pomodoroInput':
        return pomodoroInput;
      case 'selectTime':
        return selectTime;
      case 'titleNotEmpty':
        return titleNotEmpty;
      case 'create':
        return create;
      default:
        return super[key];
    }
  }
}

class OnboardingPagesTranslations_es extends OnboardingPagesTranslations {
  final PagesTranslations_es _parent;
  const OnboardingPagesTranslations_es(this._parent) : super(_parent);
  String get title => "Tareas y Pomodoro";
  String get description => "Organiza tus tareas y complétalas sencillamente";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'title':
        return title;
      case 'description':
        return description;
      default:
        return super[key];
    }
  }
}

class UpdateTaskGroupSheetPagesTranslations_es
    extends UpdateTaskGroupSheetPagesTranslations {
  final PagesTranslations_es _parent;
  const UpdateTaskGroupSheetPagesTranslations_es(this._parent) : super(_parent);
  String get title => "Editar grupo de tareas";
  String get nameInput => "Ingrese el nombre del grupo";
  String get nameNotEmpty => "El nombre del grupo no puede estar vacío";
  String get delete => "Eliminar grupo";
  String get cantDelete =>
      "No se puede eliminar el grupo porque tiene tareas relacionadas";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'title':
        return title;
      case 'nameInput':
        return nameInput;
      case 'nameNotEmpty':
        return nameNotEmpty;
      case 'delete':
        return delete;
      case 'cantDelete':
        return cantDelete;
      default:
        return super[key];
    }
  }
}

class UpdateTaskSheetPagesTranslations_es
    extends UpdateTaskSheetPagesTranslations {
  final PagesTranslations_es _parent;
  const UpdateTaskSheetPagesTranslations_es(this._parent) : super(_parent);
  String get title => "Editar tarea";
  String get titleInput => "Título de la tarea";
  String get descriptionInput => "Descripción de la tarea (Opcional)";
  String get pomodoroInput => "Agregar pomodoro (Opcional)";
  String get selectTime => "Seleccione tiempo";
  String get titleNotEmpty => "El título de la tarea no puede estar vacío";
  String get update => "Editar tarea";
  String get delete => "Eliminar tarea";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'title':
        return title;
      case 'titleInput':
        return titleInput;
      case 'descriptionInput':
        return descriptionInput;
      case 'pomodoroInput':
        return pomodoroInput;
      case 'selectTime':
        return selectTime;
      case 'titleNotEmpty':
        return titleNotEmpty;
      case 'update':
        return update;
      case 'delete':
        return delete;
      default:
        return super[key];
    }
  }
}

class WidgetsTranslations_es extends WidgetsTranslations {
  final Translations_es _parent;
  const WidgetsTranslations_es(this._parent) : super(_parent);
  TaskGroupListWidgetsTranslations_es get taskGroupList =>
      TaskGroupListWidgetsTranslations_es(this);
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'taskGroupList':
        return taskGroupList;
      default:
        return super[key];
    }
  }
}

class TaskGroupListWidgetsTranslations_es
    extends TaskGroupListWidgetsTranslations {
  final WidgetsTranslations_es _parent;
  const TaskGroupListWidgetsTranslations_es(this._parent) : super(_parent);
  String get alert1 => "Solo se pueden crear hasta";
  String get alert2 => "grupos de tareas";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'alert1':
        return alert1;
      case 'alert2':
        return alert2;
      default:
        return super[key];
    }
  }
}

class UpdatesTranslations_es extends UpdatesTranslations {
  final Translations_es _parent;
  const UpdatesTranslations_es(this._parent) : super(_parent);
  String get must1 => "Debe ir a";
  String get must2 => "manualmente";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i69n.I69nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'must1':
        return must1;
      case 'must2':
        return must2;
      default:
        return super[key];
    }
  }
}
