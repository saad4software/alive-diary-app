import 'package:alive_diary/abstracts/base_api_datasource.dart';
import 'package:alive_diary/abstracts/data_state.dart';
import 'package:alive_diary/config/constants/app_consts.dart';
import 'package:alive_diary/config/di/locator.dart';
import 'package:alive_diary/data/datasources/remote_datasource.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/domain/models/entities/login_model.dart';
import 'package:alive_diary/domain/models/entities/message_model.dart';
import 'package:alive_diary/domain/models/entities/user_model.dart';
import 'package:alive_diary/domain/models/requests/activate_account_request.dart';
import 'package:alive_diary/domain/models/requests/change_password_request.dart';
import 'package:alive_diary/domain/models/requests/login_request.dart';
import 'package:alive_diary/domain/models/requests/message_request.dart';
import 'package:alive_diary/domain/models/requests/refresh_code_request.dart';
import 'package:alive_diary/domain/models/requests/register_request.dart';
import 'package:alive_diary/domain/models/responses/ListResponse.dart';
import 'package:alive_diary/domain/models/responses/generic_response.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  ApiRepositoryImpl(this.remoteDatasource, this._preferences);

  final RemoteDatasource remoteDatasource;
  final SharedPreferences _preferences;


  @override
  Future<DataState<GenericResponse<LoginModel>>> login({
    required String username,
    required String password,
  }) => getStateOf<GenericResponse<LoginModel>>(
      request: ()=>remoteDatasource.login(
          request: LoginRequest(
              username: username,
              password: password,
          ),
      ),
  );

  @override
  Future<DataState<GenericResponse<UserModel>>> accountDetails() => getStateOf(
      request: ()=>remoteDatasource.details(
        token: _preferences.getString("Bearer ${AppConsts.keyToken}"),
        lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
      )
  );



  @override
  Future<DataState<GenericResponse<String>>> activate({
    required String username,
    required String code,
  }) => getStateOf(
      request: ()=>remoteDatasource.activate(
        request: ActivateAccountRequest(
          username: username,
          code: code,
        ),
      ),
  );

  @override
  Future<DataState<GenericResponse<String>>> changePassword({
    required String password,
    required String newPassword,
  }) => getStateOf(
      request: () => remoteDatasource.password(
        request: ChangePasswordRequest(
          password: password,
          newPassword: newPassword,
        ),
      ),
  );

  @override
  Future<DataState<GenericResponse<LoginModel>>> refresh({
    required String refresh,
  }) => getStateOf(
      request: () => remoteDatasource.refresh(
          request: RefreshCodeRequest(
              refresh: refresh,
          ),
      ),
  );

  @override
  Future<DataState<GenericResponse<UserModel>>> register({
    required String firstName,
    required String lastName,
    required String username,
    required String password1,
    required String password2,
  }) => getStateOf(
    request: () => remoteDatasource.register(
      request: RegisterRequest(
        firstName: firstName,
        lastName: lastName,
        username: username,
        password1: password1,
        password2: password2,
      ),
    ),
  );


  @override
  Future<DataState<GenericResponse<ListResponse<DiaryModel>>>> diariesList({
    required int page
  }) => getStateOf(
      request: () {
        return remoteDatasource.diariesList(
          page: page,
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
        );
      }
  );

  @override
  Future<DataState<GenericResponse<MessageModel>>> diarySend({
    required DiaryModel item,
    required String text,
    required int conversation
  }) => getStateOf(
      request: () {
        return remoteDatasource.diarySend(
          id: item.id,
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
          request: MessageRequest(
            text: text,
            conversation: conversation,
          ),

        );
      }
  );

  @override
  Future<DataState<GenericResponse<MessageModel>>> diaryStart({
    required DiaryModel item,
  }) => getStateOf(
      request: () {
        return remoteDatasource.diaryStart(
          id: item.id,
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
        );
      }
  );

  @override
  Future<DataState<GenericResponse<ListResponse<DiaryModel>>>> memoriesList({
    required int page,
  }) => getStateOf(
      request: () {
        return remoteDatasource.memoriesList(
          page: page,
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
        );
      }
  );

  @override
  Future<DataState<GenericResponse<MessageModel>>> memoryCreateSend({
    required DiaryModel item,
    required String text,
    required int conversation
  }) => getStateOf(
      request: () {
        return remoteDatasource.memoryCreateSend(
          id: item.id,
          request: MessageRequest(
            text: text,
            conversation: conversation,
          ),
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
        );
      }
  );

  @override
  Future<DataState<GenericResponse<MessageModel>>> memoryCreateStart({
    required DiaryModel item
  }) => getStateOf(
      request: () {
        return remoteDatasource.memoryCreateStart(
          id: item.id,
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
        );
      }
  );

  @override
  Future<DataState<GenericResponse<MessageModel>>> memorySend({
    required DiaryModel item,
    required String text,
    required int conversation
  }) => getStateOf(
      request: () {
        return remoteDatasource.memorySend(
          id: item.id,
          request: MessageRequest(
            text: text,
            conversation: conversation,
          ),
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
        );
      }
  );

  @override
  Future<DataState<GenericResponse<MessageModel>>> memoryStart({
    required DiaryModel item
  }) => getStateOf(
      request: () {
        return remoteDatasource.memoryStart(
          id: item.id,
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
        );
      }
  );

  @override
  Future<DataState<GenericResponse<DiaryModel>>> memoryCreate({
    required String name
  }) => getStateOf(
      request: () {
        return remoteDatasource.memoryCreate(
          request: DiaryModel(title: name),
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
        );
      }
  );

  @override
  Future<DataState<GenericResponse<DiaryModel>>> diariesCreate() => getStateOf(
      request: () {
        return remoteDatasource.diariesCreate(
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
        );
      }
  );

  @override
  Future<DataState<GenericResponse<MessageModel>>> diaryCreateSend({
    required DiaryModel item,
    required String text,
    required int conversation
  }) => getStateOf(
      request: () {
        return remoteDatasource.diaryCreateSend(
          request: MessageRequest(
            text: text,
            conversation: conversation,
          ),
          id: item.id,
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
        );
      }
  );
  @override
  Future<DataState<GenericResponse<MessageModel>>> diaryCreateStart({
    required DiaryModel item,
  }) => getStateOf(
      request: () {
        return remoteDatasource.diaryCreateStart(
          id: item.id,
          token: "Bearer ${_preferences.getString(AppConsts.keyToken)}",
          lang: locator<FlutterLocalization>().currentLocale.localeIdentifier,
        );
      }
  );

}