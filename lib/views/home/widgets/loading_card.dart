import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.onSurface.withOpacity(0.2),
      ),
    )
        .animate(
          onComplete: (controller) => controller.repeat(),
        )
        .shimmer(duration: 2.seconds, curve: Curves.easeOutQuad);
  }
}
