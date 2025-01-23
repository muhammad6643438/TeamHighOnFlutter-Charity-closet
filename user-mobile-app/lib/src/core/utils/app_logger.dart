import 'dart:developer';

import 'package:flutter/foundation.dart';

appPrint(message) {
  if (kDebugMode) {
    print("[PRINT] [Kvartal] => $message");
  }
}

appLog(message) {
  if (kDebugMode) {
    log("[LOG] [Kvartal] => $message");
  }
}
