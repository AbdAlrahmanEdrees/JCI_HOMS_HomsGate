import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trip/binding/initialbinding.dart';
import 'package:trip/core/constanat/textstyles.dart';
import 'core/class/crud.dart';
import 'core/class/route.dart';
import 'core/services/shared_preferences/pref_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(Crud());
  await Get.putAsync(() => SharedPreferencesService().init());
  AppTextStyles.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final pref = Get.find<SharedPreferencesService>();
    final String savedLang = pref.getLanguage();
    return EasyLocalization(
      // This easy localization widget extends the parameters of the 'context' by the needed parameters of 'localization'
      // to make it easy to reach the localization files/ change the language of the application... etc.
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'Assets/localization',
      startLocale: Locale(savedLang), //default language
      // EasyLocalization automatically checks SharedPreferences for the saved language using the key: locale, if nothing found it uses the startLocale
      saveLocale: true, // this saves the user choice
      //it is still wise to put this fallbackLocal, it is your last defense line if something unexpected happen.
      fallbackLocale: const Locale(
        'en',
      ), //when unable to find a file for the selected language

      child: Builder(
        builder:
            (context) => ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  // if you don't write this one especially:
                  // you will cause this error: key <top-hotels for e.g.> wasn't found
                  // so the next line is the line reponsible of reaching the .json lozalization files
                  localizationsDelegates: context.localizationDelegates,

                  getPages: Routers().routers,
                  initialBinding: InitialBinding(),
                );
              },
            ),
      ),
    );
  }
}
