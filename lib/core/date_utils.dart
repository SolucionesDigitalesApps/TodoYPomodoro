String formatDuration(Duration duration) {
  final hours = duration.inHours.remainder(24);
  final minutes = duration.inMinutes.remainder(60);
  final formattedHours = hours > 0? '$hours hour' : '';
  final formattedMinutes = minutes > 0? '$minutes minute' : '';
  return [formattedHours, formattedMinutes]
     .where((element) => element.isNotEmpty)
     .join(' and ');
}