String formatDuration(Duration duration) {
  final hours = duration.inHours.remainder(24);
  final minutes = duration.inMinutes.remainder(60);
  final formattedHours = hours > 0? '$hours hour' : '';
  final formattedMinutes = minutes > 0? '$minutes minute' : '';
  return [formattedHours, formattedMinutes]
     .where((element) => element.isNotEmpty)
     .join(' and ');
}
//Create a function to convert int seconds to string like "25 minutes"
String formatSeconds(int seconds) {
  if (seconds < 60) {
    return '$seconds seconds';
  } else {
    int minutes = seconds ~/ 60;
    if (minutes < 60) {
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'}';
    } else {
      int hours = minutes ~/ 60;
      if (hours < 24) {
        return '$hours ${hours == 1 ? 'hour' : 'hours'}';
      } else {
        int days = hours ~/ 24;
        return '$days ${days == 1 ? 'day' : 'days'}';
      }
    }
  }
}