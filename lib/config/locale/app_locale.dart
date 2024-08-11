import 'dart:convert';
import 'package:flutter/services.dart';

mixin AppLocale {
  static const String title = 'title';
  static const String language = 'language';
  static const String home = 'home';
  static const String library = 'library';
  static const String profile = 'profile';
  static const String email = 'email';
  static const String password = 'password';
  static const String login = 'login';
  static const String noAccount = 'no_account';
  static const String haveCode = 'have_code';
  static const String required = 'required';
  static const String welcome = 'welcome';

  Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }

  static const Map<String, dynamic> EN = {
    title: 'Hello',
    language: 'Language',
    home: 'Home',
    library: 'Library',
    profile: 'Profile',

    login: 'Login',
    noAccount: 'Don\'t have an account? Register here!',
    haveCode: 'Have a code?',
    email: 'Email',
    password: 'Password',

    required: 'Required',
    welcome: 'Welcome home',
  };
  static const Map<String, dynamic> AR = {
    title: 'مرحبا',
    language: 'اللغة',
    home: 'الرئيسية',
    library: 'المكتبة',
    profile: 'الحساب',

    login: 'تسجيل دخول',
    noAccount: 'لا تملك حساب؟ سجل هنا!',
    haveCode: 'لديك رمز تفعيل؟',
    email: 'البريد الالكتروني',
    password: 'كلمة المرور',

    required: 'مطلوب',

    welcome: 'اهلا وسهلا',


  };

}