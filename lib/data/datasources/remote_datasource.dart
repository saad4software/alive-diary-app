import 'package:alive_diary/config/constants/app_consts.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/domain/models/entities/login_model.dart';
import 'package:alive_diary/domain/models/entities/message_model.dart';
import 'package:alive_diary/domain/models/entities/user_model.dart';
import 'package:alive_diary/domain/models/requests/activate_account_request.dart';
import 'package:alive_diary/domain/models/requests/change_password_request.dart';
import 'package:alive_diary/domain/models/requests/forgot_password_request.dart';
import 'package:alive_diary/domain/models/requests/login_request.dart';
import 'package:alive_diary/domain/models/requests/message_request.dart';
import 'package:alive_diary/domain/models/requests/refresh_code_request.dart';
import 'package:alive_diary/domain/models/requests/register_request.dart';
import 'package:alive_diary/domain/models/responses/ListResponse.dart';
import 'package:alive_diary/domain/models/responses/generic_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'remote_datasource.g.dart';

@RestApi(baseUrl: AppConsts.baseUrl, parser: Parser.JsonSerializable)
abstract class RemoteDatasource {
  factory RemoteDatasource(Dio dio, {String baseUrl}) = _RemoteDatasource;

  @POST('/account/login/')
  Future<HttpResponse<GenericResponse<LoginModel>>> login({
    @Body() LoginRequest? request,
  });


  @POST('/account/register/')
  Future<HttpResponse<GenericResponse<UserModel>>> register({
    @Body() RegisterRequest? request,
  });



  @POST('/account/code/')
  Future<HttpResponse<GenericResponse<String>>> code({
    @Body() ActivateAccountRequest? request,
  });

  @POST('/account/refresh/')
  Future<HttpResponse<GenericResponse<LoginModel>>> refresh({
    @Body() RefreshCodeRequest? request,
  });

  @POST('/account/forgot/')
  Future<HttpResponse<GenericResponse<String>>> forgot({
    @Body() ForgotPasswordRequest? request,
  });

  @POST('/account/activate/')
  Future<HttpResponse<GenericResponse<String>>> activate({
    @Body() ActivateAccountRequest? request,
  });

  @POST('/account/password/')
  Future<HttpResponse<GenericResponse<String>>> password({
    @Body() ChangePasswordRequest? request,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

  @GET('/account/details/')
  Future<HttpResponse<GenericResponse<UserModel>>> details({
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });


  @GET('/diaries/list/')
  Future<HttpResponse<GenericResponse<ListResponse<DiaryModel>>>> diariesList({
    @Query("page") int? page,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

  @POST('/diaries/list/')
  Future<HttpResponse<GenericResponse<DiaryModel>>> diariesCreate({
    @Body() DiaryModel? request,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

  @DELETE('/diaries/list/{id}/')
  Future<HttpResponse<GenericResponse<String>>> diariesDelete({
    @Path() int? id,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });


  @GET('/diaries/list/{id}/start/')
  Future<HttpResponse<GenericResponse<MessageModel>>> diaryStart({
    @Path() int? id,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });


  @POST('/diaries/list/{id}/start/')
  Future<HttpResponse<GenericResponse<MessageModel>>> diarySend({
    @Path() int? id,
    @Body() MessageRequest? request,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

  @GET('/diaries/list/{id}/create/')
  Future<HttpResponse<GenericResponse<MessageModel>>> diaryCreateStart({
    @Path() int? id,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

  @GET('/diaries/list/{id}/share/')
  Future<HttpResponse<GenericResponse<String>>> diaryShare({
    @Path() int? id,
    @Query("email") String? username,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });


  @POST('/diaries/list/{id}/create/')
  Future<HttpResponse<GenericResponse<MessageModel>>> diaryCreateSend({
    @Path() int? id,
    @Body() MessageRequest? request,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

  @GET('/memories/list/')
  Future<HttpResponse<GenericResponse<ListResponse<DiaryModel>>>> memoriesList({
    @Query("page") int? page,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

  @POST('/memories/list/')
  Future<HttpResponse<GenericResponse<DiaryModel>>> memoryCreate({
    @Body() DiaryModel? request,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });


  @DELETE('/memories/list/{id}/')
  Future<HttpResponse<GenericResponse<String>>> memoryDelete({
    @Path() int? id,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

  @GET('/memories/list/{id}/start/')
  Future<HttpResponse<GenericResponse<MessageModel>>> memoryStart({
    @Path() int? id,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });


  @POST('/memories/list/{id}/start/')
  Future<HttpResponse<GenericResponse<MessageModel>>> memorySend({
    @Path() int? id,
    @Body() MessageRequest? request,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

  @GET('/memories/list/{id}/create/')
  Future<HttpResponse<GenericResponse<MessageModel>>> memoryCreateStart({
    @Path() int? id,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

  @GET('/memories/list/{id}/share/')
  Future<HttpResponse<GenericResponse<String>>> memoryShare({
    @Query("email") String? email,
    @Path() int? id,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

  @POST('/memories/list/{id}/create/')
  Future<HttpResponse<GenericResponse<MessageModel>>> memoryCreateSend({
    @Path() int? id,
    @Body() MessageRequest? request,
    @Header("Authorization") String? token,
    @Header("Accept-Language") String? lang,
  });

}
