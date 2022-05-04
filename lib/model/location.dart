class Location {
  Location._(
    this.id,
    this.lat,
    this.lon,
    this.timestamp,
  );

  factory Location.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final lat = json['lat'] as double;
    final lon = json['lon'] as double;
    final timestamp = json['timestamp'] as int;
    final datetime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    return Location._(id, lat, lon, datetime);
  }

  final String id;
  final double lat;
  final double lon;
  final DateTime timestamp;
}
