/// Defines the shape variant of the [MechanixButton].
enum MechanixButtonType {
  /// Sharp / minimal corner radius (Square corners)
  square,

  /// Fully rounded pill shape
  rounded,
}

/// Defines the visual style variant of the [MechanixButton].
enum MechanixButtonVariant {
  /// Filled background button style.
  filled,

  /// Outlined border button style with transparent background.
  outline,
}

/// Defines the pre-set sizing scale of the [MechanixButton].
enum MechanixButtonSize { xSmall, small, medium, large, xLarge }

/// Sizing strategy for width or height layout.
enum MechanixButtonSizing {
  /// Hug / fit content tightly based on label and icon.
  hug,

  /// Fill available space (expand to maximum width/height).
  fill,

  /// Fixed explicitly provided dimension value.
  fixed,
}
