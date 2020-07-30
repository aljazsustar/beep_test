class Level {
  num level;
  num shuttles;
  num runningSpeed;
  num timePerShuttle;
  num totalLevelTime;
  num levelDistance;
  num totalDistance;

  Level.fromJson(Map jsonMap)
  : level = jsonMap['level'],
    shuttles = jsonMap['shuttles'],
    runningSpeed = jsonMap['running_speed'] as num,
    timePerShuttle = jsonMap['time_per_shuttle'] as num,
    totalLevelTime = jsonMap['total_level_time'] as num,
    levelDistance = jsonMap['level_distance'],
    totalDistance = jsonMap['total_distance'];
}