
import 'package:alive_diary/abstracts/data_state.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/domain/models/entities/login_model.dart';
import 'package:alive_diary/domain/models/entities/message_model.dart';
import 'package:alive_diary/domain/models/entities/user_model.dart';
import 'package:alive_diary/domain/models/responses/ListResponse.dart';
import 'package:alive_diary/domain/models/responses/generic_response.dart';

abstract class ApiRepository {

  Future<DataState<GenericResponse<LoginModel>>> login({
    required String username,
    required String password,
  });

  Future<DataState<GenericResponse<UserModel>>> register({
    required String firstName,
    required String lastName,
    required String username,
    required String password1,
    required String password2,
  });

  Future<DataState<GenericResponse<String>>> activate({
    required String username,
    required String code,
  });

  Future<DataState<GenericResponse<LoginModel>>> refresh({
    required String refresh,
  });

  Future<DataState<GenericResponse<String>>> changePassword({
    required String password,
    required String newPassword,
  });

  Future<DataState<GenericResponse<UserModel>>> profileDetails();
  Future<DataState<GenericResponse<UserModel>>> updateProfile(UserModel item);


  Future<DataState<GenericResponse<ListResponse<DiaryModel>>>> diariesList({
    required int page,
  });

  Future<DataState<GenericResponse<DiaryModel>>> diariesCreate();
  Future<DataState<GenericResponse<String>>> diariesDelete({
    required DiaryModel item,
  });

  Future<DataState<GenericResponse<MessageModel>>> diaryStart({
    required DiaryModel item,
  });

  Future<DataState<GenericResponse<MessageModel>>> diarySend({
    required DiaryModel item,
    required String text,
    required int conversation,
  });

  Future<DataState<GenericResponse<String>>> diaryShare({
    required DiaryModel item,
    required String email,
  });

  Future<DataState<GenericResponse<MessageModel>>> diaryCreateStart({
    required DiaryModel item,
  });

  Future<DataState<GenericResponse<MessageModel>>> diaryCreateSend({
    required DiaryModel item,
    required String text,
    required int conversation,
  });

  Future<DataState<GenericResponse<ListResponse<DiaryModel>>>> memoriesList({
    required int page,
  });

  Future<DataState<GenericResponse<DiaryModel>>> memoryCreate({
    required String name,
  });

  Future<DataState<GenericResponse<String>>> memoryDelete({
    required DiaryModel item,
  });

  Future<DataState<GenericResponse<MessageModel>>> memoryStart({
    required DiaryModel item,
  });

  Future<DataState<GenericResponse<MessageModel>>> memorySend({
    required DiaryModel item,
    required String text,
    required int conversation,
  });

  Future<DataState<GenericResponse<MessageModel>>> memoryCreateStart({
    required DiaryModel item,
  });

  Future<DataState<GenericResponse<String>>> memoryShare({
    required DiaryModel item,
    required String email,
  });

  Future<DataState<GenericResponse<MessageModel>>> memoryCreateSend({
    required DiaryModel item,
    required String text,
    required int conversation,
  });


}