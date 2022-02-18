import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_example/exception/network_exception.dart';

Future<bool> checkConnectivity() async {
  try {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  } catch (Exception) {
    return false;
  }
}

showSnackBarMessage(context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBar)
      .closed
      .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
}

showSnackBarException(context, NetworkException exception) {
  final snackBar = SnackBar(content: Text(getErrorMessage(context, exception)));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

getErrorMessage(context, NetworkException exception) {
  if (exception.errorCode == 1000) {
    return 'Xatolik ketdi!';
  }
  if (exception.errorCode == 2000) {
    return 'Internet ulanmagan!';
  }
  if (exception.errorCode == 3000) {
    return 'Xatolik ketdi!';
  }

  return exception.errorMessage;
}