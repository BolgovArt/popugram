import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:surf_flutter_summer_school_24/storage/photos/json_photo_serializable.dart';

class ApiClient {
  final String unsplashApi = 'cloud-api.yandex.net';

  Future<List<String>> getPhotosUsingHttp() async {

      final photosUri = Uri.https(
        unsplashApi,
        'v1/disk/resources/files',
        {
          // параметры. пусто, тк обязательных в api нет
          // 'path': 'disk:/surf_summer_school_24',
          'media_type': 'image',
          // "public_key": "https://disk.yandex.ru/client/disk/surf_summer_school_24",
        },
      );

      const token = 'y0_AgAAAAB3pUbwAADLWwAAAAELz7QZAAB36jfdqI9CErxOWfCVBivyI9rP0A';
      // const token = 'y0_AgAAAAAFKq9bAADLWwAAAAELdB6CAAAob_OxaPJGNrQTvjB5ynPurwtg1Q';
      
// !
      var bigResponse = await http.get(
        photosUri,
        headers: {
          HttpHeaders.authorizationHeader: 'OAuth $token',
        },
      );
      if (bigResponse.statusCode == 200) {

        final responsedBody = jsonDecode(bigResponse.body) as Map<String, dynamic>;

        final responsedBodyFromJson = ResponseList.fromJson(responsedBody);
        // print('responsedBodyFromJson: $responsedBodyFromJson');

        final photos = responsedBodyFromJson.items
          // .expand((element) => element.sizes) // после expanded получаем плоский список ОБЪЕКТОВ ResponseSize
          .map((element) => element.file)
          .toList();
        return photos;
      } else {
        return [];
      }
    }
  }
