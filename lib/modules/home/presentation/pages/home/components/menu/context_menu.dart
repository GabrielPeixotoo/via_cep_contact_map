import 'package:flutter/material.dart';

import '../../../../../../../shared/shared.dart';

class CustomContextMenu extends StatelessWidget {
  final List<String> items;
  final Function(int)? onSelected;

  const CustomContextMenu({
    super.key,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) => PopupMenuButton<int>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        position: PopupMenuPosition.under,
        color: AppColors.white,
        onSelected: onSelected,
        itemBuilder: (_) => items
            .asMap()
            .entries
            .map(
              (item) => PopupMenuItem(
                value: item.key,
                height: 48,
                child: Text(
                  item.value,
                  style: AppTextTheme.subtitle1.copyWith(
                    color: AppColors.black,
                  ),
                ),
              ),
            )
            .toList(),
      );
}
