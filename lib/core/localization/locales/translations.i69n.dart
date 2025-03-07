// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes
// GENERATED FILE, do not edit!
import 'package:i69n/i69n.dart' as i69n;

String get _languageCode => 'en';
String get _localeName => 'en';

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

class Translations implements i69n.I69nMessageBundle {
  const Translations();
  GeneralTranslations get general => GeneralTranslations(this);
  ValidatorsTranslations get validators => ValidatorsTranslations(this);
  TimeTranslations get time => TimeTranslations(this);
  PagesTranslations get pages => PagesTranslations(this);
  WidgetsTranslations get widgets => WidgetsTranslations(this);
  UpdatesTranslations get updates => UpdatesTranslations(this);
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
        return key;
    }
  }
}

class GeneralTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const GeneralTranslations(this._parent);
  String get cancel => "Cancel";
  String get accept => "Accept";
  String get close => "Close";
  String get next => "Next";
  String get error => "Error";
  String get dear => "Dear user";
  String get disabled =>
      "Your account is disabled. Please contact the administrator for more information";
  String get empty => "No results";
  String get create => "Create";
  String get tasks => "Tasks";
  String get edit => "Edit";
  String get update => "Update";
  String get notNow => "Not now";
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
        return key;
    }
  }
}

class ValidatorsTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const ValidatorsTranslations(this._parent);
  String get invalidEmail => "Invalid email";
  String get invalidPassword => "Invalid password";
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
        return key;
    }
  }
}

class TimeTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const TimeTranslations(this._parent);
  String get minute => "minute";
  String get minutes => "minutes";
  String get hour => "hour";
  String get hours => "hours";
  String get day => "day";
  String get days => "days";
  String get and => "and";
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
        return key;
    }
  }
}

class PagesTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const PagesTranslations(this._parent);
  SignInPagesTranslations get signIn => SignInPagesTranslations(this);
  SignUpPagesTranslations get signUp => SignUpPagesTranslations(this);
  RecoverPagesTranslations get recover => RecoverPagesTranslations(this);
  TaskHomePagesTranslations get taskHome => TaskHomePagesTranslations(this);
  TasksArchivedPagesTranslations get tasksArchived =>
      TasksArchivedPagesTranslations(this);
  LanguageSheetPagesTranslations get languageSheet =>
      LanguageSheetPagesTranslations(this);
  PomodoroPagesTranslations get pomodoro => PomodoroPagesTranslations(this);
  CreateTaskGroupSheetPagesTranslations get createTaskGroupSheet =>
      CreateTaskGroupSheetPagesTranslations(this);
  CreateTaskSheetPagesTranslations get createTaskSheet =>
      CreateTaskSheetPagesTranslations(this);
  OnboardingPagesTranslations get onboarding =>
      OnboardingPagesTranslations(this);
  UpdateTaskGroupSheetPagesTranslations get updateTaskGroupSheet =>
      UpdateTaskGroupSheetPagesTranslations(this);
  UpdateTaskSheetPagesTranslations get updateTaskSheet =>
      UpdateTaskSheetPagesTranslations(this);
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
        return key;
    }
  }
}

class SignInPagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const SignInPagesTranslations(this._parent);
  String get emailLabel => "Email";
  String get passwordLabel => "Password";
  String get forgetAccount => "Forgot your password?";
  String get signIn => "Sign In";
  String get signUp => "Create Account";
  String get signingIn => "Signing in...";
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
      case 'signingIn':
        return signingIn;
      default:
        return key;
    }
  }
}

class SignUpPagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const SignUpPagesTranslations(this._parent);
  String get title => "Create Account";
  String get emailLabel => "Email";
  String get passwordLabel => "Password";
  String get signUp => "Sign Up";
  String get signingUp => "Creating account...";
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
      case 'signingUp':
        return signingUp;
      default:
        return key;
    }
  }
}

class RecoverPagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const RecoverPagesTranslations(this._parent);
  String get title => "Recover Password";
  String get emailLabel => "Email";
  String get send => "Send Email";
  String get sending => "Sending email...";
  String get sentSuccess => "An email has been sent to your email address";
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
        return key;
    }
  }
}

class TaskHomePagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const TaskHomePagesTranslations(this._parent);
  String get updatingTasks => "Updating tasks...";
  String get newTask => "New task";
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
        return key;
    }
  }
}

class TasksArchivedPagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const TasksArchivedPagesTranslations(this._parent);
  String get title => "Archived Tasks";
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
        return key;
    }
  }
}

class LanguageSheetPagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const LanguageSheetPagesTranslations(this._parent);
  String get title => "Select Language";
  String get spanish => "Spanish";
  String get english => "English";
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
        return key;
    }
  }
}

class PomodoroPagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const PomodoroPagesTranslations(this._parent);
  String get title => "Pomodoro";
  String get finished => "Task finished";
  String get focus => "Stay focused for";
  String get completing => "Completing task...";
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
        return key;
    }
  }
}

class CreateTaskGroupSheetPagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const CreateTaskGroupSheetPagesTranslations(this._parent);
  String get title => "New Task Group";
  String get labelInput => "Enter group name";
  String get labelNotEmpty => "Group name cannot be empty";
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
        return key;
    }
  }
}

class CreateTaskSheetPagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const CreateTaskSheetPagesTranslations(this._parent);
  String get title => "Create Task";
  String get titleInput => "Task title";
  String get descriptionInput => "Task description (Optional)";
  String get pomodoroInput => "Add pomodoro (Optional)";
  String get selectTime => "Select time";
  String get titleNotEmpty => "Task title cannot be empty";
  String get create => "Create Task";
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
        return key;
    }
  }
}

class OnboardingPagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const OnboardingPagesTranslations(this._parent);
  String get title => "Tasks and Pomodoro";
  String get description => "Organize your tasks and complete them easily";
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
        return key;
    }
  }
}

class UpdateTaskGroupSheetPagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const UpdateTaskGroupSheetPagesTranslations(this._parent);
  String get title => "Edit Task Group";
  String get nameInput => "Enter group name";
  String get nameNotEmpty => "Group name cannot be empty";
  String get delete => "Delete Group";
  String get cantDelete => "Cannot delete group because it has related tasks";
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
        return key;
    }
  }
}

class UpdateTaskSheetPagesTranslations implements i69n.I69nMessageBundle {
  final PagesTranslations _parent;
  const UpdateTaskSheetPagesTranslations(this._parent);
  String get title => "Edit Task";
  String get titleInput => "Task title";
  String get descriptionInput => "Task description (Optional)";
  String get pomodoroInput => "Add pomodoro (Optional)";
  String get selectTime => "Select time";
  String get titleNotEmpty => "Task title cannot be empty";
  String get update => "Update Task";
  String get delete => "Delete Task";
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
        return key;
    }
  }
}

class WidgetsTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const WidgetsTranslations(this._parent);
  TaskGroupListWidgetsTranslations get taskGroupList =>
      TaskGroupListWidgetsTranslations(this);
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
        return key;
    }
  }
}

class TaskGroupListWidgetsTranslations implements i69n.I69nMessageBundle {
  final WidgetsTranslations _parent;
  const TaskGroupListWidgetsTranslations(this._parent);
  String get alert1 => "Only";
  String get alert2 => "task groups";
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
        return key;
    }
  }
}

class UpdatesTranslations implements i69n.I69nMessageBundle {
  final Translations _parent;
  const UpdatesTranslations(this._parent);
  String get must1 => "Should go";
  String get must2 => "manually";
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
        return key;
    }
  }
}
