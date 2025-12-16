import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("Assets/images/beta.png",width: 150,height: 150,),
            Text("developed_by".tr()),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("about_the_company".tr()),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'Assets/images/beta.png',
                  height: 150,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "who_we_are".tr(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Tejwal",
                  color: Colors.teal,
                ),
                textAlign: TextAlign.end,
              ),
              SizedBox(height: 10),
              Text(
                "about_us_paragraph".tr(),
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.end
                ,
              ),
              SizedBox(height: 20),
              Text(
                "our_mission".tr(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "our_mission_paragraph".tr(),
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.end

              ),
              const SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }
}
