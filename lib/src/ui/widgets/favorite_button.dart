import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final Color borderColor;

  const FavoriteButton({super.key, required this.borderColor});
  @override
  FavoriteButtonState createState() => FavoriteButtonState();
}

class FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  bool isHovered = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: toggleFavorite,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            isFavorite || isHovered ? Icons.favorite : Icons.favorite_border,
            color:
                (isFavorite || isHovered) ? Colors.orange : widget.borderColor,
            size: 24,
          ),
        ),
      ),
    );
  }
}
