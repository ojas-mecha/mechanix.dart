import 'package:flutter/material.dart';
import 'package:mechanix_widgets/src/widgets/select/select_type.dart';

extension SelectOptionX<T> on T {
  SelectOption<T> toSelectOption(String label,
      {Widget? leading, Widget? trailing}) {
    return SelectOption<T>(
      value: this,
      label: label,
      leading: leading,
      trailing: trailing,
    );
  }
}
