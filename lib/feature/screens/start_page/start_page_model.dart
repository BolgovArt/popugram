import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/storage/photos/get_photo_http.dart';
import 'package:surf_flutter_summer_school_24/storage/photos/json_photo_serializable.dart';

class StartPageModel extends ChangeNotifier {
  final apiClient = ApiClient();
  final _photos = <Image>[];
  List<Image> get photos => _photos;
  
  Future<void> createPosts() async {
    final photosFrom = await apiClient.getPhotosUsingHttp();
    // _photos += photos;
    // _photos += 
    for (var index in photosFrom) {
      _photos.add(Image.network(index, fit: BoxFit.cover));
    }
    
    notifyListeners();
  }

  int get photosCount => _photos.length;

  Future<void> deleteLastImage() async {

  }

  Future<void> deleteAllImage() async {}


}

class StartPageModelProvider extends InheritedNotifier {
  final StartPageModel model;

  // StartPageModelProvider({ //! todo чем отличается форма записи конструктора разобрать
  //   super.key, 
  //   super.notifier, 
  //   required super.child, 
  //   required this.model
  //   });

  const StartPageModelProvider({
  Key? key,
  required this.model,
  required Widget child,
}) : super(
  key: key,
  notifier: model,
  child: child,
);

  static StartPageModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StartPageModelProvider>();
  }

  static StartPageModelProvider? read(BuildContext context) {
    final widget = 
      context.getElementForInheritedWidgetOfExactType<StartPageModelProvider>()?.widget;
    return widget is StartPageModelProvider ? widget : null; // Эта строка кода в Dart проверяет, является ли объект widget экземпляром класса StartPageModelProvider. Если да, то возвращает widget, иначе возвращает null
  }

}

