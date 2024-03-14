class AppUpdate {
  final int versionNumber;
  final String versionString;
  final String titleSpanish;
  final String titleEnglish;
  final String descriptionSpanish;
  final String descriptionEnglish;
  final bool forcedRegular;
  final bool forcedOta;
  final double otaVersion;
  AppUpdate({
    required this.versionNumber,
    required this.versionString,
    required this.titleSpanish,
    required this.titleEnglish,
    required this.descriptionSpanish,
    required this.descriptionEnglish,
    required this.forcedRegular,
    required this.forcedOta,
    required this.otaVersion,
  });
}