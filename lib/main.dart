import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'config/site_config.dart';

void main() {
  runApp(const TravelAgencyApp());
}

class TravelAgencyApp extends StatefulWidget {
  const TravelAgencyApp({super.key});

  @override
  State<TravelAgencyApp> createState() => _TravelAgencyAppState();
}

class _TravelAgencyAppState extends State<TravelAgencyApp> {
  Locale _locale = const Locale('ar');

  void _changeLanguage(Locale value) {
    if (_locale == value) return;
    setState(() => _locale = value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AgencyConfig.agencyNameAr,
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('ar'), Locale('fr')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Tajawal',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AgencyConfig.primaryDark,
          primary: AgencyConfig.primaryDark,
          secondary: AgencyConfig.accent,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: AgencyConfig.primaryDark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE3EBF5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE3EBF5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AgencyConfig.primaryDark, width: 1.5),
          ),
        ),
      ),
      home: HomeScreen(locale: _locale, onLanguageChanged: _changeLanguage),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.locale, required this.onLanguageChanged});

  final Locale locale;
  final ValueChanged<Locale> onLanguageChanged;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('آفاق', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          actions: [
            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TripsScreen(locale: locale, onLanguageChanged: onLanguageChanged))), child: Text(AppText.text('nav_trips', locale))),
            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AboutScreen(locale: locale, onLanguageChanged: onLanguageChanged))), child: Text(AppText.text('nav_about', locale))),
            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactScreen(locale: locale, onLanguageChanged: onLanguageChanged))), child: Text(AppText.text('nav_contact', locale))),
            PopupMenuButton<Locale>(
              tooltip: 'Language',
              icon: const Icon(Icons.language),
              onSelected: onLanguageChanged,
              itemBuilder: (context) => const [
                PopupMenuItem(value: Locale('ar'), child: Text('العربية')),
                PopupMenuItem(value: Locale('fr'), child: Text('Français')),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: FilledButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactScreen(locale: locale, onLanguageChanged: onLanguageChanged))),
                child: Text(AppText.text('cta_contact', locale)),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AgencyConfig.desktopMaxWidth),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEAF5FF), Color(0xFFF8FBFF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(color: const Color(0xFFD7E8FF)),
                                  ),
                                  child: Text(
                                    AgencyConfig.demoNoticeAr,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AgencyConfig.primaryMid),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  AppText.text('hero_title', locale),
                                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: AgencyConfig.primaryDark, height: 1.2),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  AppText.text('hero_subtitle', locale),
                                  style: const TextStyle(fontSize: 16, color: AgencyConfig.textMuted, height: 1.8),
                                ),
                                const SizedBox(height: 22),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    FilledButton(
                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TripsScreen(locale: locale, onLanguageChanged: onLanguageChanged))),
                                      style: FilledButton.styleFrom(backgroundColor: AgencyConfig.primaryDark, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                                      child: Text(AppText.text('cta_discover', locale)),
                                    ),
                                    OutlinedButton(
                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactScreen(locale: locale, onLanguageChanged: onLanguageChanged))),
                                      style: OutlinedButton.styleFrom(foregroundColor: AgencyConfig.primaryDark, side: const BorderSide(color: AgencyConfig.primaryDark), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                                      child: Text(AppText.text('cta_offer', locale)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: SizedBox(
                              height: 520,
                              child: Image.network(
                                'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1100&q=80',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            _SearchPanel(locale: locale),
            const SizedBox(height: 28),
            _SectionTitle(title: AppText.text('featured_title', locale)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AgencyConfig.desktopMaxWidth),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 340,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: 3,
                  itemBuilder: (_, index) => _TripCard(offer: demoTrips[index], locale: locale, onLanguageChanged: onLanguageChanged),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _SectionTitle(title: AppText.text('services_title', locale)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AgencyConfig.desktopMaxWidth),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  children: [
                    _ServiceTile(icon: Icons.map_rounded, title: AppText.text('services_trip', locale), description: locale.languageCode == 'fr' ? 'Organisation complète du circuit et des étapes clés.' : 'تنظيم كامل للبرنامج والمراحل الأساسية.'),
                    _ServiceTile(icon: Icons.hotel_rounded, title: AppText.text('services_hotel', locale), description: locale.languageCode == 'fr' ? 'Choix d’hébergements selon votre budget et vos préférences.' : 'اختيار الإقامة وفق ميزانيتك وتفضيلاتك.'),
                    _ServiceTile(icon: Icons.flight_rounded, title: AppText.text('services_flight', locale), description: locale.languageCode == 'fr' ? 'Réservation des trajets, vols et plans de déplacement.' : 'حجز المسارات والرحلات وخطط التنقل.'),
                    _ServiceTile(icon: Icons.badge_rounded, title: AppText.text('services_visa', locale), description: locale.languageCode == 'fr' ? 'Accompagnement à la préparation et au suivi des demandes.' : 'مرافقة تحضير الطلبات والمتابعة الإدارية.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _SectionTitle(title: AppText.text('how_title', locale)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AgencyConfig.desktopMaxWidth),
                child: Row(
                  children: [
                    Expanded(child: _StepCard(step: '01', title: AppText.text('process_1', locale), detail: locale.languageCode == 'fr' ? 'Choisissez la destination et le style souhaité.' : 'اختر الوجهة ونمط الرحلة المناسب لك.'))),
                    Expanded(child: _StepCard(step: '02', title: AppText.text('process_2', locale), detail: locale.languageCode == 'fr' ? 'Décrivez votre besoin et votre budget.' : 'أرسل احتياجك والميزانية المرغوبة.'))),
                    Expanded(child: _StepCard(step: '03', title: AppText.text('process_3', locale), detail: locale.languageCode == 'fr' ? 'Un conseiller répond avec un plan clair.' : 'يجيب لك مستشار السفر بخطة واضحة ومناسبة.'))),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _SectionTitle(title: AppText.text('advantages_title', locale)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AgencyConfig.desktopMaxWidth),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  children: const [
                    _AdvantageCard(title: 'تخطيط واضح', description: 'خطة منسقة قبل بدء الرحلة وتفاصيل عملية للمرور على كل مرحلة.', icon: Icons.checklist_rounded),
                    _AdvantageCard(title: 'مقاربة مرنة', description: 'الخيارات قابلة للتعديل حسب الميزانية، العدد ونوع النشاط.', icon: Icons.tune_rounded),
                    _AdvantageCard(title: 'تواصل متواصل', description: 'رد سريع، شرح واضح، ومتابعة قبل السفر واستفساراتك.', icon: Icons.support_agent_rounded),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _SectionTitle(title: AppText.text('faq_title', locale)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AgencyConfig.desktopMaxWidth),
                child: Column(
                  children: [
                    _FaqItem(question: AppText.text('faq_q1', locale), answer: AppText.text('faq_a1', locale)),
                    _FaqItem(question: AppText.text('faq_q2', locale), answer: AppText.text('faq_a2', locale)),
                    _FaqItem(question: AppText.text('faq_q3', locale), answer: AppText.text('faq_a3', locale)),
                    _FaqItem(question: AppText.text('faq_q4', locale), answer: AppText.text('faq_a4', locale)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AgencyConfig.desktopMaxWidth),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AgencyConfig.primaryDark,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(26),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            locale.languageCode == 'fr' ? 'Vous avez un projet de voyage ? Nous pouvons vous proposer une formule adaptée.' : 'لديك فكرة رحلة؟ يمكننا تصميم خطة مناسبة لك وفق احتياجك.',
                            style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.7),
                          ),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactScreen(locale: locale, onLanguageChanged: onLanguageChanged))),
                          style: FilledButton.styleFrom(backgroundColor: AgencyConfig.accent, foregroundColor: AgencyConfig.primaryDark),
                          child: Text(AppText.text('cta_contact', locale)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: const Color(0xFFF5F9FF),
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              child: Center(
                child: Text(
                  AppText.text('footer', locale),
                  style: const TextStyle(color: AgencyConfig.primaryDark, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchPanel extends StatelessWidget {
  const _SearchPanel({required this.locale});
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AgencyConfig.desktopMaxWidth),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE7EEF8)),
            boxShadow: const [BoxShadow(color: Color(0x1A1D2C4F), blurRadius: 20, offset: Offset(0, 6))],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 14,
              runSpacing: 14,
              alignment: WrapAlignment.center,
              children: [
                _SearchField(label: AppText.text('search_destination', locale), child: DropdownButtonFormField<String>(
                  value: demoTrips.first.destination(locale),
                  items: demoTrips.map((item) => DropdownMenuItem(value: item.destination(locale), child: Text(item.destination(locale)))).toList(),
                  onChanged: (_) {},
                  decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
                )),
                _SearchField(label: AppText.text('search_trip_type', locale), child: DropdownButtonFormField<String>(
                  value: AppText.text('search_all', locale),
                  items: [
                    DropdownMenuItem(value: AppText.text('search_all', locale), child: Text(AppText.text('search_all', locale))),
                    DropdownMenuItem(value: AppText.text('search_domestic', locale), child: Text(AppText.text('search_domestic', locale))),
                    DropdownMenuItem(value: AppText.text('search_international', locale), child: Text(AppText.text('search_international', locale))),
                  ],
                  onChanged: (_) {},
                  decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
                )),
                _SearchField(label: AppText.text('search_budget', locale), child: DropdownButtonFormField<String>(
                  value: '120000',
                  items: const [
                    DropdownMenuItem(value: '60000', child: Text('60,000 دج')),
                    DropdownMenuItem(value: '90000', child: Text('90,000 دج')),
                    DropdownMenuItem(value: '120000', child: Text('120,000 دج')),
                  ],
                  onChanged: (_) {},
                  decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
                )),
                const SizedBox(height: 20),
                SizedBox(
                  height: 52,
                  child: FilledButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TripsScreen(locale: locale, onLanguageChanged: (value) => {}))),
                    child: Text(AppText.text('search_btn', locale)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key, required this.locale, required this.onLanguageChanged});
  final Locale locale;
  final ValueChanged<Locale> onLanguageChanged;

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  String selectedDestination = 'all';
  String selectedType = 'all';
  int selectedBudget = 150000;

  List<TravelOffer> get filteredOffers {
    return demoTrips.where((offer) {
      final matchesDestination = selectedDestination == 'all' || offer.destination(widget.locale) == selectedDestination;
      final matchesType = selectedType == 'all' || (selectedType == 'domestic' ? offer.isDomestic : !offer.isDomestic);
      final matchesBudget = offer.startingPriceDzd <= selectedBudget;
      return matchesDestination && matchesType && matchesBudget;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final destinations = ['all', ...demoTrips.map((offer) => offer.destination(widget.locale)).toSet().toList()];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppText.text('nav_trips', widget.locale)),
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => Navigator.pop(context)),
          actions: [
            PopupMenuButton<Locale>(
              onSelected: widget.onLanguageChanged,
              icon: const Icon(Icons.language),
              itemBuilder: (context) => const [
                PopupMenuItem(value: Locale('ar'), child: Text('العربية')),
                PopupMenuItem(value: Locale('fr'), child: Text('Français')),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AgencyConfig.desktopMaxWidth),
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(color: const Color(0xFFF2F7FF), borderRadius: BorderRadius.circular(18)),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: 240,
                          child: DropdownButtonFormField<String>(
                            value: selectedDestination,
                            items: [
                              DropdownMenuItem(value: 'all', child: Text(AppText.text('trip_destination_all', widget.locale))),
                              ...destinations.where((item) => item != 'all').map((item) => DropdownMenuItem(value: item, child: Text(item))),
                            ],
                            onChanged: (value) => setState(() => selectedDestination = value ?? 'all'),
                            decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<String>(
                            value: selectedType,
                            items: [
                              DropdownMenuItem(value: 'all', child: Text(AppText.text('search_all', widget.locale))),
                              DropdownMenuItem(value: 'domestic', child: Text(AppText.text('search_domestic', widget.locale))),
                              DropdownMenuItem(value: 'international', child: Text(AppText.text('search_international', widget.locale))),
                            ],
                            onChanged: (value) => setState(() => selectedType = value ?? 'all'),
                            decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
                          ),
                        ),
                        SizedBox(
                          width: 180,
                          child: DropdownButtonFormField<int>(
                            value: selectedBudget,
                            items: const [
                              DropdownMenuItem(value: 60000, child: Text('60,000 دج')),
                              DropdownMenuItem(value: 90000, child: Text('90,000 دج')),
                              DropdownMenuItem(value: 120000, child: Text('120,000 دج')),
                              DropdownMenuItem(value: 150000, child: Text('150,000 دج')),
                            ],
                            onChanged: (value) => setState(() => selectedBudget = value ?? 150000),
                            decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () => setState(() {
                            selectedDestination = 'all';
                            selectedType = 'all';
                            selectedBudget = 150000;
                          }),
                          icon: const Icon(Icons.restart_alt_rounded),
                          label: Text(AppText.text('trip_reset', widget.locale)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                if (filteredOffers.isEmpty)
                  const SizedBox(
                    height: 200,
                    child: Center(child: Text('لا توجد رحلات مطابقة للفلاتر الحالية.')),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 360,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: filteredOffers.length,
                    itemBuilder: (_, index) => _TripCard(offer: filteredOffers[index], locale: widget.locale, onLanguageChanged: widget.onLanguageChanged),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen({super.key, required this.offer, required this.locale, required this.onLanguageChanged});
  final TravelOffer offer;
  final Locale locale;
  final ValueChanged<Locale> onLanguageChanged;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(offer.destination(locale)),
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => Navigator.pop(context)),
          actions: [
            PopupMenuButton<Locale>(
              onSelected: onLanguageChanged,
              icon: const Icon(Icons.language),
              itemBuilder: (context) => const [
                PopupMenuItem(value: Locale('ar'), child: Text('العربية')),
                PopupMenuItem(value: Locale('fr'), child: Text('Français')),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AgencyConfig.desktopMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: SizedBox(
                    height: 420,
                    child: PageView.builder(
                      itemCount: offer.gallery.length,
                      itemBuilder: (_, index) => Image.network(offer.gallery[index], fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(offer.destination(locale), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: AgencyConfig.primaryDark)),
                const SizedBox(height: 8),
                Text(locale.languageCode == 'fr' ? offer.summaryFr : offer.summaryAr, style: const TextStyle(color: AgencyConfig.textMuted, fontSize: 16, height: 1.8)),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _DetailPill(icon: Icons.location_on_outlined, text: '${AppText.text('trip_departure', locale)}: ${offer.departureCity(locale)}'),
                    _DetailPill(icon: Icons.calendar_month_rounded, text: '${AppText.text('trip_duration', locale)}: ${offer.duration}'),
                    _DetailPill(icon: Icons.flag_circle_rounded, text: '${AppText.text('trip_type', locale)}: ${offer.travelType(locale)}'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Text('${AppText.text('trip_price_from', locale)}: ${formatPrice(offer.startingPriceDzd, locale)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AgencyConfig.primaryDark)),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactScreen(locale: locale, onLanguageChanged: onLanguageChanged, preselectedTrip: offer))),
                      style: FilledButton.styleFrom(backgroundColor: AgencyConfig.primaryDark, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14)),
                      child: Text(AppText.text('trip_contact_btn', locale)),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: () async {
                        final url = Uri.parse('https://wa.me/?text=${buildWhatsAppMessage(offer: offer, locale: locale)}');
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      },
                      icon: const Icon(Icons.whatsapp_rounded),
                      style: IconButton.styleFrom(backgroundColor: const Color(0xFF25D366), foregroundColor: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(AppText.text('trip_price_note', locale), style: const TextStyle(color: AgencyConfig.textMuted, fontSize: 13)),
                const SizedBox(height: 20),
                _SubSection(title: AppText.text('trip_itinerary', locale), child: Column(
                  children: offer.itinerary.map((day) => ExpansionTile(
                    title: Text(day.title(locale), style: const TextStyle(fontWeight: FontWeight.w700)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Text(day.details(locale), style: const TextStyle(color: AgencyConfig.textMuted, height: 1.8)),
                      ),
                    ],
                  )).toList(),
                )),
                const SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _SubSection(title: AppText.text('trip_service_included', locale), child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: offer.included.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle_rounded, color: Colors.green, size: 18),
                              const SizedBox(width: 8),
                              Expanded(child: Text(item)),
                            ],
                          ),
                        )).toList(),
                      )),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _SubSection(title: AppText.text('trip_service_excluded', locale), child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: offer.excluded.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.close_rounded, color: Colors.red, size: 18),
                              const SizedBox(width: 8),
                              Expanded(child: Text(item)),
                            ],
                          ),
                        )).toList(),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, required this.locale, required this.onLanguageChanged});
  final Locale locale;
  final ValueChanged<Locale> onLanguageChanged;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppText.text('about_title', locale)),
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => Navigator.pop(context)),
          actions: [
            PopupMenuButton<Locale>(
              onSelected: onLanguageChanged,
              icon: const Icon(Icons.language),
              itemBuilder: (context) => const [
                PopupMenuItem(value: Locale('ar'), child: Text('العربية')),
                PopupMenuItem(value: Locale('fr'), child: Text('Français')),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AgencyConfig.desktopMaxWidth),
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(color: const Color(0xFFEAF6FF), borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.all(26),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppText.text('about_title', locale), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AgencyConfig.primaryDark)),
                              const SizedBox(height: 12),
                              Text(AppText.text('about_desc', locale), style: const TextStyle(color: AgencyConfig.textMuted, fontSize: 16, height: 1.8)),
                            ],
                          ),
                        ),
                        const CircleAvatar(radius: 50, backgroundColor: AgencyConfig.accent, child: Icon(Icons.travel_explore_rounded, size: 50, color: AgencyConfig.primaryDark)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 1.2,
                  children: [
                    _AdvantageCard(title: AppText.text('about_focus', locale), description: AppText.text('about_text_1', locale), icon: Icons.lightbulb_rounded),
                    _AdvantageCard(title: AppText.text('about_focus', locale), description: AppText.text('about_text_2', locale), icon: Icons.route_rounded),
                    _AdvantageCard(title: AppText.text('about_focus', locale), description: AppText.text('about_text_3', locale), icon: Icons.headset_mic_rounded),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key, required this.locale, required this.onLanguageChanged, this.preselectedTrip});
  final Locale locale;
  final ValueChanged<Locale> onLanguageChanged;
  final TravelOffer? preselectedTrip;

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _destinationController = TextEditingController();
  final _dateController = TextEditingController();
  final _travelersController = TextEditingController();
  final _notesController = TextEditingController();
  final _contactController = TextEditingController();
  String _contactMode = 'واتساب';

  @override
  void initState() {
    super.initState();
    if (widget.preselectedTrip != null) {
      _destinationController.text = widget.preselectedTrip!.destination(widget.locale);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _destinationController.dispose();
    _dateController.dispose();
    _travelersController.dispose();
    _notesController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppText.text('contact_title', widget.locale)),
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => Navigator.pop(context)),
          actions: [
            PopupMenuButton<Locale>(
              onSelected: widget.onLanguageChanged,
              icon: const Icon(Icons.language),
              itemBuilder: (context) => const [
                PopupMenuItem(value: Locale('ar'), child: Text('العربية')),
                PopupMenuItem(value: Locale('fr'), child: Text('Français')),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    color: const Color(0xFFF5F9FF),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppText.text('contact_info', widget.locale), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AgencyConfig.primaryDark)),
                          const SizedBox(height: 14),
                          _ContactInfoRow(icon: Icons.email_rounded, text: AgencyConfig.contactEmail),
                          _ContactInfoRow(icon: Icons.phone_rounded, text: AgencyConfig.contactPhone),
                          _ContactInfoRow(icon: Icons.location_on_rounded, text: AgencyConfig.addressAr),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  flex: 2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(AppText.text('contact_title', widget.locale), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AgencyConfig.primaryDark)),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(labelText: AppText.text('form_name', widget.locale)),
                              validator: (value) => (value == null || value.trim().isEmpty) ? (widget.locale.languageCode == 'fr' ? 'Veuillez renseigner votre nom.' : 'يرجى إدخال الاسم.') : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _contactController,
                              decoration: InputDecoration(labelText: AppText.text('form_contact', widget.locale)),
                              validator: (value) => (value == null || value.trim().isEmpty) ? (widget.locale.languageCode == 'fr' ? 'Indiquez un moyen de contact.' : 'يرجى إدخال وسيلة التواصل.') : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _destinationController,
                              decoration: InputDecoration(labelText: AppText.text('form_destination', widget.locale)),
                              validator: (value) => (value == null || value.trim().isEmpty) ? (widget.locale.languageCode == 'fr' ? 'Saisissez une destination.' : 'يرجى إدخال الوجهة.') : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _dateController,
                              decoration: InputDecoration(labelText: AppText.text('form_date', widget.locale)),
                              validator: (value) => (value == null || value.trim().isEmpty) ? (widget.locale.languageCode == 'fr' ? 'Précisez la période souhaitée.' : 'يرجى إدخال تاريخ السفر التقريبي.') : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _travelersController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(labelText: AppText.text('form_people', widget.locale)),
                              validator: (value) => (value == null || value.trim().isEmpty) ? (widget.locale.languageCode == 'fr' ? 'Indiquez le nombre de voyageurs.' : 'يرجى إدخال عدد المسافرين.') : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _notesController,
                              maxLines: 4,
                              decoration: InputDecoration(labelText: AppText.text('form_notes', widget.locale)),
                            ),
                            const SizedBox(height: 20),
                            FilledButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) return;
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text(widget.locale.languageCode == 'fr' ? 'Modèle de démonstration' : 'نموذج تجريبي'),
                                    content: Text(AppText.text('demo_message', widget.locale)),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context), child: Text(widget.locale.languageCode == 'fr' ? 'Fermer' : 'إغلاق')),
                                    ],
                                  ),
                                );
                              },
                              style: FilledButton.styleFrom(backgroundColor: AgencyConfig.primaryDark, padding: const EdgeInsets.symmetric(vertical: 16)),
                              child: Text(AppText.text('form_submit', widget.locale)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, color: AgencyConfig.primaryDark)),
          ),
          child,
        ],
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.offer, required this.locale, required this.onLanguageChanged});
  final TravelOffer offer;
  final Locale locale;
  final ValueChanged<Locale> onLanguageChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TripDetailScreen(offer: offer, locale: locale, onLanguageChanged: onLanguageChanged))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              width: double.infinity,
              child: Image.network(offer.gallery.first, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(offer.destination(locale), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AgencyConfig.primaryDark))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(color: AgencyConfig.accentSoft, borderRadius: BorderRadius.circular(999)),
                        child: Text(AppText.text('demo_badge', locale), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AgencyConfig.primaryDark)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('${offer.departureCity(locale)} • ${offer.duration}', style: const TextStyle(color: AgencyConfig.textMuted, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Text(locale.languageCode == 'fr' ? offer.summaryFr : offer.summaryAr, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AgencyConfig.textMuted, height: 1.6)),
                  const SizedBox(height: 14),
                  Text(formatPrice(offer.startingPriceDzd, locale), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AgencyConfig.primaryDark)),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TripDetailScreen(offer: offer, locale: locale, onLanguageChanged: onLanguageChanged))),
                    style: FilledButton.styleFrom(backgroundColor: AgencyConfig.primaryDark, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12)),
                    child: Text(locale.languageCode == 'fr' ? 'Voir le voyage' : 'عرض التفاصيل'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: AgencyConfig.primaryDark)),
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.icon, required this.title, required this.description});
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: AgencyConfig.accentSoft, borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, color: AgencyConfig.primaryDark),
            ),
            const SizedBox(height: 18),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AgencyConfig.primaryDark)),
            const SizedBox(height: 10),
            Text(description, style: const TextStyle(color: AgencyConfig.textMuted, height: 1.7)),
          ],
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step, required this.title, required this.detail});
  final String step;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(step, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AgencyConfig.accent)),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AgencyConfig.primaryDark)),
            const SizedBox(height: 10),
            Text(detail, style: const TextStyle(color: AgencyConfig.textMuted, height: 1.7)),
          ],
        ),
      ),
    );
  }
}

