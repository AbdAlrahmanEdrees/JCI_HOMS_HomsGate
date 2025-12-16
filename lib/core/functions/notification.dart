import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

fcmconfig(){
  print('==========================FCMTopic============');
  FirebaseMessaging.onMessage.listen((event) {
    print(event.notification!.body!);
    print(event.notification!.title!);
    Get.snackbar(event.notification!.title!, event.notification!.body!);
    refrashPageData(event.data);
  });

}
refrashPageData(data){
  print("00000000000000000000000000000000000");
  print(data);
  print("00000000000000000000000000000000000");
  if(Get.currentRoute=='nameofroute'&&data['route']=="somthing"){
  }
}
notificationPermissinn()async{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

}