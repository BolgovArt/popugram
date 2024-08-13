import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/data/theme_repository.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/domain/theme_controller.dart';
import 'package:surf_flutter_summer_school_24/app/my_app.dart';
import 'package:surf_flutter_summer_school_24/generated/codegen_loader.g.dart';
import 'package:surf_flutter_summer_school_24/storage/photos/get_photo_http.dart';
import 'package:surf_flutter_summer_school_24/storage/theme/theme_storage.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
    final apiClient = ApiClient();
  apiClient.getPhotosUsingHttp();
  final prefs = await SharedPreferences.getInstance();

  // getPhotosUsingHttp();

  final themStorage = ThemeStorage(prefs: prefs);
  final themeRepository = ThemeRepository(themStorage: themStorage);
  final themeController = ThemeController(themeRepository: themeRepository);

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MainApp(themeController: themeController)
    )
  );
}
