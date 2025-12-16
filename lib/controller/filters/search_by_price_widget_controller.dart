import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchByPriceWidgetController extends GetxController {
  bool isSliderEnabled = true;
  bool changeItems = true;
  int currencyValue = 0; // 0: USD   1: Syrian Pound
  double start = 10;
  double end = 50;
  RangeValues? selectedRange;
  double usdToSyrian = 10000;
  String numberSuffix = "";
  String currency = 'usd';
  double sliderMinValue = 10;
  double sliderMaxValue = 1000;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedRange = RangeValues(start, end);
  }

  void toggleSlider(bool value) {
    isSliderEnabled = value;
    update();
  }

  void changeCurrency(int v) {
    if (v == currencyValue) {
      return;
    }
    currencyValue = v;
    if (v == 0) {
      currency = 'usd';
      start /= usdToSyrian;
      start /= 10;
      start *= 10;
      //
      end /= usdToSyrian;
      end /= 10;
      end *= 10;
      //
      sliderMaxValue /= usdToSyrian;
      sliderMaxValue /= 10;
      sliderMaxValue *= 10;
    } else {
      currency = 'syrian_pound';
      start *= usdToSyrian;
      start /= 1000;
      start *= 1000;
      //
      end *= usdToSyrian;
      end /= 10000;
      end *= 10000;
      //
      sliderMaxValue *= usdToSyrian;
      sliderMaxValue /= 10000;
      sliderMaxValue *= 10000;
    }
    setRange(start, end, sliderMaxValue);
    // update();
  }

  void setRange(double s, double e, double sliderMax) {
    start = s;
    sliderMaxValue = sliderMax;
    selectedRange = RangeValues(s, e);
    update();
  }
  void changeRange(RangeValues values) {
    selectedRange = values;
    update();
  }
}
