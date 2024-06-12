import 'dart:io';

import 'package:logger/logger.dart';

class LogFileOutput extends LogOutput {
  final Directory logDirectory;
  final String logFileName;
  final int maxFileSizeInBytes;
  final int maxBackupFiles;
  late File _currentLogFile;
  late int _currentFileIndex;

  LogFileOutput({
    required this.logDirectory,
    required this.logFileName,
    this.maxFileSizeInBytes = 1024 * 1024 * 5, // 默认5MB
    this.maxBackupFiles = 3, // 默认3个备份文件
  }) {
    _initialize();
  }

  void _initialize() {
    if (!logDirectory.existsSync()) {
      logDirectory.createSync(recursive: true);
    }
    _currentFileIndex = 0;
    _currentLogFile = File('${logDirectory.path}/$logFileName.log');
    _rotateIfNeeded();
  }

  void _rotateIfNeeded() {
    if (_currentLogFile.existsSync() && _currentLogFile.lengthSync() >= maxFileSizeInBytes) {
      _rotateFiles();
    }
  }

  void _rotateFiles() {
    for (int i = maxBackupFiles - 1; i > 0; i--) {
      final oldFile = File('${logDirectory.path}/$logFileName.$i.log');
      final newFile = File('${logDirectory.path}/$logFileName.${i + 1}.log');
      if (oldFile.existsSync()) {
        oldFile.renameSync(newFile.path);
      }
    }

    final backupFile = File('${logDirectory.path}/$logFileName.1.log');
    if (_currentLogFile.existsSync()) {
      _currentLogFile.renameSync(backupFile.path);
    }

    _currentLogFile = File('${logDirectory.path}/$logFileName.log');
    _currentLogFile.createSync();
  }

  @override
  void output(OutputEvent event) {
    _rotateIfNeeded();
    for (var line in event.lines) {
      _currentLogFile.writeAsStringSync('$line\n', mode: FileMode.append);
    }
  }
}