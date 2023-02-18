import 'package:flutter/material.dart';
import 'package:weather/utils/themes.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double? elevation;
  final double? borderRadius;
  final EdgeInsets? padding;
  final double? textSize;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.elevation = 0,
    this.borderRadius = 0,
    this.padding = const EdgeInsets.all(8),
    this.textSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: elevation ?? 0,
      fillColor: kColorBlue,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!)),
      child: Padding(
        padding: padding ??
            const EdgeInsets.only(top: 9, bottom: 10, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.white,
                  fontSize:
                      textSize ?? Theme.of(context).textTheme.labelLarge!.fontSize),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}