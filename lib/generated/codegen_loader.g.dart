// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "No_photos_available": "No photos available",
  "light": "Light",
  "dark": "Dark",
  "theme": "Theme",
  "language": "Language",
  "current_language": "English",
  "upload_photo": "Upload Photo"
};
static const Map<String,dynamic> ru = {
  "No_photos_available": "Фотографии недоступны",
  "light": "Светлая",
  "dark": "Темная",
  "theme": "Тема",
  "language": "Язык",
  "current_language": "Русский",
  "upload_photo": "Загрузить фото"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ru": ru};
}
