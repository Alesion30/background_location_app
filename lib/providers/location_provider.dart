import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';

final locationStreamProvider = StreamProvider.autoDispose((ref) {
  final location = Location();
  return location.onLocationChanged;
});
