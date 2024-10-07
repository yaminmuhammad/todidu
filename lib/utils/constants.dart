import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:todidu/main.dart';
import 'package:todidu/utils/app_str.dart';

String lottieURL = 'assets/lottie/1.json';

// Empty Title or SubTitl TextField
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You Must fill all fields!',
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20.0),
  );
}

// Nothing entered when user try to edit or update the current task
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You Must edit the task then try to update it!',
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20.0),
  );
}

// No Task Warning Dialog for deleting
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.show(
    context,
    title: AppStr.oopsMsg,
    message: AppStr.oopsMsg,
    buttonText: "Okay",
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

// Delete All Task From DB Dialog
dynamic deleteAllTaskWarning(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppStr.areYouSure,
    message:
        "Do you really want to delete all tasks? You will no be able to undo this action!",
    panaraDialogType: PanaraDialogType.error,
    confirmButtonText: '',
    cancelButtonText: '',
    barrierDismissible: false,
    onTapConfirm: () {
      // clear all box data
      BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
  );
}
