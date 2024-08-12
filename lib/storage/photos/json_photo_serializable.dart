import 'package:json_annotation/json_annotation.dart';
part 'json_photo_serializable.g.dart';


@JsonSerializable()
class ResponseList {
  final List<ResponseElements> items;

  ResponseList({required this.items});

  factory ResponseList.fromJson(Map<String, dynamic> json) => _$ResponseListFromJson(json);

  // Map<String, dynamic> toJson() => _$ResponseListFromJson(this); // ! ошибка типов?????????
}


@JsonSerializable()
class ResponseElements {
  // final String resource_id;
  // // final String? public_url;
  final String path;
  final String file;
  // final String? date_time;
  final List<ResponseSize> sizes;

  ResponseElements(
    {
    // required this.resource_id, 
    // // required this.public_url,
    required this.path,
    required this.file,
    // required this.date_time,
    required this.sizes,
    });

  factory ResponseElements.fromJson(Map<String, dynamic> json) => _$ResponseElementsFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseElementsToJson(this);
}


@JsonSerializable()
class ResponseSize {
  // final String resource_id;
  // // final String? public_url;
  final String url;
  // final String? date_time;

  ResponseSize({required this.url});

  factory ResponseSize.fromJson(Map<String, dynamic> json) => _$ResponseSizeFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSizeToJson(this);
}


// обработка последнего:

// @JsonSerializable()
// class ResponseItemsApi {
//   final List<dynamic>? items;

//   ResponseItemsApi({required this.items});

//   factory ResponseItemsApi.fromJson(Map<String, dynamic> json) => _$ResponseItemsApiFromJson(json);
//     Map<String, dynamic> toJson() => _$ResponseItemsApiToJson(this);
// }

