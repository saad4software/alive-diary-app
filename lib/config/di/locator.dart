import 'package:alive_diary/abstracts/network_interceptor.dart';
import 'package:alive_diary/config/locale/app_locale.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/data/datasources/remote_datasource.dart';
import 'package:alive_diary/data/repositories/api_repository_impl.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';

final locator = GetIt.instance;

Future<void> diInit() async {
  // final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
  // locator.registerSingleton<AppDatabase>(db);
  //

  // init dio
  final dio = Dio();
  dio.interceptors.add(NetworkInterceptor());


  // init locale
  final FlutterLocalization localization = FlutterLocalization.instance;
  localization.init(
    mapLocales: [
      const MapLocale('en', AppLocale.EN),
      const MapLocale('ar', AppLocale.AR),
    ],
    initLanguageCode: 'en',
  );


  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<FlutterLocalization>(localization);

  locator.registerSingleton<FlutterTts> (FlutterTts());
  locator.registerSingleton<SpeechToText> (SpeechToText());


  locator.registerSingleton<SharedPreferences> (
    await SharedPreferences.getInstance(),
  );

  locator.registerSingleton<RemoteDatasource>(
    RemoteDatasource(locator()),
  );

  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator(), locator()),
  );







}