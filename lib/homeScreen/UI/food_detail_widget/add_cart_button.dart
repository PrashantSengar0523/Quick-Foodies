import 'package:flutter/material.dart';


import '../../../common/widgets/customStyle/curved_edge.dart';
import '../../../utils/constants/colors.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.onTap, // Pass the callback function
  });

  final VoidCallback onTap; // Define the callback type

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      backgroundColor: TColors.warning,
      child: Container(
        color: TColors.white,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 80,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: onTap, // Use the passed callback here
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: TColors.warning.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart, color: TColors.white),
                        SizedBox(width: 10),
                        Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: TColors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
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
