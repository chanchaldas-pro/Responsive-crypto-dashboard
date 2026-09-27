import 'package:flutter/material.dart';
import '../models/crypto_data.dart';
import '../theme/app_theme.dart';
import '../widgets/hero_banner_card.dart';
import '../widgets/crypto_card.dart';
import '../widgets/checkout_chart_card.dart';
import '../widgets/buy_sell_card.dart';
import '../widgets/wallet_panel.dart';
import '../widgets/sidebar_navigation.dart';
import '../widgets/mobile_navigation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedNavIndex = 0;
  String _searchQuery = '';
  late List<CryptoAsset> _allCards;
  @override
  void initState() {
    super.initState();
    _allCards = MockCryptoRepository.getCards();
  }

  List<CryptoAsset> get _filteredCards {
    if (_searchQuery.trim().isEmpty) return _allCards;
    return _allCards.where((asset) {
      final q = _searchQuery.toLowerCase();
      return asset.name.toLowerCase().contains(q) ||
          asset.symbol.toLowerCase().contains(q);
    }).toList();
  }

  void _handleNewBidding() {
    showDialog(
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? AppColors.darkCard : AppColors.lightCard,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
          title: const Row(
            children: [
              Icon(Icons.gavel_rounded, color: AppColors.vibrantCoral),
              SizedBox(width: 10),
              Text(
                'Place New Bid',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Submit an auction bid for live crypto orders directly on the orderbook.',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Amount (USDT)',
                  hintText: 'e.g. 5,000.00',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.vibrantCoral,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    content: const Text(
                      'Bidding order placed successfully!',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.vibrantCoral,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Confirm Bid'),
            ),
          ],
        );
      },
    );
  }

  void _handleSend() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.vibrantCoral,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Transferred 26,247.00 BKASD to destination wallet!',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth >= 768 && screenWidth < 1200;
        final isMobile = screenWidth < 768;

        if (isMobile) {
          return _buildMobileScaffold();
        } else if (isTablet) {
          return _buildTabletScaffold();
        } else {
          return _buildDesktopScaffold();
        }
      },
    );
  }

  Widget _buildDesktopScaffold() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Sidebar Navigation (Expanded)
          SidebarNavigation(
            selectedIndex: _selectedNavIndex,
            onDestinationSelected: (idx) => setState(() => _selectedNavIndex = idx),
            isCollapsed: false,
          ),

          // Center Scrollable Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Banner with Frosted Glass Search Bar
                  HeroBannerCard(
                    onSearchChanged: (query) => setState(() => _searchQuery = query),
                    onNewBiddingPressed: _handleNewBidding,
                  ),

                  const SizedBox(height: 24),

                  // 4 Crypto Cards Row
                  _buildCryptoCardsRow(columns: 4),

                  const SizedBox(height: 24),

                  // Bottom Grid: Checkout Chart & Buy/Sell Card
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Checkout Chart
                      const Expanded(
                        flex: 3,
                        child: CheckoutChartCard(),
                      ),

                      const SizedBox(width: 20),

                      // Buy / Sell
                      Expanded(
                        flex: 2,
                        child: BuySellCard(
                          onSupportPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Connecting to 24/7 Crypto Support...')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Right Column: Wallet Panel
          SizedBox(
            width: 330,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
              child: WalletPanel(
                onSendPressed: _handleSend,
                onAddNewPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add New Wallet modal opened.')),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletScaffold() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Sidebar (Compact / Icons only)
          SidebarNavigation(
            selectedIndex: _selectedNavIndex,
            onDestinationSelected: (idx) => setState(() => _selectedNavIndex = idx),
            isCollapsed: true,
          ),

          // Main Scrollable Area containing center content and wallet
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Banner
                  HeroBannerCard(
                    onSearchChanged: (query) => setState(() => _searchQuery = query),
                    onNewBiddingPressed: _handleNewBidding,
                  ),

                  const SizedBox(height: 20),

                  // 4 Crypto Cards in 2x2 Grid
                  _buildCryptoCardsGrid(crossAxisCount: 2),

                  const SizedBox(height: 20),

                  // Checkout Chart
                  const CheckoutChartCard(),

                  const SizedBox(height: 20),

                  // Side-by-side Buy/Sell and Wallet
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BuySellCard(
                          onSupportPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Connecting to 24/7 Crypto Support...')),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: WalletPanel(
                          onSendPressed: _handleSend,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileScaffold() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: MobileAppBar(
        onOpenDrawer: () => Scaffold.of(context).openDrawer(),
      ),
      drawer: Drawer(
        backgroundColor: isDark ? AppColors.darkSidebar : AppColors.lightSidebar,
        child: SafeArea(
          child: SidebarNavigation(
            selectedIndex: _selectedNavIndex,
            onDestinationSelected: (idx) {
              setState(() => _selectedNavIndex = idx);
              Navigator.pop(context); // Close drawer
            },
            isCollapsed: false,
          ),
        ),
      ),
      bottomNavigationBar: MobileNavigationBar(
        selectedIndex: _selectedNavIndex,
        onDestinationSelected: (idx) => setState(() => _selectedNavIndex = idx),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner with Frosted Glass Search Bar
            HeroBannerCard(
              onSearchChanged: (query) => setState(() => _searchQuery = query),
              onNewBiddingPressed: _handleNewBidding,
            ),

            const SizedBox(height: 20),

            // Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Watchlist Assets',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                ),
                Text(
                  '${_filteredCards.length} tokens',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.white54 : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Horizontal Scroll for crypto cards on mobile
            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filteredCards.length,
                separatorBuilder: (_, index) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 170,
                    child: CryptoCard(
                      asset: _filteredCards[index],
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Checkout Wave Chart
            const CheckoutChartCard(),

            const SizedBox(height: 20),

            // Buy / Sell
            BuySellCard(
              onSupportPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Connecting to 24/7 Crypto Support...')),
                );
              },
            ),

            const SizedBox(height: 20),

            // Wallet Panel (Embedded vertically on mobile)
            WalletPanel(
              onSendPressed: _handleSend,
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCryptoCardsRow({required int columns}) {
    final cards = _filteredCards;
    if (cards.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: const Text('No cryptocurrencies match your search.'),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: List.generate(cards.length, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < cards.length - 1 ? 16.0 : 0.0,
                ),
                child: SizedBox(
                  height: 185,
                  child: CryptoCard(
                    asset: cards[index],
                    onTap: () {},
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildCryptoCardsGrid({required int crossAxisCount}) {
    final cards = _filteredCards;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cards.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (context, index) {
        return CryptoCard(
          asset: cards[index],
          onTap: () {},
        );
      },
    );
  }
}
