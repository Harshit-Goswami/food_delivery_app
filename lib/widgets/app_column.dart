import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text_widget.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => const Icon(
                        Icons.star,
                        size: 15,
                        color: AppColors.mainColor,
                      )),
            ),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: '4.5'),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: '1287'),
            const SizedBox(
              width: 10,
            ),
            SmallText(text: 'comments')
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              text: 'Normal',
              icon: Icons.circle_sharp,
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              text: '1.7Km',
              icon: Icons.location_on,
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              text: '32min',
              icon: Icons.access_time_rounded,
              iconColor: AppColors.iconColor2,
            ),
          ],
        ),
      ],
    );
  }
}
