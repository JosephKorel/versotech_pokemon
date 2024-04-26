import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class PokemonDetailsLoadingScreen extends StatelessWidget {
  const PokemonDetailsLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                color: context.onSurface.withOpacity(0.2),
                shape: BoxShape.circle),
          )
              .animate(
                onComplete: (controller) => controller.repeat(),
              )
              .loading
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: context.onSurface.withOpacity(0.2),
                    shape: BoxShape.circle),
              )
                  .animate(
                    onComplete: (controller) => controller.repeat(),
                  )
                  .loading,
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: context.deviceWidth / 2.2,
                      decoration: BoxDecoration(
                        color: context.onSurface.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 48,
                      decoration: BoxDecoration(
                        color: context.onSurface.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 32,
                    width: 72,
                    decoration: BoxDecoration(
                      color: context.onSurface.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const SizedBox.expand(),
                  ),
                )
              ],
            )
                .animate(
                  onComplete: (controller) => controller.repeat(),
                )
                .loading,
            const SizedBox(
              height: 16,
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: context.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const SizedBox.expand(),
              )
                  .animate(
                    onComplete: (controller) => controller.repeat(),
                  )
                  .loading,
            )
          ],
        ),
      ),
    );
  }
}