class _AdvantageCard extends StatelessWidget {
  const _AdvantageCard({required this.title, required this.description, required this.icon});
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(color: AgencyConfig.accentSoft, borderRadius: BorderRadius.circular(14)),
              child: Icon(icon, color: AgencyConfig.primaryDark),
            ),
            const SizedBox(height: 18),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AgencyConfig.primaryDark)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: AgencyConfig.textMuted, height: 1.7)),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  const _FaqItem({required this.question, required this.answer});
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.w700, color: AgencyConfig.primaryDark)),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [Text(answer, style: const TextStyle(color: AgencyConfig.textMuted, height: 1.7))],
      ),
    );
  }
}

class _DetailPill extends StatelessWidget {
  const _DetailPill({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xFFF2F7FF), borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AgencyConfig.primaryDark),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: AgencyConfig.primaryDark, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _SubSection extends StatelessWidget {
  const _SubSection({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: const Color(0xFFF7F9FC), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AgencyConfig.primaryDark)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _ContactInfoRow extends StatelessWidget {
  const _ContactInfoRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AgencyConfig.primaryDark),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: AgencyConfig.primaryDark, height: 1.7))),
        ],
      ),
    );
  }
}

class AppText {
  static const Map<String, Map<String, String>> _strings = {
    'nav_home': {'ar': 'الرئيسية', 'fr': 'Accueil'},
    'nav_trips': {'ar': 'الرحلات', 'fr': 'Offres'},
    'nav_about': {'ar': 'عن الوكالة', 'fr': 'À propos'},
    'nav_contact': {'ar': 'التواصل', 'fr': 'Contact'},
    'cta_contact': {'ar': 'تواصل معنا', 'fr': 'Contactez-nous'},
    'cta_offer': {'ar': 'اطلب عرضًا خاصًا', 'fr': 'Demander un devis'},
    'cta_discover': {'ar': 'اكتشف الرحلات', 'fr': 'Découvrir les voyages'},
    'hero_title': {'ar': 'رحلتك القادمة تبدأ من هنا', 'fr': 'Votre prochaine aventure commence ici'},
    'hero_subtitle': {'ar': 'نصمم لك تجربة سفر هادئة، أنيقة، ومناسبة لخطتك، من الاستشارة إلى عودة المسافر.', 'fr': 'Nous concevons pour vous une expérience de voyage sereine, élégante et adaptée à votre budget, de l’étude à votre retour.'},
    'search_destination': {'ar': 'الوجهة', 'fr': 'Destination'},
    'search_trip_type': {'ar': 'نوع الرحلة', 'fr': 'Type de voyage'},
    'search_budget': {'ar': 'الميزانية', 'fr': 'Budget'},
    'search_all': {'ar': 'الكل', 'fr': 'Tous'},
    'search_domestic': {'ar': 'داخلي', 'fr': 'Interne'},
    'search_international': {'ar': 'خارجي', 'fr': 'Internationale'},
    'search_btn': {'ar': 'ابحث عن رحلات', 'fr': 'Chercher des voyages'},
    'featured_title': {'ar': 'عروض مميزة', 'fr': 'Offres phare'},
    'services_title': {'ar': 'خدماتنا', 'fr': 'Nos services'},
    'services_trip': {'ar': 'رحلات منظمة', 'fr': 'Voyages organisés'},
    'services_hotel': {'ar': 'حجوزات فنادق', 'fr': 'Réservations hôtelières'},
    'services_flight': {'ar': 'تذاكر طيران', 'fr': 'Billets d’avion'},
    'services_visa': {'ar': 'مرافقة التأشيرة', 'fr': 'Accompagnement visa'},
    'how_title': {'ar': 'كيف تحجز معنا؟', 'fr': 'Comment réserver ?'},
    'process_1': {'ar': 'اختر الرحلة', 'fr': 'Choisissez le voyage'},
    'process_2': {'ar': 'أرسل طلبك', 'fr': 'Envoyez votre demande'},
    'process_3': {'ar': 'تواصل مع مستشار', 'fr': 'Parlez à un conseiller'},
    'advantages_title': {'ar': 'لماذا نوفر تجربة مريحة؟', 'fr': 'Pourquoi une expérience fluide ?'},
    'faq_title': {'ar': 'الأسئلة الشائعة', 'fr': 'Questions fréquentes'},
    'faq_q1': {'ar': 'هل يمكن طلب الرحلة حسب الميزانية؟', 'fr': 'Peut-on personnaliser le voyage selon le budget ?'},
    'faq_a1': {'ar': 'نعم، نبدأ من الفكرة إلى أولوية الميزانية ونتيح لك خيارات مناسبة دون إغفال الجودة.', 'fr': 'Oui, nous partons de votre idée puis ajustons le voyage à votre budget sans sacrifier la qualité.'},
    'faq_q2': {'ar': 'هل أستطيع تعديل برنامج الرحلة؟', 'fr': 'Puis-je modifier le programme ?'},
    'faq_a2': {'ar': 'نعم، يمكن تعديل المدة أو المرافق أو نقطة الانطلاق حسب ما تفضله.', 'fr': 'Oui, la durée, les services ou le point de départ peuvent être ajustés selon vos préférences.'},
    'faq_q3': {'ar': 'هل أستطيع الحصول على معلومات قبل التنقل؟', 'fr': 'Des informations sont-elles fournies avant le départ ?'},
    'faq_a3': {'ar': 'بالتأكيد، نوفر لك ملخصًا عمليًا عن البرنامج، الخدمات، والتنقل قبل التعاقد.', 'fr': 'Oui, nous vous remettons un résumé pratique sur le programme, les services et les déplacements avant la confirmation.'},
    'faq_q4': {'ar': 'هل يمكن طلب استفسار سريع عبر واتساب؟', 'fr': 'Peut-on demander un devis rapide via WhatsApp ?'},
    'faq_a4': {'ar': 'نعم، يمكنك إرسال طلبك مباشرة ووضع الرقم المفضل لاحقًا في إعدادات الموقع.', 'fr': 'Oui, vous pouvez envoyer votre demande directement, et le numéro WhatsApp est configuré dans les réglages du site.'},
    'contact_title': {'ar': 'اطلب عرضًا خاصًا', 'fr': 'Demander un devis personnalisé'},
    'contact_info': {'ar': 'معلومات التواصل', 'fr': 'Informations de contact'},
    'form_name': {'ar': 'الاسم', 'fr': 'Nom'},
    'form_contact': {'ar': 'وسيلة التواصل', 'fr': 'Moyen de contact'},
    'form_destination': {'ar': 'الوجهة', 'fr': 'Destination'},
    'form_date': {'ar': 'تاريخ السفر التقريبي', 'fr': 'Date de voyage approximative'},
    'form_people': {'ar': 'عدد المسافرين', 'fr': 'Nombre de voyageurs'},
    'form_notes': {'ar': 'ملاحظات إضافية', 'fr': 'Notes supplémentaires'},
    'form_submit': {'ar': 'إرسال الطلب', 'fr': 'Envoyer la demande'},
    'demo_message': {'ar': 'هذا نموذج تجريبي؛ لم يتم إرسال طلبك. في الموقع النهائي يصل الطلب إلى الوكالة.', 'fr': 'Ceci est un modèle de démonstration ; votre demande n’a pas été envoyée. Sur le site final, la demande sera transmise à l’agence.'},
    'about_title': {'ar': 'عن الوكالة', 'fr': 'À propos de l’agence'},
    'about_desc': {'ar': 'نصمم رحلات هادئة ومفصلة وفق احتياجك، مع التركيز على التنقل، الاستجمام، ومعايير السلامة والراحة.', 'fr': 'Nous concevons des voyages sereins et détaillés selon vos besoins, avec un souci constant du confort, de la sécurité et de la qualité de l’expérience.'},
    'about_focus': {'ar': 'تجاربنا', 'fr': 'Nos priorités'},
    'about_text_1': {'ar': 'استشارة مبدئية وتخطيط رحلات مناسبة للطابع الشخصي.', 'fr': 'Conseil initial et planification de voyages adaptés au profil de chacun.'},
    'about_text_2': {'ar': 'تنظيم مسار الرحلة مع خيارات النقل والإقامة والأنشطة.', 'fr': 'Organisation du parcours avec options de transport, hébergement et activités.'},
    'about_text_3': {'ar': 'دعم واضح أثناء الاستفسار قبل السفر وبعده.', 'fr': 'Support clair avant le départ et pendant la préparation.'},
    'trip_destination_all': {'ar': 'كل الوجهات', 'fr': 'Toutes les destinations'},
    'trip_reset': {'ar': 'إعادة ضبط الفلاتر', 'fr': 'Réinitialiser les filtres'},
    'trip_type': {'ar': 'نوع الرحلة', 'fr': 'Type de voyage'},
    'trip_departure': {'ar': 'مدينة الانطلاق', 'fr': 'Ville de départ'},
    'trip_duration': {'ar': 'المدة', 'fr': 'Durée'},
    'trip_price_from': {'ar': 'السعر الابتدائي', 'fr': 'À partir de'},
    'trip_price_note': {'ar': 'السعر تجريبي وقد يختلف حسب التاريخ والتوفر.', 'fr': 'Prix à titre de démonstration et susceptible de varier selon les dates et la disponibilité.'},
    'trip_service_included': {'ar': 'الخدمات المشمولة', 'fr': 'Services inclus'},
    'trip_service_excluded': {'ar': 'خدمات غير مشمولة', 'fr': 'Services non inclus'},
    'trip_itinerary': {'ar': 'البرنامج اليومي', 'fr': 'Programme journalier'},
    'trip_contact_btn': {'ar': 'استفسر عن هذه الرحلة', 'fr': 'Demander ce voyage'},
    'trip_filter_empty': {'ar': 'لا توجد رحلات مطابقة للفلاتر الحالية.', 'fr': 'Aucune offre ne correspond aux filtres actuels.'},
    'demo_badge': {'ar': 'تجريبي', 'fr': 'Démo'},
    'footer': {'ar': 'تصميم وتطوير Srigina Concept', 'fr': 'Conception et développement Srigina Concept'},
  };

