import 'package:flutter/material.dart';

import '../../../common/widgets/customStyle/curved_edge.dart';
import '../../../utils/constants/colors.dart';
import '../../foodWidgets/header.dart';

class FoodDetailHeader extends StatelessWidget {
  const FoodDetailHeader({
    super.key, required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      backgroundColor: TColors.warning,
      child: Container(
        color: TColors.warning,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 340,
          child: Stack(
            children: [
              
              const Header(),
              Center(
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(250),
                  child: Image.network(
                    image,
                    height: 200,
                    width: 350,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

