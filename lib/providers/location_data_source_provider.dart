import 'package:background_location_app/model/location.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart' as loc;

import 'sqlite_provider.dart';

final locationDataSourceProvider = ChangeNotifierProvider<LocationDataSource>((ref) {
  return LocationDataSource(ref);
});

class LocationDataSource extends ChangeNotifier {
  LocationDataSource(this.ref) {
    sqlite.init();
  }

  final ChangeNotifierProviderRef<LocationDataSource> ref;
  static const tableName = 'Locations';
  late final sqlite = ref.read(sqliteProvider);

  Future<void> add(loc.LocationData data) async {
    final now = DateTime.now();
    await sqlite.insert(
      tableName,
      {
        'id': now.millisecondsSinceEpoch.toString(),
        'lat': data.latitude,
        'lon': data.longitude,
        'timestamp': now.millisecondsSinceEpoch,
      },
    );
  }

  Future<List<Location>> fetch() async {
    final data = await sqlite.fetch(tableName);
    return data.map(Location.fromJson).toList();
  }

  Future<void> delete() async {
    await sqlite.delete(tableName);
  }
}
