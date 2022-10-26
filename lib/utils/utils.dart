import 'package:flutter/material.dart';
import 'package:qrreader/models/scan_models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

launchUrl(ScanModel scanModel, BuildContext context) async {
  if (scanModel.tipo == "http") {
    if (!await launch(scanModel.valor)) throw 'Could not launch';
  } else if (scanModel.tipo != "http") {
    Fluttertoast.showToast(
        msg: "not a link to open",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  } else {
    Navigator.pushNamed(context, "map", arguments: scanModel);
  }
}
