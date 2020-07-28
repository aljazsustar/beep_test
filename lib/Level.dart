class Level {
  String level;
  String shuttles;
  String runningSpeed;
  String timePerShuttle;
  String totalLevelTime;
  String levelDistance;

  Level.fromJson(Map jsonMap)
  : level = jsonMap['level'],
    shuttles = jsonMap['shuttles'],
    runningSpeed = jsonMap['running_speed'],
    timePerShuttle = jsonMap['time_per_shuttle'],
    totalLevelTime = jsonMap['total_level_time'],
    levelDistance = jsonMap['level_distance'];
}