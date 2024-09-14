import 'package:flutter/material.dart';

class PayServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: Text(
            'Pay and Services',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18, // ফন্ট সাইজটি একটু ছোট করে দেওয়া হয়েছে
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true, // টাইটেলকে উপরে কেন্দ্রস্থ করতে
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Money & Wallet Section with Gradient Background
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [Color(0xFF9872EB), Color(0xFFE871C5)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildServiceCard(
                    iconPath: 'lib/assets/icons/money.png',
                    label: 'Money',
                    onTap: () {
                      // Add Money action here
                    },
                    textColor: Colors.white,
                  ),
                  _buildServiceCard(
                    iconPath: 'lib/assets/icons/wallet.png',
                    label: 'Wallet',
                    subtitle: 'Need to verify identity',
                    onTap: () {
                      // Add Wallet action here
                    },
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            _buildSectionHeader('Financial Services'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('lib/assets/icons/card_repay.png', width: 40, height: 40),
                  SizedBox(height: 8),
                  Text(
                    'Card Repay',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildSectionHeader('Daily Services'),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/top_up.png',
                  label: 'Top Up',
                  onTap: () {
                    // Add Top Up action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/utilities.png',
                  label: 'Utilities',
                  onTap: () {
                    // Add Utilities action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/genz_coins.png',
                  label: 'Gen-Z Coins',
                  onTap: () {
                    // Add Gen-Z Coins action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/charity.png',
                  label: 'Charity',
                  onTap: () {
                    // Add Charity action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/health.png',
                  label: 'Health',
                  onTap: () {
                    // Add Health action here
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildSectionHeader('Travel & Transportation'),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/bus.png',
                  label: 'Bus',
                  onTap: () {
                    // Add Bus action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/hotels.png',
                  label: 'Hotels',
                  onTap: () {
                    // Add Hotels action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/railway.png',
                  label: 'Railway',
                  onTap: () {
                    // Add Railway action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/flight.png',
                  label: 'Flight',
                  onTap: () {
                    // Add Flight action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/metro.png',
                  label: 'Metro',
                  onTap: () {
                    // Add Metro action here
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildSectionHeader('Shopping & Entertainment'),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/shopping_mall.png',
                  label: 'Shopping Mall',
                  onTap: () {
                    // Add Shopping Mall action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/specials.png',
                  label: 'Specials',
                  onTap: () {
                    // Add Specials action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/events_tickets.png',
                  label: 'Events Tickets',
                  onTap: () {
                    // Add Events Tickets action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/lifestyle_retail.png',
                  label: 'Lifestyle & Retail',
                  onTap: () {
                    // Add Lifestyle & Retail action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/buy_together.png',
                  label: 'Buy Together',
                  onTap: () {
                    // Add Buy Together action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/flash_sales.png',
                  label: 'Flash Sales',
                  onTap: () {
                    // Add Flash Sales action here
                  },
                ),
                _buildServiceIcon(
                  iconPath: 'lib/assets/icons/used_goods.png',
                  label: 'Used Goods',
                  onTap: () {
                    // Add Used Goods action here
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String iconPath,
    required String label,
    String? subtitle,
    required VoidCallback onTap,
    Color textColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(iconPath, width: 40, height: 40),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: TextStyle(
                color: textColor.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildServiceIcon({
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 40, height: 40),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
