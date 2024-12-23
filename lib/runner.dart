import 'dart:async';
import 'package:flutter/services.dart';
import 'package:i_billing/setup.dart';
import 'package:l/l.dart';
import 'app.dart';
import "dart:developer";

void run() => l.capture<void>(
      () => runZonedGuarded<void>(
        () async {
          log("run => setup");
          await setup();
          await SystemChrome.setPreferredOrientations([]).then(
            (_) => App.run(),
          );
        },
        (final error, final stackTree) {
          l.e("l_capture error section");
          l.e("io_top_level_error: $error && $stackTree", stackTree);
        },
      ),
      const LogOptions(
        printColors: true,
        handlePrint: true,
        outputInRelease: true,
      ),
    );
