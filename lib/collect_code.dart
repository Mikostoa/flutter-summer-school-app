
import 'dart:io';

void main() async {
  // Путь к корневой папке проекта
  final projectDir = Directory.current;
  // Путь к выходному файлу
  final outputFile = File('all_code.txt');
  
  // Создаем или очищаем выходной файл
  if (await outputFile.exists()) {
    await outputFile.delete();
  }
  await outputFile.create();
  
  // Список расширений файлов для обработки
  const extensions = ['.dart'];
  
  // Собираем содержимое всех файлов
  StringBuffer buffer = StringBuffer();
  
  await _scanDirectory(projectDir, buffer, extensions);
  
  // Записываем результат в файл
  await outputFile.writeAsString(buffer.toString());
  
  print('Все файлы собраны в ${outputFile.path}');
}

Future<void> _scanDirectory(Directory dir, StringBuffer buffer, List<String> extensions) async {
  await for (var entity in dir.list(recursive: false, followLinks: false)) {
    if (entity is File) {
      // Проверяем расширение файла
      if (extensions.any((ext) => entity.path.endsWith(ext))) {
        // Добавляем разделитель и путь к файлу
        buffer.writeln('=' * 80);
        buffer.writeln('File: ${entity.path}');
        buffer.writeln('=' * 80);
        buffer.writeln();
        
        // Читаем содержимое файла
        try {
          String content = await entity.readAsString();
          buffer.writeln(content);
          buffer.writeln();
        } catch (e) {
          buffer.writeln('Error reading file: $e');
          buffer.writeln();
        }
      }
    } else if (entity is Directory) {
      // Игнорируем определенные папки (например, build, .dart_tool)
      if (!_isIgnoredDirectory(entity)) {
        await _scanDirectory(entity, buffer, extensions);
      }
    }
  }
}

bool _isIgnoredDirectory(Directory dir) {
  // Список папок, которые нужно игнорировать
  const ignoredDirs = [
    'build',
    '.dart_tool',
    '.git',
    'ios',
    'android',
    'web',
    'macos',
    'linux',
    'windows',
    'test_driver'
  ];
  return ignoredDirs.any((ignored) => dir.path.endsWith(ignored));
}

