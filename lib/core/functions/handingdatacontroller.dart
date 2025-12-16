
import '../class/stutusconntection.dart';

handlingData(response){
  if (response is StatusRequest){
   return response ; 
  }else {
   return StatusRequest.seccess ;
  }
}