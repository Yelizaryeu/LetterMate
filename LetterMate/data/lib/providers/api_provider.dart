// import 'package:core/constants/api_constants.dart';
// import 'package:data/entity/album/album_entity.dart';
// import 'package:data/entity/picture/picture_entity.dart';
// import 'package:dio/dio.dart';
// import 'package:domain/models/album/album_model.dart';
// import 'package:domain/models/picture/picture_model.dart';
// import 'package:retrofit/retrofit.dart';
//
// part 'api_provider.g.dart';
//
// @RestApi(baseUrl: ApiConstants.kBaseUrl)
// abstract class ApiProvider {
//   factory ApiProvider(
//     Dio dio, {
//     String baseUrl,
//   }) = _ApiProvider;
//
//   @GET(ApiConstants.kAlbumsPath)
//   Future<List<AlbumEntity>> getAllAlbums();
//
//   @GET(ApiConstants.kAlbumsPath)
//   Future<List<AlbumEntity>> getAlbumsByText(
//     @Query("title") String title,
//   );
//
//   @GET("${ApiConstants.kAlbumsPath}/{id}${ApiConstants.kPicturesPath}")
//   Future<List<PictureEntity>> getAlbumPictures(@Path("id") String id);
// }
