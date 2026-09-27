import 'package:flutter/material.dart';

class CryptoAsset {
  final String name;
  final String symbol;
  final double price;
  final double changePercentage;
  final bool isPositive;
  final List<double> sparklineData;
  final Color primaryColor;
  final Color secondaryColor;
  final IconData icon;

  const CryptoAsset({
    required this.name,
    required this.symbol,
    required this.price,
    required this.changePercentage,
    required this.isPositive,
    required this.sparklineData,
    required this.primaryColor,
    required this.secondaryColor,
    required this.icon,
  });
}

class CheckoutPoint {
  final String label;
  final double value;
  final bool isHighlight;
  final String highlightText;

  const CheckoutPoint({
    required this.label,
    required this.value,
    this.isHighlight = false,
    this.highlightText = '',
  });
}

class BuySellItem {
  final String name;
  final String symbol;
  final double cryptoAmount;
  final double usdRate;
  final Color iconColor;
  final IconData icon;

  const BuySellItem({
    required this.name,
    required this.symbol,
    required this.cryptoAmount,
    required this.usdRate,
    required this.iconColor,
    required this.icon,
  });
}

class CommunityItem {
  final String title;
  final IconData icon;

  const CommunityItem(this.title, this.icon);
}

class ProductItem {
  final String title;

  const ProductItem(this.title);
}

class MockCryptoRepository {
  static List<CryptoAsset> getCards() {
    return [
      const CryptoAsset(
        name: 'Bitcoin',
        symbol: 'BTC',
        price: 24534.47,
        changePercentage: 2.43,
        isPositive: true,
        sparklineData: [20, 25, 22, 35, 30, 48, 42, 60, 55, 75, 70, 85],
        primaryColor: Color(0xFF0072FF),
        secondaryColor: Color(0xFF00C6FF),
        icon: Icons.currency_bitcoin_rounded,
      ),
      const CryptoAsset(
        name: 'Ethereum',
        symbol: 'ETH',
        price: 1727.932,
        changePercentage: -0.30,
        isPositive: false,
        sparklineData: [45, 50, 42, 65, 55, 70, 60, 50, 58, 52, 49, 46],
        primaryColor: Color(0xFFA855F7),
        secondaryColor: Color(0xFFEC4899),
        icon: Icons.diamond_rounded,
      ),
      const CryptoAsset(
        name: 'Tether',
        symbol: 'USDT',
        price: 63.435,
        changePercentage: 3.03,
        isPositive: true,
        sparklineData: [70, 68, 62, 50, 42, 38, 45, 35, 30, 32, 28, 25],
        primaryColor: Color(0xFFFF6452),
        secondaryColor: Color(0xFFFF8E53),
        icon: Icons.attach_money_rounded,
      ),
      const CryptoAsset(
        name: 'XRP',
        symbol: 'XRP',
        price: 40.505,
        changePercentage: 0.26,
        isPositive: true,
        sparklineData: [30, 45, 38, 60, 52, 85, 50, 75, 65, 78, 80, 82],
        primaryColor: Color(0xFF8B5CF6),
        secondaryColor: Color(0xFF6366F1),
        icon: Icons.generating_tokens_rounded,
      ),
    ];
  }

  static List<BuySellItem> getBuySellItems() {
    return [
      const BuySellItem(
        name: 'Bitcoin',
        symbol: 'BTC',
        cryptoAmount: 1.4870395,
        usdRate: 587.21,
        iconColor: Color(0xFFF59E0B),
        icon: Icons.currency_bitcoin_rounded,
      ),
      const BuySellItem(
        name: 'Ethereum',
        symbol: 'ETH',
        cryptoAmount: 2.4760215,
        usdRate: 178.45,
        iconColor: Color(0xFF3B82F6),
        icon: Icons.diamond_rounded,
      ),
      const BuySellItem(
        name: 'Tether',
        symbol: 'USDT',
        cryptoAmount: 68.741006,
        usdRate: 80.435,
        iconColor: Color(0xFF10B981),
        icon: Icons.toll_rounded,
      ),
      const BuySellItem(
        name: 'XRP',
        symbol: 'XRP',
        cryptoAmount: 0.4565688,
        usdRate: 74.505,
        iconColor: Color(0xFF8B5CF6),
        icon: Icons.generating_tokens_rounded,
      ),
    ];
  }

  static List<CheckoutPoint> getCheckoutPoints(String timeframe) {
    switch (timeframe) {
      case 'Day':
        return [
          const CheckoutPoint(label: '02h', value: 35),
          const CheckoutPoint(label: '06h', value: 48),
          const CheckoutPoint(label: '10h', value: 28),
          const CheckoutPoint(
            label: '14h',
            value: 65,
            isHighlight: true,
            highlightText: '95 Checkouts',
          ),
          const CheckoutPoint(label: '18h', value: 40),
          const CheckoutPoint(label: '22h', value: 55),
        ];
      case 'Week':
        return [
          const CheckoutPoint(label: 'Mon', value: 40),
          const CheckoutPoint(label: 'Tue', value: 58),
          const CheckoutPoint(label: 'Wed', value: 32),
          const CheckoutPoint(
            label: 'Thu',
            value: 70,
            isHighlight: true,
            highlightText: '142 Checkouts',
          ),
          const CheckoutPoint(label: 'Fri', value: 45),
          const CheckoutPoint(label: 'Sat', value: 62),
          const CheckoutPoint(label: 'Sun', value: 50),
        ];
      case 'Month':
        return [
          const CheckoutPoint(label: 'W1', value: 45),
          const CheckoutPoint(label: 'W2', value: 60),
          const CheckoutPoint(
            label: 'W3',
            value: 78,
            isHighlight: true,
            highlightText: '380 Checkouts',
          ),
          const CheckoutPoint(label: 'W4', value: 65),
        ];
      case 'Year':
      default:
        return [
          const CheckoutPoint(label: 'Q1', value: 50),
          const CheckoutPoint(label: 'Q2', value: 68),
          const CheckoutPoint(
            label: 'Q3',
            value: 85,
            isHighlight: true,
            highlightText: '1,240 Checkouts',
          ),
          const CheckoutPoint(label: 'Q4', value: 72),
        ];
    }
  }

  static List<CommunityItem> getCommunityItems() {
    return [
      const CommunityItem('Feeds', Icons.dynamic_feed_rounded),
      const CommunityItem('Payment', Icons.payment_rounded),
      const CommunityItem('Articles', Icons.article_rounded),
      const CommunityItem('Exchange', Icons.swap_horiz_rounded),
    ];
  }

  static List<ProductItem> getProductItems() {
    return [
      const ProductItem('Converter'),
      const ProductItem('Job'),
      const ProductItem('Apps'),
      const ProductItem('Rewards'),
      const ProductItem('Airdrops'),
      const ProductItem('Earn'),
      const ProductItem('Blockchain'),
      const ProductItem('Learn'),
    ];
  }
}
