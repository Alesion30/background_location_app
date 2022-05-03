import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'hooks/use_theme.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = useTheme();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'home',
              style: theme.textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}
