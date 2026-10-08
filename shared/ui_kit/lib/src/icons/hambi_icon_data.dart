/// Icons of the Hambi design system (`docs/design-tokens.md`, ADR 0007).
enum HambiIconData {
  /// Activist (Mitstreiter*in).
  activist(
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5 6v12c0 1.7 3.1 3 7 3s7-1.3 7-3V6" fill="#1E6BFF" stroke="#0A2E80" stroke-width="1.5"/><ellipse cx="12" cy="6" rx="7" ry="3" fill="#6FA0FF" stroke="#0A2E80" stroke-width="1.5"/></svg>',
  ),

  /// Resource.
  resource(
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 8l8-4 8 4-8 4-8-4z" fill="#8CF5A8" stroke="#0E6B2C" stroke-width="1.5" stroke-linejoin="round"/><path d="M4 8v8l8 4v-8L4 8z" fill="#33E06A" stroke="#0E6B2C" stroke-width="1.5" stroke-linejoin="round"/><path d="M20 8v8l-8 4v-8l8-4z" fill="#22B553" stroke="#0E6B2C" stroke-width="1.5" stroke-linejoin="round"/></svg>',
  ),

  /// Security guard (Secu).
  secu(
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5 6v12c0 1.7 3.1 3 7 3s7-1.3 7-3V6" fill="#222222" stroke="#000000" stroke-width="1.5"/><ellipse cx="12" cy="6" rx="7" ry="3" fill="#555555" stroke="#000000" stroke-width="1.5"/></svg>',
  ),

  /// Public support.
  support(
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="10" fill="#FFD500" stroke="#7A5C00" stroke-width="1.5"/><circle cx="8.5" cy="10" r="1.4" fill="#111111"/><circle cx="15.5" cy="10" r="1.4" fill="#111111"/><path d="M7.5 14.5c1.2 1.8 2.7 2.6 4.5 2.6s3.3-.8 4.5-2.6" stroke="#111111" stroke-width="1.6" stroke-linecap="round"/></svg>',
  ),

  /// Deciduous tree on an intact forest card.
  deciduousTree(
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="10.5" y="14" width="3" height="8" rx="1" fill="#5A1E00"/><circle cx="12" cy="9.5" r="7" fill="#008A00" stroke="#004D00" stroke-width="1.5"/><circle cx="12" cy="9.5" r="3" fill="#33DD33"/></svg>',
  ),

  /// Fir on an intact forest card.
  fir(
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="10.5" y="17" width="3" height="5" rx="1" fill="#5A1E00"/><path d="M12 2L4 18h16L12 2z" fill="#006B2E" stroke="#003D18" stroke-width="1.5" stroke-linejoin="round"/><path d="M12 8l-3.5 7h7L12 8z" fill="#00B04A"/></svg>',
  ),

  /// Tree stump on a cleared forest card.
  stump(
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7 11v8c0 1.1 2.2 2 5 2s5-.9 5-2v-8" fill="#6B3A12" stroke="#3A1A00" stroke-width="1.5"/><ellipse cx="12" cy="11" rx="5" ry="2" fill="#D9A066" stroke="#3A1A00" stroke-width="1.5"/></svg>',
  ),

  /// Opens the game menu.
  menu(
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 6h16M4 12h16M4 18h16" stroke="#111111" stroke-width="2" stroke-linecap="round"/></svg>',
  ),

  /// Opens the round log.
  log(
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="5" y="3" width="14" height="18" rx="2" stroke="#111111" stroke-width="2"/><path d="M8.5 8h7M8.5 12h7M8.5 16h4" stroke="#111111" stroke-width="2" stroke-linecap="round"/></svg>',
  ),

  /// Blocked card.
  lock(
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="5" y="11" width="14" height="10" rx="2" fill="#111111"/><path d="M8 11V8a4 4 0 0 1 8 0v3" stroke="#111111" stroke-width="2"/></svg>',
  ),

  /// Assigned card.
  check(
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5 12.5l4.5 4.5L19 7.5" stroke="#111111" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  );

  new(this.svg);

  /// SVG source of the icon.
  final String svg;
}
