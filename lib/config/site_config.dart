class AgencyConfig {
  static const String agencyNameAr = 'آفاق للسياحة والأسفار';
  static const String agencyNameFr = 'Afaq Tour & Voyages';
  static const String sloganAr = 'رحلتك القادمة تبدأ من هنا';
  static const String sloganFr = 'Votre prochaine aventure commence ici';
  static const String demoNoticeAr = 'نموذج تجريبي — العروض والأسعار للتوضيح فقط';
  static const String demoNoticeFr = 'Modèle de démonstration — offres et tarifs à titre d’illustration uniquement';

  static const String email = 'hello@afaq-demo.com';
  static const String contactPhone = 'رقم واتساب يُحدده العميل لاحقًا';
  static const String contactPhoneFr = 'Numéro WhatsApp à configurer plus tard';
  static const String addressAr = 'الجزائر — يُحدد الموقع لاحقًا';
  static const String addressFr = 'Algérie — à compléter plus tard';

  static const double desktopMaxWidth = 1200;

  static const int primaryDark = 0xFF081C35;
  static const int primaryMid = 0xFF12345A;
  static const int accent = 0xFF4EDAE8;
  static const int accentSoft = 0xFFE8FBFF;
  static const int surface = 0xFFF5F9FF;
  static const int textMuted = 0xFF5D6D82;

  static String contactEmail(Locale locale) => locale.languageCode == 'fr' ? 'hello@afaq-demo.com' : 'hello@afaq-demo.com';
}

class AppBrand {
  static const String nameAr = AgencyConfig.agencyNameAr;
  static const String nameFr = AgencyConfig.agencyNameFr;
  static const String footer = 'تصميم وتطوير Srigina Concept';
  static const String footerFr = 'Conception et développement Srigina Concept';
}
