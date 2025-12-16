import 'package:get/get.dart';

class FlightBookingController extends GetxController {
  RxInt selectedType = 1.obs; // types of flights: [0: one-way ,1: round-trip ,2: multi-city]
  int numberOfFlights = 1;
  List<Map> flights = [
    {"number": 1},
  ];

  void toggleType(int type) {
    selectedType.value = type;
  }

  void cancelFlight(int flightIndex) {
    flights.removeAt(flightIndex);
    var x = 1;
    for (var i in flights) {
      i["number"] = x++;
    }
  }
}
