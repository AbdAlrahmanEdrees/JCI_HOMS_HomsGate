import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constanat/colors.dart';
import 'customimage.dart';

class CustomPropertyCard extends StatelessWidget {
  final String cover;
  final String title;
  final String street;
  final String location;
  final String price;
  final bool isfav;
  final bool isuserproperty;
  final String istrad;
  final String ownertybe;
  final void Function() onFavPressed;
  final void Function() onDeletePressed;
  final void Function() onUpdatePressed;

  const CustomPropertyCard({
    super.key,
    required this.cover,
    required this.title,
    required this.street,
    required this.location,
    required this.price,
    required this.isfav,
    required this.onFavPressed,
    required this.onDeletePressed,
    required this.onUpdatePressed,
    required this.isuserproperty,
    required this.istrad,
    required this.ownertybe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(10.s[]),
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.1, 0.5),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width / 2,
      height: 280.sp,
      child: Column(
        children: [
          Stack(
            children: [
              cover.isNotEmpty
                  ? CustomCachedImage(
                    imageurl: cover,
                    height: 150.sp,
                    width: double.infinity,
                  )
                  : Container(
                    height: 150.sp,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                  ),
              Positioned(
                left: 280.w,
                top: 10.sp,
                child:
                    !isuserproperty
                        ? IconButton(
                          icon:
                              isfav
                                  ? Icon(Icons.favorite, color: Colors.red)
                                  : Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                          onPressed: onFavPressed,
                        )
                        : PopupMenuButton<String>(
                          icon: Icon(Icons.menu),
                          onSelected: (String value) {
                            switch (value) {
                              case 'delete':
                                onDeletePressed();
                                break;
                              case 'update':
                                onUpdatePressed();
                                break;
                            }
                          },
                          itemBuilder:
                              (BuildContext context) => [
                                const PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text('حذف'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'update',
                                  child: Text('تعديل'),
                                ),
                              ],
                        ),
              ),
            ],
          ),
          SizedBox(height: 10.sp),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Text(
                                "4.5",
                                style: TextStyle(color: AppColors.greencolor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      street,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "TejwalBold",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_history,
                          color: AppColors.greencolor,
                        ),
                        Text(
                          location,
                          style: const TextStyle(color: AppColors.greencolor),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(ownertybe),
                    Text(istrad, style: TextStyle(color: Colors.green)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            color: AppColors.greencolor,
                            fontFamily: "TejwalBold",
                          ),
                        ),
                        const Text(
                          "السعر النهائي:  ",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontFamily: "Tejwal",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
