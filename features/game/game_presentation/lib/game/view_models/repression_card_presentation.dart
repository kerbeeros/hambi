import 'package:game_domain/game_domain.dart';
import 'package:game_presentation/l10n/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

/// How a [RepressionCard] is shown (R-050–R-065).
extension RepressionCardPresentation on RepressionCard {
  /// Visual kind of the card.
  RepressionCardKind get kind => switch (type) {
    RepressionCardType.immediate => RepressionCardKind.immediate,
    RepressionCardType.blocking => RepressionCardKind.blocking,
    RepressionCardType.oneTime => RepressionCardKind.oneTime,
  };

  /// Card title.
  String title(GameLocalizations l10n) => switch (this) {
    RepressionCard.security => l10n.repressionSecurity,
    RepressionCard.raid => l10n.repressionRaid,
    RepressionCard.nightShift => l10n.repressionNightShift,
    RepressionCard.negativePress => l10n.repressionNegativePress,
    RepressionCard.publicProtection => l10n.repressionPublicProtection,
    RepressionCard.legalAid => l10n.repressionLegalAid,
    RepressionCard.internetCensorship => l10n.repressionInternetCensorship,
    RepressionCard.publicityCensorship => l10n.repressionPublicityCensorship,
    RepressionCard.observation => l10n.repressionObservation,
    RepressionCard.confiscation => l10n.repressionConfiscation,
    RepressionCard.threat => l10n.repressionThreat,
    RepressionCard.ban => l10n.repressionBan,
    RepressionCard.internetSurveillance => l10n.repressionInternetSurveillance,
    RepressionCard.assemblyBan => l10n.repressionAssemblyBan,
    RepressionCard.surveillance => l10n.repressionSurveillance,
    RepressionCard.courtOrder => l10n.repressionCourtOrder,
  };

  /// Effect of the card.
  String description(GameLocalizations l10n) => switch (this) {
    RepressionCard.security => l10n.repressionSecurityText,
    RepressionCard.raid => l10n.repressionRaidText,
    RepressionCard.nightShift => l10n.repressionNightShiftText,
    RepressionCard.negativePress => l10n.repressionNegativePressText,
    RepressionCard.publicProtection => l10n.repressionPublicProtectionText,
    RepressionCard.legalAid => l10n.repressionLegalAidText,
    RepressionCard.internetCensorship => l10n.repressionInternetCensorshipText,
    RepressionCard.publicityCensorship =>
      l10n.repressionPublicityCensorshipText,
    RepressionCard.observation => l10n.repressionObservationText,
    RepressionCard.confiscation => l10n.repressionConfiscationText,
    RepressionCard.threat => l10n.repressionThreatText,
    RepressionCard.ban => l10n.repressionBanText,
    RepressionCard.internetSurveillance =>
      l10n.repressionInternetSurveillanceText,
    RepressionCard.assemblyBan => l10n.repressionAssemblyBanText,
    RepressionCard.surveillance => l10n.repressionSurveillanceText,
    RepressionCard.courtOrder => l10n.repressionCourtOrderText,
  };
}
