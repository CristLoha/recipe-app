import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recipe_app/models/menu.dart';
import 'package:recipe_app/utils/app_colors.dart';
import 'package:recipe_app/utils/app_typography.dart';

class RecipeCardItem extends StatelessWidget {
  const RecipeCardItem({super.key, required this.menu});

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 31,
              height: 31,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(menu.imageUser),
                ),
              ),
            ),
            const Gap(8),
            Text(menu.userName, style: AppTypography.small(context)),
          ],
        ),
        const Gap(16),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.0, // 156 / 156
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(menu.imageMenu),
                ),
              ),
            ),
          ),
        ),
        const Gap(8),
        Text(
          menu.nameMenu,
          style: AppTypography.h3(context),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const Gap(8),
        Row(
          children: [
            Text(
              menu.category == Category.Food ? 'Food' : 'Drink',
              style: AppTypography.small(
                context,
              ).copyWith(color: AppColors.secondaryText),
            ),
            const Gap(4),
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.secondaryText,
                shape: BoxShape.circle,
              ),
            ),
            const Gap(4),
            Text(
              '>${menu.duration} mins',
              style: AppTypography.small(
                context,
              ).copyWith(color: AppColors.secondaryText),
            ),
          ],
        ),
      ],
    );
  }
}
