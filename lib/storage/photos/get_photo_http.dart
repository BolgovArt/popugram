// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:surf_flutter_summer_school_24/storage/photos/json_photo_serializable.dart';

// // class ApiClient {
// final String unsplashApi = 'cloud-api.yandex.net';

// Future<List<ResponseList>> getPhotosUsingHttp() async {
//   final photosUri = Uri.https(
//     unsplashApi,
//     'v1/disk/resources/files',
//     {
//       // параметры. пусто, тк обязательных в api нет
//     },
//   );

//   final token = '';

// var photoResponse = await http.get(
//   photosUri,
//   headers: {
//       HttpHeaders.authorizationHeader: 'OAuth $token',
//     },
//   ) as List<dynamic>;
// // сделать PhotoRespince.fromJson(photoResponse.body)
// final info = photoResponse.map((e) => ResponseList.fromJson(e as Map<String, dynamic>)).toList();

// // print('Responce Status: ${photoResponse.statusCode}');
// // print('Responce Body: ${photoResponse.body}');

// print(info); // ! Эта строчка вызывает ошибку

// return info;
// }
// // }

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:surf_flutter_summer_school_24/storage/photos/json_photo_serializable.dart';

class ApiClient {
  final String unsplashApi = 'cloud-api.yandex.net';

  Future<List<String>> getPhotosUsingHttp() async {
    // void getPhotosUsingHttp() async {
    print('ALO');

        // final photosUri = Uri.parse('https://cloud-api.yandex.net/v1/disk/resources/files?media_type=image');

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

      final token =
          'y0_AgAAAAB3pUbwAADLWwAAAAELz7QZAAB36jfdqI9CErxOWfCVBivyI9rP0A';
// !
      var bigResponse = await http.get(
        photosUri,
        headers: {
          HttpHeaders.authorizationHeader: 'OAuth $token',
        },
      );
        print('Response Status: ${bigResponse.statusCode}');
        print('Response Body: ${bigResponse.body}');
      if (bigResponse.statusCode == 200) {

        final responsedBody = jsonDecode(bigResponse.body) as Map<String, dynamic>;

        final responsedBodyFromJson = ResponseList.fromJson(responsedBody);
        // print('responsedBodyFromJson: $responsedBodyFromJson');

        final photos = responsedBodyFromJson.items
          .expand((element) => element.sizes) // после expanded получаем плоский список ОБЪЕКТОВ ResponseSize
          .map((element) => element.url)
          .toList();
        print ('photos: $photos');
        return photos;
      //   final photos12 = responsedBodyFromJson.items.map((e) => e.sizes as Map<String, dynamic>).toList();
      //   final photos13 = photos12.map((e) => e.url as String).toList();
      // // return photos;
      //   print('photos12: $photos12');
        // final posts = responsedBodyFromJson.items.map((e) => ResponseElements.fromJson(e as Map<String, dynamic>))
        //     // .toList() as List<Map<String, dynamic>>;
        //     .toList();
        // final castedPosts = posts.cast<Map<String, dynamic>>();
        // // print('posts: $posts');

        // final photos = castedPosts.map((element) => element['path'] as String).toList();
        // print('photos: $photos');
      }
      // throw Exception();
    return [];
    }
  }
// }

//       for (var element in responsedBodyFromJson.items) {
//       // print('Resource ID: ${element.resource_id}');
//       // print('Public URL: ${photo.public_url}');
//       print('Path: ${element.path}');
//       // print('Date Time: ${element.date_time}');
//       print('Items: ${element.items}');
//     }
// }
// }

// final info = responsedBody.items.map((e) => ResponseList.fromJson(e  as Map<String, dynamic>)).toList();

// print('info: ${info}');

//   final bigResponse = responseList.items.map((e) => ResponseElements.fromJson(e as Map<String, dynamic>)).toList();

//   for (var element in bigResponse) {
//     // print('Resource ID: ${element.resource_id}');
//     // print('Public URL: ${photo.public_url}');
//     print('Path: ${element.path}');
//     // print('Date Time: ${element.date_time}');
//     print('Items: ${element.items}');
//   }
// } else {
//   // print('Response Status: ${photoResponse.statusCode}');
//   // print('Response Body: ${photoResponse.body}');
//   print('апокалипсис');
// }

// final posts = responseList.items.map((e) => ResponseElements.fromJson(e as Map<String, dynamic>)).toList();

// if (posts.isEmpty) {
//   final Future<List<ResponseElements>> mock = [['items':'dynamic']];
//   return mock;
// } else {
//   return posts;

// }

// Обработка ошибок
//   for (var element in responseList.items) {
//     print('Resource ID: ${element.resource_id}');
//     // print('Public URL: ${photo.public_url}');
//     print('Path: ${element.path}');
//     print('Date Time: ${element.date_time}');
//     print('Items: ${element.items}');
//   }
// } else {
//   // print('Response Status: ${photoResponse.statusCode}');
//   // print('Response Body: ${photoResponse.body}');
//   print('апокалипсис');
// }
// }
// }
// }

// сделать PhotoRespince.fromJson(photoResponse.body)
