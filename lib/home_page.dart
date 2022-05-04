import 'package:background_location_app/widgets/spacer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'hooks/use_theme.dart';
import 'providers/location_log_data_source_provider.dart';
import 'providers/location_provider.dart';
import 'utils/permission_util.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final locationStream = ref.watch(locationStreamProvider);
    final locationLogStream = ref.watch(locationLogStreamProvider);
    final locationDataSource = ref.read(locationLogDataSourceProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (context) {
                return locationLogStream.maybeWhen(
                  data: (logs) {
                    return Text(
                      'log count: ${logs.length}',
                      style: theme.textTheme.bodyText1,
                    );
                  },
                  orElse: Container.new,
                );
              },
            ),
            hSpacer(10),
            Builder(
              builder: (context) {
                return locationStream.when(
                  data: (loc) {
                    return Column(
                      children: [
                        Text(
                          'lat: ${loc.latitude}',
                          style: theme.textTheme.bodyText1,
                        ),
                        Text(
                          'lon: ${loc.longitude}',
                          style: theme.textTheme.bodyText1,
                        ),
                        Text(
                          'speed: ${loc.speed}',
                          style: theme.textTheme.bodyText1,
                        ),
                        hSpacer(20),
                        // ElevatedButton(
                        //   onPressed: () => locationDataSource.add(loc),
                        //   child: const Text('データ保存'),
                        // ),
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     final data = await locationDataSource.fetch();
                        //     if (kDebugMode) {
                        //       print(data);
                        //       print('データ数: ${data.length}');
                        //     }
                        //   },
                        //   child: const Text('データ取得'),
                        // ),
                        ElevatedButton(
                          onPressed: locationDataSource.delete,
                          child: const Text('データ削除'),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    return Text(
                      'error!!',
                      style: theme.textTheme.headline3,
                    );
                  },
                  loading: () {
                    return Column(
                      children: [
                        Text(
                          'loading...',
                          style: theme.textTheme.headline3,
                        ),
                        hSpacer(20),
                        const ElevatedButton(
                          onPressed: checkLocationPermission,
                          child: Text('権限要求'),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
