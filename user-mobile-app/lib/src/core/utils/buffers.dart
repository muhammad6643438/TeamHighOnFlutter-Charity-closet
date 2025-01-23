import 'package:flutter/material.dart';

mixin Buffers on ChangeNotifier {
  List<String> buffers = [];

  addLoader(String id) {
    buffers.add(id);
    debugPrint('Buffer added: $id');
    notifyListeners();
  }

  removeLoader(String id) {
    buffers.remove(id);
    debugPrint('Buffer remove: $id');
    notifyListeners();
  }

  bool hasLoader(String id) {
    return buffers.contains(id);
  }

  // @protected
  // Future<void> executeAPI({
  //   bool isAuth = false,
  //   bool showPromt = true,
  //   required String apiEndPoint,
  //   required Future<void> Function() onSuccess,
  //   Future<void> Function(Object)? onError,
  //   Future<void> Function()? onFinally,
  // }) async {
  //   if (hasLoader(apiEndPoint)) return;
  //   try {
  //     addLoader(apiEndPoint);
  //     await onSuccess();
  //   } on UnAuthException {
  //     if (!isAuth) {
  //       AuthHandler.ref.logout();
  //     }
  //   } catch (e) {
  //     appPrint(e.runtimeType);
  //     if (showPromt) {
  //       Prompts.showMaterialBanner(e.toString(), color: AppColors.eventRed);
  //     }
  //     await onError?.call(e);
  //   } finally {
  //     removeLoader(apiEndPoint);
  //     await onFinally?.call();
  //   }
  //}
}
