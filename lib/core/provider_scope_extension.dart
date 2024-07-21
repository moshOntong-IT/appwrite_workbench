import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension ProviderScopExtension on Widget {
  Widget scope({List<Override> overrides = const []}) {
    return ProviderScope(
      overrides: overrides,
      child: Builder(
        builder: (context) {
          return this;
        },
      ),
    );
  }
}
