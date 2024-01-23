import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileOutputLogger extends LogOutput {
  FileOutputLogger();

  @override
  void output(OutputEvent event) async {
    var logMessage = event.lines.join('\n');
    final DateTime now = DateTime.now();
    final String formattedDateTime =
        '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)} '
        '${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}';

    logMessage += ' $formattedDateTime';

    // Applikationsspezifischer Pfad und Dateiname
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/app.log');
    await file.writeAsString('$logMessage \n',
        mode: FileMode.append);
  }
  String _twoDigits(int n) {
    if (n >= 10) {
      return '$n';
    }
    return '0$n';
  }
}