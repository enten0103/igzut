import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

getToaster() {
  return (String message) {
    FToast fToast = FToast();
    fToast.showToast(
        child: Card(
            elevation: 0.2,
            shape: StadiumBorder(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Text(message),
            )));
  };
}
