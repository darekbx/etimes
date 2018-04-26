import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class EntriesStorage {

  String _file = 'entries.txt';

  addEntry(int timestamp) async {
    final file = await _localFile;
    file.writeAsString('$timestamp\n', mode: FileMode.APPEND);
  }

  Future<List<int>> loadEntries() async {
    final file = await _localFile;
    if (await file.exists()) {
      List<String> lines = file.readAsLinesSync();
      List<int> linesInt = [];
      for (final line in lines) {
        int parsedValue = int.tryParse(line);
        if (parsedValue != null) {
          linesInt.add(parsedValue);
        }
      }
      return linesInt;
    }
    else {
      return [];
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/$_file');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}