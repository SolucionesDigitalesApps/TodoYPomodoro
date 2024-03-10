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
  final minutes = seconds.remainder(60);
  final formattedMinutes = minutes > 0? '$minutes minute' : '';
  return formattedMinutes;
}