import 'package:flutter/material.dart';
import 'package:quick_foodies/utils/constants/colors.dart';

class CustomDialogBox extends StatelessWidget {
  final String text;
  final VoidCallback onCancelPressed;
  final VoidCallback onConfirmPressed;

  const CustomDialogBox({
    super.key,
    required this.text,
    required this.onCancelPressed,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            height: 200,
            width: 200,
            // padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(11.0),
              
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children:[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  const Divider(),
                  TextButton(
                    onPressed: onCancelPressed,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: onConfirmPressed,
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: TColors.buttonPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
