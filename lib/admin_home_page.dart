import 'dashboard_page.dart';
import 'add_product_page.dart';
import 'category_page.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  static const Color primary = Color(0xFFFF1654);
  static const Color purple = Color(0xFF7B2FF7);
  static const Color blue = Color(0xFF1597E5);
  static const Color green = Color(0xFF10B981);
  static const Color orange = Color(0xFFFFA000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                child: Column(
                  children: [
                    _buildWelcomeBanner(),
                    const SizedBox(height: 12),
                    _buildMenuGrid(context),
                    const SizedBox(height: 12),
                    _buildAdminFooter(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF315E), Color(0xFFD900FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Center(
              child: Text(
                'K',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'K - Store',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Admin Panel',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  size: 34,
                  color: Color(0xFF111827),
                ),
              ),
              Positioned(
                right: 5,
                top: 3,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 7),
          GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://i.pravatar.cc/150?img=12',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, size: 35),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 1,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      height: 145,
      padding: const EdgeInsets.fromLTRB(20, 20, 12, 15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFE8F0), Color(0xFFFCEEFF)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome, Admin!',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Manage your store from one place',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 125,
                  height: 78,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.65),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 15,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _miniBox(),
                          _miniBox(),
                          _miniBox(),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _miniBox(),
                          _miniBox(),
                          _miniBox(),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 2,
                  bottom: 0,
                  child: Icon(
                    Icons.local_florist,
                    size: 42,
                    color: Colors.green.shade700,
                  ),
                ),
                Positioned(
                  right: 2,
                  bottom: 0,
                  child: Icon(
                    Icons.local_florist,
                    size: 38,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniBox() {
    return Container(
      width: 24,
      height: 14,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    final items = [
      AdminMenuItem('Dashboard', 'Overview & Analytics',
          Icons.home_rounded, primary),
      AdminMenuItem('Products', 'Manage Products',
          Icons.inventory_2_rounded, primary),
      AdminMenuItem('Categories', 'Manage Categories',
          Icons.grid_view_rounded, purple),
      AdminMenuItem('Orders', 'Manage Orders',
          Icons.shopping_cart_rounded, green),
      AdminMenuItem('Customers', 'Customer Management',
          Icons.groups_rounded, blue),
      AdminMenuItem('Offers & Coupons', 'Discounts & Promotions',
          Icons.local_offer_rounded, orange),
      AdminMenuItem('Payments', 'Payment Methods',
          Icons.account_balance_wallet_rounded, purple),
      AdminMenuItem('Delivery & Shipping', 'Courier & Delivery',
          Icons.local_shipping_rounded, orange),
      AdminMenuItem('Custom Orders', 'Manual Orders',
          Icons.assignment_rounded, const Color(0xFF00A6A6)),
      AdminMenuItem('Vendors', 'Manage Vendors',
          Icons.storefront_rounded, purple),
      AdminMenuItem('Resellers', 'Reseller Management',
          Icons.people_alt_rounded, primary),
      AdminMenuItem('Affiliates', 'Affiliate Marketing',
          Icons.share_rounded, green),
      AdminMenuItem('Wallet & Rewards', 'Wallet, Points & Rewards',
          Icons.card_giftcard_rounded, orange),
      AdminMenuItem('Inventory', 'Stock Management',
          Icons.inventory_rounded, blue),
      AdminMenuItem('Reports & Analytics', 'Sales & Reports',
          Icons.bar_chart_rounded, primary),
      AdminMenuItem('Marketing', 'Banners, Notifications',
          Icons.campaign_rounded, blue),
      AdminMenuItem('Notifications', 'Send Notifications',
          Icons.notifications_rounded, purple),
      AdminMenuItem('API & Integrations', 'Third Party Services',
          Icons.extension_rounded, green),
      AdminMenuItem('Staff & Roles', 'Manage Staff & Roles',
          Icons.manage_accounts_rounded, Colors.blueGrey),
      AdminMenuItem('Settings', 'General Settings',
          Icons.settings_rounded, blue),
      AdminMenuItem('Account & Security', 'Profile & Security',
          Icons.security_rounded, primary),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 700 ? 4 : 3;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: crossAxisCount == 3 ? .93 : 1.1,
          ),
          itemBuilder: (context, index) {
            return _buildMenuCard(context, items[index]);
          },
        );
      },
    );
  }

  Widget _buildMenuCard(BuildContext context, AdminMenuItem item) {
    return InkWell(
      borderRadius: BorderRadius.circular(17),
      onTap: () => _openPage(context, item.title),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 8, 10),
        decoration: BoxDecoration(
          color: _lightColor(item.color),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(item.icon, color: Colors.white, size: 27),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right_rounded,
                  color: item.color,
                  size: 28,
                ),
              ],
            ),
            const Spacer(),
            Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              item.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _lightColor(Color color) {
    return Color.alphaBlend(color.withOpacity(.07), Colors.white);
  }

  void _openPage(BuildContext context, String title) {
    if (title == 'Dashboard') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
      return;
    }

    if (title == 'Products') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddProductPage(),
        ),
      );
      return;
    }

if (title == 'Categories') {      Navigator.push(        context,        MaterialPageRoute(          builder: (context) => const CategoryPage(),        ),      );      return;    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title page will be connected next.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildAdminFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: ClipOval(
              child: Image.network(
                'https://i.pravatar.cc/150?img=12',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'admin@kstore.com',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Logout
            },
            icon: const Icon(Icons.logout_rounded, size: 20),
            label: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFE8EF),
              foregroundColor: primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 13,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminMenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  AdminMenuItem(
    this.title,
    this.subtitle,
    this.icon,
    this.color,
  );
}
