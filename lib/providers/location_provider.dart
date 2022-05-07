import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';

import 'location_log_data_source_provider.dart';

/// 位置情報をリアルタイムで取得
final locationStreamProvider = StreamProvider.autoDispose((ref) {
  final location = Location();
  // ignore: cascade_invocations
  location.enableBackgroundMode(enable: true);
  final locationLogDataSource = ref.read(locationLogDataSourceProvider);
  location.onLocationChanged.listen(locationLogDataSource.add);
  return location.onLocationChanged;
});

/// 位置情報ログをリアルタイムで取得
final locationLogStreamProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(locationLogDataSourceProvider).stream;
});