  static String text(String key, Locale locale) => _strings[key]?[locale.languageCode] ?? _strings[key]?['ar'] ?? key;
}

class TravelOffer {
  final String id;
  final String destinationAr;
  final String destinationFr;
  final String departureCityAr;
  final String departureCityFr;
  final String duration;
  final bool isDomestic;
  final int startingPriceDzd;
  final String summaryAr;
  final String summaryFr;
  final List<String> gallery;
  final List<String> included;
  final List<String> excluded;
  final List<ItineraryDay> itinerary;

  const TravelOffer({
    required this.id,
    required this.destinationAr,
    required this.destinationFr,
    required this.departureCityAr,
    required this.departureCityFr,
    required this.duration,
    required this.isDomestic,
    required this.startingPriceDzd,
    required this.summaryAr,
    required this.summaryFr,
    required this.gallery,
    required this.included,
    required this.excluded,
    required this.itinerary,
  });

  String destination(Locale locale) => locale.languageCode == 'fr' ? destinationFr : destinationAr;
  String departureCity(Locale locale) => locale.languageCode == 'fr' ? departureCityFr : departureCityAr;
  String travelType(Locale locale) => locale.languageCode == 'fr' ? (isDomestic ? 'Interne' : 'Internationale') : (isDomestic ? 'داخلي' : 'خارجي');
}

