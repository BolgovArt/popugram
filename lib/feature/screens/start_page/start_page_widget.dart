import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:surf_flutter_summer_school_24/feature/screens/start_page/start_page_model.dart';
import 'package:surf_flutter_summer_school_24/feature/theme/di/theme_inherited.dart';
import 'package:surf_flutter_summer_school_24/feature/screens/opened_image/photo_page_widget.dart';
import 'package:surf_flutter_summer_school_24/generated/locale_keys.g.dart';
import 'package:surf_flutter_summer_school_24/uikit/styles/font_styles.dart';


class WidgetForSaveModelFromInheritProvider extends StatefulWidget {
  const WidgetForSaveModelFromInheritProvider({super.key});

  @override
  State<WidgetForSaveModelFromInheritProvider> createState() => _WidgetForSaveModelFromInheritProviderState();
}

class _WidgetForSaveModelFromInheritProviderState extends State<WidgetForSaveModelFromInheritProvider> {
  final model = StartPageModel();
  @override
  Widget build(BuildContext context) {
    return StartPageModelProvider(
      model: model,
      child: const StartPageWidget(),
      );
  }
}

class StartPageWidget extends StatelessWidget {
  const StartPageWidget({super.key});

  @override
  
  Widget build(BuildContext context) {
    final modelProvider = StartPageModelProvider.watch(context);
    final model = modelProvider?.model;

    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          InversionOfBlackPng(child: Image.asset('assets/images/lologram.png', width: 140)),
          const Spacer(flex: 1)
        ],
      ),
      actions: [
        InversionOfBlackPng(child: IconButton(
          onPressed: (){
            showModalBottomSheet(
              context: context,
                builder: (BuildContext context) {
                  return BottomSheetContent();
                },
            );
            }, 
          icon: Image.asset('assets/images/iconMenu.png')
          ))
      ],
      ),


      body: FutureBuilder(
        future: model?.createPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return model == null || model.photos.isEmpty
                ? Center(child: Text(LocaleKeys.No_photos_available.tr()))
                : 
                GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          // itemCount: images.length,
          itemCount: StartPageModelProvider.watch(context)?.model.photosCount,
          itemBuilder: (BuildContext context, int index) {
            return Hero(
              // tag: images[index],
              // tag: StartPageModelProvider.watch(context)?.model.photos[index],
              tag: model.photos[index].image.toString(), // !
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoPage(index: index)
                      )
                    );
                  },
                  child: model.photos[index]
                ),
              ),
            );
          }
            );
          }
        }
      )
    );
  }
}

class InversionOfBlackPng extends StatelessWidget {
  final Widget child;
  const InversionOfBlackPng({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ColorFiltered(
      colorFilter: isDarkMode
                      ? const ColorFilter.matrix(<double>[
                          -1,  0,  0,  0, 255, // red
                           0, -1,  0,  0, 255, // green
                           0,  0, -1,  0, 255, // blue
                           0,  0,  0,  1,   0, // alpha
                        ])
                      : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
      child: child,
      );
  }
}


class BottomSheetContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final whatKindOfTheme = Theme.of(context).brightness == Brightness.light;
    final currentTheme;
    if (whatKindOfTheme) {
      currentTheme = 'Светлая';
    } else {
      currentTheme = 'Темная';
    }
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ThemeInherited.of(context).switchThemeMode();
                }, 
              child: Row(
                children: [
                  const Icon(Icons.wb_sunny_outlined),
                  const SizedBox(width: 10),
                  Text('Тема', style: MyCustomStyle.mainText.copyWith(fontSize: 18),),
                  const Expanded(child: SizedBox()),
                  Text('$currentTheme', style: MyCustomStyle.mainTextThin.copyWith(fontSize: 18),)
                ],
              ),
            ),
              
            ),
            SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (context.locale == Locale('ru')) {
                  context.setLocale(Locale('en'));
                } else {
                context.setLocale(Locale('ru'));
                }
                }, 
              child: Row(
                children: [
                  const Icon(Icons.language),
                  const SizedBox(width: 10),
                  Text('Язык', style: MyCustomStyle.mainText.copyWith(fontSize: 18),),
                  const Expanded(child: SizedBox()),
                  Text('Какой?', style: MyCustomStyle.mainTextThin.copyWith(fontSize: 18),)
                ],
              ),
            ),
              
            ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                
              },
              child: Row(
                children: [
                  const Icon(Icons.cloud_upload),
                  SizedBox(width: 10),
                  Text('Загрузить фото...', style: MyCustomStyle.mainText.copyWith(fontSize: 18),),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                StartPageModelProvider.watch(context)?.model.deleteLastImage();
              },
              child: Row(
                children: [
                  const Icon(Icons.cloud_upload),
                  SizedBox(width: 10),
                  Text('Удалить последнее фото', style: MyCustomStyle.mainText.copyWith(fontSize: 18),),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                StartPageModelProvider.watch(context)?.model.deleteAllImage();
              },
              child: Row(
                children: [
                  const Icon(Icons.cloud_upload),
                  SizedBox(width: 10),
                  Text('Удалить все фото', style: MyCustomStyle.mainText.copyWith(fontSize: 18),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

