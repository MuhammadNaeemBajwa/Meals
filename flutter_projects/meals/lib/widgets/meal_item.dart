import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';

class MealItem extends StatefulWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final Meal meal;
  final void Function() onSelectMeal;
  final bool isFavorite;
  final void Function(Meal meal) onToggleFavorite;

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  void didUpdateWidget(MealItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      _isFavorite = widget.isFavorite;
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onToggleFavorite(widget.meal);
  }

  String get complexityText {
    return widget.meal.complexity.name[0].toUpperCase() +
        widget.meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return widget.meal.affordability.name[0].toUpperCase() +
        widget.meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: widget.onSelectMeal,
        child: Stack(
          children: [
            Image.network(
              widget.meal.imageUrl,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Container(
                  height: 200,
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
                  height: 200,
                  color: Colors.black12,
                  child: Icon(
                    Icons.restaurant,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      widget.meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              size: 17,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${widget.meal.duration} min',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.work,
                              size: 17,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              complexityText,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.attach_money,
                              size: 17,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              affordabilityText,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed: _toggleFavorite,
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                  size: 28,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
