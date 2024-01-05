import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  const IconAndTextWidget(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.text});

  final IconData icon;
  final Color iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize24,
        ),
        const SizedBox(width: 5),
        SmallText(
          text: text,
        )
      ],
    );
  }
}
