/// The success track a repression field belongs to (R-090).
enum RepressionTrack {
  /// Outer left: activist track.
  activists,

  /// Middle: activated by both tracks, using the higher value (Q2).
  both,

  /// Outer right: support track.
  support,
}

/// The repression fields on the board (R-090, positions per board, Q3).
enum RepressionField {
  /// Activist track, field 2.
  activists2(track: RepressionTrack.activists, value: 2),

  /// Activist track, field 8.
  activists8(track: RepressionTrack.activists, value: 8),

  /// Middle track, field 4.
  middle4(track: RepressionTrack.both, value: 4),

  /// Middle track, field 6.
  middle6(track: RepressionTrack.both, value: 6),

  /// Support track, field 7.
  support7(track: RepressionTrack.support, value: 7),

  /// Support track, field 10.
  support10(track: RepressionTrack.support, value: 10);

  new({required this.track, required this.value});

  /// The track the field belongs to.
  final RepressionTrack track;

  /// The track value from which the field is activated.
  final int value;

  /// Whether the field is activated for the given track values.
  bool isActivated({required int activists, required int support}) {
    final trackValue = switch (track) {
      RepressionTrack.activists => activists,
      RepressionTrack.both => activists > support ? activists : support,
      RepressionTrack.support => support,
    };
    return trackValue >= value;
  }
}
