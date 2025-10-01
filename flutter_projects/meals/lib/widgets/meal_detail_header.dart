import 'package:flutter/material.dart';

class MealDetailHeader extends StatelessWidget {
  const MealDetailHeader({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      height: 300,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 300,
          color: Colors.grey[300],
          child: const Icon(
            Icons.restaurant,
            size: 80,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
