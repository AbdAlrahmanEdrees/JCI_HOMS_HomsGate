import 'package:get/get.dart';
import 'package:trip/core/constanat/routing.dart';
import 'package:trip/core/middleware/mymiddleware.dart';
import 'package:trip/view/screen/about_us.dart';
import 'package:trip/view/screen/detailsscreen.dart';
import 'package:trip/view/screen/saved_ads_screen.dart';
import 'package:trip/view/screen/filteres/filtered_property_screen.dart';
import 'package:trip/view/screen/homepage.dart';
import 'package:trip/view/screen/onboarding/onboardringscreen.dart';
import 'package:trip/view/screen/personal_info_screen.dart';
import 'package:trip/view/screen/userproperty/update_user_proprty.dart';
import 'package:trip/view/screen/userproperty/user_advertisements.dart';

import '../../view/screen/Dashboard_screen.dart';
import '../../view/screen/auth/forgetpassword/forgetpassword.dart';
import '../../view/screen/auth/forgetpassword/resetpassword.dart';
import '../../view/screen/auth/forgetpassword/verifycodeforgetpassword.dart';
import '../../view/screen/auth/signin.dart';
import '../../view/screen/auth/signup.dart';
import '../../view/screen/auth/verifycodesignup.dart';
import '../../view/screen/customize_search.dart';
import '../../view/screen/items_showing/malaz.mybooking.dart';
import '../../view/screen/propertydetailsscreen.dart';
import '../../view/screen/special_search_screen.dart';
import '../../view/screen/userproperty/userpropertydetails.dart';

class Routers {
  List<GetPage<dynamic>>? routers = [
    GetPage(
      name: '/',
      page: () => OnBoardringScreen(),
      middlewares: [MyMiddleWare()],
    ),
    GetPage(name: AppRoute.homepage, page: () => const HomePage()),
    GetPage(name: AppRoute.detailsscreeen, page: () => const DetailsScreen()),
    GetPage(name: AppRoute.signin, page: () => const SignIn()),
    GetPage(name: AppRoute.signup, page: () => const SignUp()),
    GetPage(name: AppRoute.forgetpassword, page: () => const ForgetPassword()),
    GetPage(
      name: AppRoute.verifycodeforgetpasswors,
      page: () => const VerifycodeForgetPassword(),
    ),
    GetPage(
      name: AppRoute.resetpassword,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: AppRoute.verifycodesignup,
      page: () => const VerifyCodeSignup(),
    ),
    // GetPage(
    //   name: AppRoute.AddCoustomerData,
    //   page: () => const AddCustomerData(),
    // ),
    GetPage(
      name: AppRoute.propertdetailsscreen,
      page: () => const PropertyDetailsScreen(),
    ),
    // GetPage(
    //   name: AppRoute.AddPropertyDetails,
    //   page: () => const AddPropertyDetails(),
    // ),
    // GetPage(name: AppRoute.setting, page: () => const SettingPage()),
    GetPage(
      name: AppRoute.personalinfo,
      page: () => const PersonalInfoScreen(),
    ),
    GetPage(name: AppRoute.aboutus, page: () => AboutUsScreen()),
    GetPage(
      name: AppRoute.userproperty,
      page: () => const UserAdvertisements(),
    ),
    GetPage(
      name: AppRoute.updateuserproprty,
      page: () => const UpdateUserProprty(),
    ),
    GetPage(
      name: AppRoute.userpropertydetails,
      page: () => const UserPropertyScreen(),
    ),
    GetPage(
      name: AppRoute.coustomizesearsh,
      page: () => const CustomizeSearch(),
    ),
    GetPage(
      name: AppRoute.spicealsearch,
      page: () => const SpicialSearchScreen(),
    ),
    GetPage(name: AppRoute.saved, page: () => const SavedAdsScreen()),
    GetPage(
      name: AppRoute.coustomizesearsh,
      page: () => const CustomizeSearch(),
    ),
    // GetPage(name: AppRoute.filteredsearch, page: () => const FilteredSearch()),
    GetPage(
      name: AppRoute.filteredpropertysearch,
      page: () => const FilteredPropertyScreen(),
    ),
    GetPage(name: AppRoute.booking, page: () => const MyBookingsWidget()),
    GetPage(name: AppRoute.dashboard, page: () => const DashboardPage()),
  ];
}
