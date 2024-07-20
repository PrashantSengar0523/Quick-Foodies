import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class SettingDetailBar extends StatelessWidget {
  const SettingDetailBar({
    super.key, this.icon, this.text, this.subText,
  });
  final IconData ?icon;
  final String ?text;
  final String ?subText;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.circular(11)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: TColors.warning.withOpacity(0.1)),
              child: Icon(
                icon,
                color: TColors.warning,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text!,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: TColors.darkerGrey),
                  ),
                  Text(
              subText!,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  color: TColors.darkGrey),
                                ),
                ],
              ),
            ),
            Container(
              height: 45,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: TColors.warning.withOpacity(0.1)),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: TColors.warning,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
