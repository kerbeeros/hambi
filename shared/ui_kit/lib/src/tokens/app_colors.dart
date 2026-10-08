import 'package:flutter/painting.dart';

/// Semantic colors of the Hambi design system.
///
/// Values are defined in `docs/design-tokens.md` and derived from the
/// original print-and-play game material. Widgets must only use these
/// semantic tokens, never raw [Color] literals.
abstract final class AppColors {
  /// Scaffold background (paper).
  static const bgApp = Color(0xFFF7F3EA);

  /// Cards, sheets and dialogs.
  static const bgSurface = Color(0xFFFFFFFF);

  /// Header and forest area.
  static const bgBoard = Color(0xFF336600);

  /// Default text.
  static const textPrimary = Color(0xFF111111);

  /// Helper text.
  static const textSecondary = Color(0xFF77756F);

  /// Text on [bgBoard] and [actionPrimary].
  static const textOnDark = Color(0xFFFFFFFF);

  /// Strong borders, e.g. an assigned card.
  static const borderDefault = Color(0xFF111111);

  /// Regular borders.
  static const borderSubtle = Color(0xFFE2E0DA);

  /// Forest card that is still intact.
  static const forestIntact = Color(0xFF00CC00);

  /// Forest card that has been cleared.
  static const forestCleared = Color(0xFF9A6633);

  /// Forest card that has been removed.
  static const forestRemoved = Color(0xFF4A1A00);

  /// Direct action card (condition area).
  static const cardDirectAction = Color(0xFF00FF66);

  /// Direct action card (effect area).
  static const cardDirectActionEffect = Color(0xFF80FFAA);

  /// Campaign card (condition area).
  static const cardCampaign = Color(0xFFFFFF00);

  /// Campaign card (effect area).
  static const cardCampaignEffect = Color(0xFFFFFF80);

  /// Support card (condition area).
  static const cardSupport = Color(0xFF66CCFF);

  /// Support card (effect area).
  static const cardSupportEffect = Color(0xFFB3E5FF);

  /// Camp card.
  static const cardCamp = Color(0xFF00CC00);

  /// Repression card.
  static const cardRepression = Color(0xFFFFFFFF);

  /// Activist marker.
  static const tokenActivist = Color(0xFF1E6BFF);

  /// Resource marker.
  static const tokenResource = Color(0xFF33E06A);

  /// Security marker.
  static const tokenSecu = Color(0xFF222222);

  /// Filled cells of the activists track.
  static const trackActivists = Color(0xFF3399FF);

  /// Filled cells of the public support track.
  static const trackSupport = Color(0xFFFFD500);

  /// Marker of a repression field on a track.
  static const trackRepressionField = Color(0xFFE8231E);

  /// Blocked card, excavator target, errors.
  static const stateBlocked = Color(0xFFE8231E);

  /// Empty track cells and disabled elements.
  static const stateDisabled = Color(0xFFE2E0DA);

  /// Primary button background.
  static const actionPrimary = Color(0xFF336600);

  /// Content on [actionPrimary].
  static const actionOnPrimary = Color(0xFFFFFFFF);
}
