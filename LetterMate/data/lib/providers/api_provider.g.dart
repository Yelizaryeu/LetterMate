// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'api_provider.dart';
//
// // **************************************************************************
// // RetrofitGenerator
// // **************************************************************************
//
// // ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers
//
// class _ApiProvider implements ApiProvider {
//   _ApiProvider(
//     this._dio, {
//     this.baseUrl,
//   }) {
//     baseUrl ??= 'https://jsonplaceholder.typicode.com/';
//   }
//
//   final Dio _dio;
//
//   String? baseUrl;
//
//   @override
//   Future<List<AlbumEntity>> getAllAlbums() async {
//     const _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     final _data = <String, dynamic>{};
//     final _result = await _dio
//         .fetch<List<dynamic>>(_setStreamType<List<AlbumEntity>>(Options(
//       method: 'GET',
//       headers: _headers,
//       extra: _extra,
//     )
//             .compose(
//               _dio.options,
//               '/albums',
//               queryParameters: queryParameters,
//               data: _data,
//             )
//             .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
//     var value = _result.data!
//         .map((dynamic i) => AlbumEntity.fromJson(i as Map<String, dynamic>))
//         .toList();
//     return value;
//   }
//
//   @override
//   Future<List<AlbumEntity>> getAlbumsByText(title) async {
//     const _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{r'title': title};
//     final _headers = <String, dynamic>{};
//     final _data = <String, dynamic>{};
//     final _result = await _dio
//         .fetch<List<dynamic>>(_setStreamType<List<AlbumEntity>>(Options(
//       method: 'GET',
//       headers: _headers,
//       extra: _extra,
//     )
//             .compose(
//               _dio.options,
//               '/albums',
//               queryParameters: queryParameters,
//               data: _data,
//             )
//             .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
//     var value = _result.data!
//         .map((dynamic i) => AlbumEntity.fromJson(i as Map<String, dynamic>))
//         .toList();
//     return value;
//   }
//
//   @override
//   Future<List<PictureEntity>> getAlbumPictures(id) async {
//     const _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     final _data = <String, dynamic>{};
//     final _result = await _dio
//         .fetch<List<dynamic>>(_setStreamType<List<PictureEntity>>(Options(
//       method: 'GET',
//       headers: _headers,
//       extra: _extra,
//     )
//             .compose(
//               _dio.options,
//               '/albums/${id}/photos',
//               queryParameters: queryParameters,
//               data: _data,
//             )
//             .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
//     var value = _result.data!
//         .map((dynamic i) => PictureEntity.fromJson(i as Map<String, dynamic>))
//         .toList();
//     return value;
//   }
//
//   RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
//     if (T != dynamic &&
//         !(requestOptions.responseType == ResponseType.bytes ||
//             requestOptions.responseType == ResponseType.stream)) {
//       if (T == String) {
//         requestOptions.responseType = ResponseType.plain;
//       } else {
//         requestOptions.responseType = ResponseType.json;
//       }
//     }
//     return requestOptions;
//   }
// }
