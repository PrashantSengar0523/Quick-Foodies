
import 'package:flutter/material.dart';

import '../common/styles/spacing_styles.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';

class SuccessScreeen extends StatelessWidget {
  const SuccessScreeen(
      {super.key,
      this.image,
      required this.title,
      required this.subtitle,
      required this.onPressed});
  final String ?image, title, subtitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              //   Lottie.asset(image,
              //   width: MediaQuery.of(context).size.width * 0.6,
              // ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Text(
                title!,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(subtitle!,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(TColors.warning),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                    side: WidgetStateProperty.all<BorderSide>(BorderSide.none),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: onPressed, child: const Text(TTexts.tContinue)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
