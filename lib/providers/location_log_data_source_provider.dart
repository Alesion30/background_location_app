import 'dart:async';

import 'package:background_location_app/model/location_log.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';

import 'sqlite_provider.dart';

final locationLogDataSourceProvider =
    ChangeNotifierProvider<LocationLogDataSource>((ref) {
  return LocationLogDataSource(ref);
});

class LocationLogDataSource extends ChangeNotifier {
  LocationLogDataSource(this.ref) {
    sqlite.init();
  }

  final ChangeNotifierProviderRef<LocationLogDataSource> ref;
  final streamController = StreamController<List<LocationLog>>();
  static const tableName = 'Locations';
  late final sqlite = ref.read(sqliteProvider);

  Future<void> add(LocationData data) async {
    final now = DateTime.now();
    final json = {
      'id': now.millisecondsSinceEpoch.toString(),
      'lat': data.latitude,
      'lon': data.longitude,
      'timestamp': now.millisecondsSinceEpoch,
    };
    await sqlite.insert(
      tableName,
      json,
    );
    final locations = await fetch();
    streamController.sink.add(locations);
  }

  Future<List<LocationLog>> fetch() async {
    final data = await sqlite.fetch(tableName);
    return data.map(LocationLog.fromJson).toList();
  }

  Stream<List<LocationLog>> stream() {
    return streamController.stream;
  }

  Future<void> delete() async {
    await sqlite.delete(tableName);
    streamController.sink.add([]);
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }
}
