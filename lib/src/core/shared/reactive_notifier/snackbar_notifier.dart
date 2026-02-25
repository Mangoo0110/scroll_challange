
import '../../utils/utils.dart';
import 'package:flutter/material.dart';


class SnackbarNotifier {

  BuildContext context;
  SnackbarNotifier({required this.context});

  EdgeInsets _snackBarMargin(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontal = screenWidth > 700 ? (screenWidth - 700) / 2 : 16.0;
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: 12);
  }

  notifySuccess({String? message}) {
    if(context.mounted && context.owner != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message ?? "Success", maxLines: 3, style: TextStyle(color: Colors.white).bold.regular),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          margin: _snackBarMargin(context),
        ),
      );
    }
  }

  notify({String? message, double fontSize = 16}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? "", maxLines: 3, style: TextStyle(color: Colors.white, fontSize: fontSize).bold),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        margin: _snackBarMargin(context),
      ),
    );
  }

  notifyError({String? message}) {
    if(context.mounted && context.owner != null) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? "Error", maxLines: 3, style: TextStyle(color: Colors.white).bold.regular,),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        showCloseIcon: true,
        margin: _snackBarMargin(context),
      ),
    );
    }
  }

}
