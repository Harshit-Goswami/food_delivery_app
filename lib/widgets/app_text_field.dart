
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
   const AppTextField({
    super.key, required this.textController, required this.hintText, required this.icon,
  });

  final TextEditingController textController;
  final String hintText;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.height10, right: Dimensions.height10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(1, 10),
                spreadRadius: 7)
          ]),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide:
                  const BorderSide(width: 1, color: Colors.white)),
          prefixIcon:  Icon(
            icon,
            color: AppColors.yellowColor,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide:
                  const BorderSide(width: 1, color: Colors.white)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            // borderSide: BorderSide(width: 1, color: Colors.white)
          ),
        ),
      ),
    );
  }
}
