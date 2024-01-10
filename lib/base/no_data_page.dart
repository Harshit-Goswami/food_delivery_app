import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage(
      {super.key,
      required this.text,
      this.imgPath = "assets/image/empty_cart.jpeg"});
  final String text;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imgPath,
            height: MediaQuery.of(context).size.height * .22,
            width: MediaQuery.of(context).size.width * .22,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * .0175,
                color: Theme.of(context).disabledColor),
            textAlign: TextAlign.center,
          )
        ]);
  }
}
