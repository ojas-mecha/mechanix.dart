import 'package:flutter/material.dart';
import '../../theme/variants.dart';

class VariantPicker extends StatelessWidget {
  const VariantPicker({
    super.key,
    this.selectedVariant,
    this.onVariantChanged,
  });

  final MechanixVariant? selectedVariant;
  final ValueChanged<MechanixVariant>? onVariantChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MechanixVariant>(
      icon: const Icon(Icons.colorize),
      tooltip: 'Pick A Variant',
      offset: const Offset(20, 20),
      onSelected: onVariantChanged,
      itemBuilder: (context) {
        return [
          for (final variant in MechanixVariant.values)
            PopupMenuItem<MechanixVariant>(
              value: variant,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: variant.color,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: 20,
                    width: 20,
                  ),
                  Text(variant.name),
                ],
              ),
            )
        ];
      },
    );
  }
}
