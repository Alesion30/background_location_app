import 'package:background_location_app/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'hooks/use_theme.dart';
import 'providers/location_provider.dart';
import 'utils/permission_util.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final locationStream = ref.watch(locationStreamProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    return Text(
                      'loading...',
                      style: theme.textTheme.headline3,
                    );
                  },
                );
              },
            ),
            hSpacer(20),
            const ElevatedButton(
              onPressed: checkLocationPermission,
              child: Text('権限要求'),
            )
          ],
        ),
      ),
    );
  }
}
