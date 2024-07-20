import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quick_foodies/login&SignupScreen/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: const CachedNetworkImageProvider(
                    'https://i.postimg.cc/63Bk6CYB/fourth.png'), // Replace with your image path
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), // Adjust opacity here
                  BlendMode.darken,
                ),
              ),
            ),
            child: const Stack(
              children: [
              ],
            ),
          ),
          Stack(children: [
            CachedNetworkImage(
              imageUrl:
                  'https://i.postimg.cc/63Bk6CYB/fourth.png', // Replace with your image URL
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8), // Adjust opacity as needed
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),

            const SignupForm(),
          ]),
        ],
      ),
    );
  }
}

