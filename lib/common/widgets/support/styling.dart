import 'package:flutter/material.dart';
import 'package:quick_foodies/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';

class TText extends StatelessWidget {
  const TText({
    super.key, this.text, this.color, this.fontWeight, this.fontSize,
  });
  
  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize; // Change the type to double

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '', // Add a null check for text
      style: const TextStyle(
        fontSize: TSizes.md,
        fontWeight: FontWeight.bold,
        color: TColors.black,
        fontFamily: 'Poppins',
      ),
    );
  }
}


class TStyle{
  static TextStyle lightText(){
    return const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: TColors.darkGrey,
              );
  }
}