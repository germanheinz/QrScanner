import 'package:qrscanner/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

openURL(ScanModel scanModel) async {

  if(scanModel.tipo == 'http'){
    if (await canLaunch(scanModel.valor)) {
      await launch(scanModel.valor);
    } else {
      throw 'Could not launch $scanModel.valor';
    }
  }
}