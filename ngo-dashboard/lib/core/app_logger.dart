import 'dart:developer';

import 'package:flutter/foundation.dart';

void appPrint(message) {
  if (kDebugMode) {
    print(message);
  }
}

void appLog(message) {
  if (kDebugMode) {
    log(message);
  }
}