class ItineraryDay {
  final String titleAr;
  final String titleFr;
  final String detailsAr;
  final String detailsFr;

  const ItineraryDay({
    required this.titleAr,
    required this.titleFr,
    required this.detailsAr,
    required this.detailsFr,
  });

  String title(Locale locale) => locale.languageCode == 'fr' ? titleFr : titleAr;
  String details(Locale locale) => locale.languageCode == 'fr' ? detailsFr : detailsAr;
}

final List<TravelOffer> demoTrips = [
  TravelOffer(
    id: 'istanbul',
    destinationAr: 'إسطنبول',
    destinationFr: 'Istanbul',
    departureCityAr: 'الجزائر العاصمة',
    departureCityFr: 'Alger',
    duration: '4 أيام / 3 ليال',
    isDomestic: false,
    startingPriceDzd: 89000,
    summaryAr: 'رحلة عائلية ممتعة تجمع بين المتنزهات التاريخية، التسوق والهدوء في قلب المدينة.',
    summaryFr: 'Un voyage familial agréable qui mélange monuments, shopping et moments de détente au cœur de la ville.',
    gallery: [
      'https://images.unsplash.com/photo-1527838832700-5059252407fa?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1543349689-9a4d426bee8e?auto=format&fit=crop&w=1200&q=80',
    ],
    included: ['إقامة 3 ليال', 'نقل داخلي', 'وجبة إفطار يومية', 'خدمة إرشاد'],
    excluded: ['تذكرة الطيران', 'التأشيرات', 'الأنشطة الاختيارية', 'النقل الخاص'],
    itinerary: [
      ItineraryDay(titleAr: 'اليوم الأول', titleFr: 'Jour 1', detailsAr: 'استقبال في المطار وتنقل إلى الفندق مع إطلاع سريع على المنطقة.', detailsFr: 'Accueil à l’aéroport, transfert vers l’hôtel et briefing de la zone.'),
      ItineraryDay(titleAr: 'اليوم الثاني', titleFr: 'Jour 2', detailsAr: 'زيارة أحياء المدينة والجامع الأزرق مع وقت حر في التسوق.', detailsFr: 'Visite du centre historique et de la mosquée bleue, puis temps libre pour shopping.'),
      ItineraryDay(titleAr: 'اليوم الثالث', titleFr: 'Jour 3', detailsAr: 'جولة في قصر طوب قابي وبحيرة قوجه أيلي.', detailsFr: 'Parcours au palais de Topkapı et au lac de Gülhane.'),
      ItineraryDay(titleAr: 'اليوم الرابع', titleFr: 'Jour 4', detailsAr: 'استقبال نهائي وعودة إلى الجزائر.', detailsFr: 'Retour final vers Alger avec assistance à l’aéroport.'),
    ],
  ),
  TravelOffer(
    id: 'tunis',
    destinationAr: 'تونس',
    destinationFr: 'Tunis',
    departureCityAr: 'وهران',
    departureCityFr: 'Oran',
    duration: '3 أيام / 2 ليال',
    isDomestic: false,
    startingPriceDzd: 64000,
    summaryAr: 'خطة قصيرة ومريحة لرحلة ساحلية تجمع بين الثقافة والتمتع بالطبيعة.',
    summaryFr: 'Un court séjour balnéaire et culturel, pensé pour un voyage simple et agréable.',
    gallery: [
      'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1200&q=80',
    ],
    included: ['إقامة 2 ليال', 'خدمة نقل من المطار', 'تجهيز بطاقات', 'مرافقة قبل الوصول'],
    excluded: ['تذاكر الطيران', 'الأنشطة المخصصة', 'المشتريات', 'الملابس الشخصية'],
    itinerary: [
      ItineraryDay(titleAr: 'اليوم الأول', titleFr: 'Jour 1', detailsAr: 'استقبال في تونس وزيارة المدينة العتيقة.', detailsFr: 'Accueil à Tunis et visite du centre historique.'),
      ItineraryDay(titleAr: 'اليوم الثاني', titleFr: 'Jour 2', detailsAr: 'رحلة بحرية قصيرة مع جلسة استرخاء.', detailsFr: 'Sortie côtière avec pause détente et baignade.'),
      ItineraryDay(titleAr: 'اليوم الثالث', titleFr: 'Jour 3', detailsAr: 'زيارة نهائية والعودة إلى الجزائر.', detailsFr: 'Visites finales puis retour vers l’Algérie.'),
    ],
  ),
  TravelOffer(
    id: 'dubai',
    destinationAr: 'دبي',
    destinationFr: 'Dubaï',
    departureCityAr: 'سطيف',
    departureCityFr: 'Sétif',
    duration: '5 أيام / 4 ليال',
    isDomestic: false,
    startingPriceDzd: 112000,
    summaryAr: 'رحلة عصرية تناسب محبي المعالم الحديثة والأنشطة الهادئة.',
    summaryFr: 'Un séjour moderne idéal pour les voyageurs qui aiment les grands axes urbains et les activités relaxantes.',
    gallery: [
      'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1518684079-3c830dcef090?auto=format&fit=crop&w=1200&q=80',
    ],
    included: ['إقامة احترافية', 'تذاكر دخول مختارة', 'خدمة استقبال', 'خطة متكاملة'],
    excluded: ['التأشيرة', 'النقل الخاص', 'الأنشطة الإضافية', 'الإفطار في بعض الفنادق'],
    itinerary: [
      ItineraryDay(titleAr: 'اليوم الأول', titleFr: 'Jour 1', detailsAr: 'استقبال في دبي وإقامتك في منطقة مناسبة.', detailsFr: 'Accueil à Dubaï et installation dans le quartier choisi.'),
      ItineraryDay(titleAr: 'اليوم الثاني', titleFr: 'Jour 2', detailsAr: 'زيارة برج خليفة والحديقة المائية.', detailsFr: 'Parcours du Burj Khalifa et du parc aquatique.'),
      ItineraryDay(titleAr: 'اليوم الثالث', titleFr: 'Jour 3', detailsAr: 'رحلة إلى جزر دبي مع نزهة بحرية.', detailsFr: 'Jour de détente sur les îles de Dubaï.'),
      ItineraryDay(titleAr: 'اليوم الرابع', titleFr: 'Jour 4', detailsAr: 'مزيج بين التسوق والأنشطة الروتينية.', detailsFr: 'Shopping, détente et activités libres.'),
      ItineraryDay(titleAr: 'اليوم الخامس', titleFr: 'Jour 5', detailsAr: 'عودة متدرجة إلى المطار.', detailsFr: 'Retour progressif vers l’aéroport.'),
    ],
  ),
  TravelOffer(
    id: 'gant',
    destinationAr: 'جانت',
    destinationFr: 'Ghent',
    departureCityAr: 'الجزائر',
    departureCityFr: 'Alger',
    duration: '6 أيام / 5 ليال',
    isDomestic: false,
    startingPriceDzd: 123000,
    summaryAr: 'رحلة ثقافية أوروبية تجمع بين التشريفات التاريخية والمدينة النابضة بالحياة.',
    summaryFr: 'Un voyage culturel européen entre patrimoine historique et vie urbaine animée.',
    gallery: [
      'https://images.unsplash.com/photo-1505761671935-60b3a7427bad?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?auto=format&fit=crop&w=1200&q=80',
    ],
    included: ['إقامة مريحة', 'تجهيز وثائق', 'نقل من المطار', 'خطة يومية'],
    excluded: ['تذاكر الطيران', 'النقل الداخلي', 'مصاريف شخصية', 'الأنشطة الاختيارية'],
    itinerary: [
      ItineraryDay(titleAr: 'اليوم الأول', titleFr: 'Jour 1', detailsAr: 'استقبال مبدئي واستكشاف الحي القديم.', detailsFr: 'Accueil et découverte du vieux centre.'),
      ItineraryDay(titleAr: 'اليوم الثاني', titleFr: 'Jour 2', detailsAr: 'جولات ثقافية في الكنائس والمنشآت المعمارية.', detailsFr: 'Visites de monuments et patrimoine local.'),
      ItineraryDay(titleAr: 'اليوم الثالث', titleFr: 'Jour 3', detailsAr: 'نزهة في المدينة ووقت حر.', detailsFr: 'Promenade libre et loisirs urbains.'),
      ItineraryDay(titleAr: 'اليوم الرابع', titleFr: 'Jour 4', detailsAr: 'التجول بين الأحياء والمقاهي.', detailsFr: 'Exploration des quartiers et cafés.'),
      ItineraryDay(titleAr: 'اليوم الخامس', titleFr: 'Jour 5', detailsAr: 'زيارة إضافية أو يوم استرخاء.', detailsFr: 'Journée libre ou activité complémentaire.'),
      ItineraryDay(titleAr: 'اليوم السادس', titleFr: 'Jour 6', detailsAr: 'العودة إلى البلد.', detailsFr: 'Retour vers l’Algérie.'),
    ],
  ),
  TravelOffer(
    id: 'timimoun',
    destinationAr: 'تيميمون',
    destinationFr: 'Timimoun',
    departureCityAr: 'تمنراست',
    departureCityFr: 'Tamanrasset',
    duration: '3 أيام / 2 ليال',
    isDomestic: true,
    startingPriceDzd: 34000,
    summaryAr: 'رحلة داخلية مريحة للهواء الجاف والمناظر الصحراوية الآسرة.',
    summaryFr: 'Un voyage intérieur au rythme calme, pensé pour la découverte du désert et de ses paysages.',
    gallery: [
      'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1200&q=80',
    ],
    included: ['إقامة', 'خطة تنقل داخلية', 'ترتيبات من المطار', 'جلسات إرشادية'],
    excluded: ['الأنشطة الاختيارية', 'الوجبات الإضافية', 'الملابس الشخصية', 'الرحلات الفردية'],
    itinerary: [
      ItineraryDay(titleAr: 'اليوم الأول', titleFr: 'Jour 1', detailsAr: 'وصولك إلى المدينة وحديث عن المناطق السياحية.', detailsFr: 'Arrivée et prise en charge de la visite du centre.'),
      ItineraryDay(titleAr: 'اليوم الثاني', titleFr: 'Jour 2', detailsAr: 'جولة صحراوية ومواعيد استرخاء.', detailsFr: 'Découverte du désert et temps de repos.'),
      ItineraryDay(titleAr: 'اليوم الثالث', titleFr: 'Jour 3', detailsAr: 'عودة إلى نقطة الانطلاق.', detailsFr: 'Retour progressif vers le point de départ.'),
    ],
  ),
  TravelOffer(
    id: 'bejaia',
    destinationAr: 'بجاية',
    destinationFr: 'Béjaïa',
    departureCityAr: 'سطيف',
    departureCityFr: 'Sétif',
    duration: '4 أيام / 3 ليال',
    isDomestic: true,
    startingPriceDzd: 51000,
    summaryAr: 'رحلة ساحلية داخلية تجمع بين البحر، المأكولات المحلية والراحة.',
    summaryFr: 'Un séjour côtier intérieur au rythme calme, idéal pour la plage, la gastronomie locale et la détente.',
    gallery: [
      'https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=1200&q=80',
      'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=1200&q=80',
    ],
    included: ['إقامة فندقية', 'خطة ممتعة', 'استقبال في المطار', 'تنقل محلي'],
    excluded: ['الأفلام والأنشطة', 'التذاكر المحمولة', 'الوجبات غير المدرجة', 'الرحلات الاستثنائية'],
    itinerary: [
      ItineraryDay(titleAr: 'اليوم الأول', titleFr: 'Jour 1', detailsAr: 'استقبال في المطار ثم توزيع في الفندق.', detailsFr: 'Accueil et installation dans l’établissement.'),
      ItineraryDay(titleAr: 'اليوم الثاني', titleFr: 'Jour 2', detailsAr: 'جولة على شواطئ المدينة والواجهة البحرية.', detailsFr: 'Visite des plages et promenade sur le front de mer.'),
      ItineraryDay(titleAr: 'اليوم الثالث', titleFr: 'Jour 3', detailsAr: 'رحلة قصيرة إلى مناطق طبيعية ودورات ثقافية.', detailsFr: 'Sortie vers les sites naturels et culturels.'),
      ItineraryDay(titleAr: 'اليوم الرابع', titleFr: 'Jour 4', detailsAr: 'عودة تدريجية من المؤسسة.', detailsFr: 'Retour progressif vers le point de départ.'),
    ],
  ),
];

String formatPrice(int price, Locale locale) {
  final formatted = price.toString().replaceAllMapped(RegExp(r'\B(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]} ');
  return '$formatted ${locale.languageCode == 'fr' ? 'DZD' : 'دج'}';
}

String buildWhatsAppMessage({TravelOffer? offer, required Locale locale}) {
  final tripName = offer == null ? (locale.languageCode == 'fr' ? 'Voyage souhaité' : 'رحلة مطلوبة') : offer.destination(locale);
  final text = locale.languageCode == 'fr' ? 'Bonjour, je souhaite obtenir des informations sur le voyage: $tripName.' : 'مرحبًا، أود الاستفسار عن رحلة: $tripName.';
  return Uri.encodeComponent(text);
}
