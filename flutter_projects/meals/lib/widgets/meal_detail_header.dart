import 'package:flutter/material.dart';

class MealDetailHeader extends StatelessWidget {
  const MealDetailHeader({
    super.key,
    required this.imageUrl,
    required this.heroTag,
  });

  final String imageUrl;
  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Image.network(
        imageUrl,
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Container(
            height: 300,
            color: Colors.black12,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 300,
            color: Colors.black12,
            child: Icon(
              Icons.restaurant,
              size: 80,
              color: Colors.grey[600],
            ),
          );
        },
      ),
    );
  }
}
