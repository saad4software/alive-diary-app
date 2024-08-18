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
  static const String memories = 'memories';
  static const String diaries = 'diaries';
  static const String nameMemory = 'name_memory';
  static const String graduation = 'graduation';
  static const String cancel = 'cancel';
  static const String create = 'create';
  static const String share = 'share';
  static const String selectLanguage = 'select_language';
  static const String confirmPassword = 'confirm_password';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String register = 'register';
  static const String code = 'code';
  static const String confirm = 'confirm';
  static const String confirmAccount = 'confirm_account';
  static const String save = 'save';
  static const String bio = 'bio';
  static const String delete = 'delete';
  static const String userEmail = 'user_email';
  static const String areYouSure = 'are_you_sure';
  static const String capture = 'capture';

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
    memories: 'Memories',
    diaries: 'Diaries',
    nameMemory: 'Name your memory',
    graduation: 'Graduation day',
    cancel: 'Cancel',
    create: 'Create',
    share: 'Share',
    selectLanguage: 'Select Language',
    confirmPassword: 'Confirm Password',
    firstName: 'First Name',
    lastName: 'Last Name',
    register: 'Register',
    code: 'Code',
    confirm: 'Confirm',
    confirmAccount: 'Confirm Account',
    save: 'Save',
    bio: 'Bio',
    delete: 'Delete',
    userEmail: 'User\'s email',
    areYouSure: 'Are you sure',
    capture: 'Capture',
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

    memories: 'الذكريات',
    diaries: 'المذكرات',

    nameMemory: 'ما اسم الذكرى',
    graduation: 'يوم التخرج',
    cancel: 'الغاء',
    create: 'انشاء',
    share: 'مشاركة',
    selectLanguage: 'حدد اللغة',
    confirmPassword: 'تأكيد كلمة المرور',
    firstName: 'الاسم',
    lastName: 'الكنية',
    register: 'تسجيل',
    code: 'الرمز',
    confirm: 'تفعيل',
    confirmAccount: "تفعيل الحساب",
    save: 'حفظ',
    bio: 'بيو',
    delete: 'حذف',
    userEmail: 'بريد المستخدم',
    areYouSure: 'هل أنت متأكد؟',
    capture: 'احتفظ بذكرى',

  };

}