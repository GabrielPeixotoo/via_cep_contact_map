import 'package:flutter/material.dart';

abstract class UIHelper {
  void showCustomSnackBar({required SnackBar snackBar});

  void showCustomDialog({required Widget dialog});

  void showCustomBottomSheet({required Widget bottomSheet});
}

class UIHelperImpl implements UIHelper {
  final GlobalKey<NavigatorState> navigatorKey;

  const UIHelperImpl({
    required this.navigatorKey,
  });

  @override
  void showCustomSnackBar({required SnackBar snackBar}) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      snackBar,
    );
  }

  @override
  void showCustomDialog({required Widget dialog}) {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: true,
      barrierColor: const Color(0xff1B1B1B).withOpacity(0.9),
      builder: (_) => dialog,
    );
  }

  @override
  void showCustomBottomSheet({required Widget bottomSheet}) {
    showModalBottomSheet(
      context: navigatorKey.currentContext!,
      isDismissible: true,
      barrierColor: const Color(0xff292929).withOpacity(0.51),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => bottomSheet,
    );
  }
}
