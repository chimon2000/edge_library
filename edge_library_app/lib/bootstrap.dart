import 'dart:async';

import 'package:edge_library_app/shared/extensions/map.dart';
import 'package:edge_library_app/shared/logger/logger.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:logging/logging.dart';
import 'package:loggy/loggy.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  Loggy.initLoggy();

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final level = logLevelMap.getOrDefault(record.level, LogLevel.info);

    final loggerName = record.loggerName.isEmpty ? 'App' : record.loggerName;

    Loggy(loggerName).log(
      level,
      record.message,
      record.error,
      record.stackTrace,
      record.zone,
    );
  });

  FlutterError.onError = (details) {
    logError(details.exceptionAsString(), details.exception, details.stack);
  };

  runApp(
    ProviderScope(
      child: await builder(),
    ),
  );
}
