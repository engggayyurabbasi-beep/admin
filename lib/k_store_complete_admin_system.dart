import 'package:flutter/material.dart';

/// K Store Admin - single file admin system.
/// Demo/in-memory UI architecture. Backend/API can be connected later.

class ProductItem {
  ProductItem(this.id, this.name, this.category, this.price, this.stock, this.status);
  String id, name, category, status;
  double price;
  int stock;
}

class CategoryItem {
  CategoryItem(this.id, this.name, this.products, this.status);
  String id, name, status;
  int products;
}

class OrderItem {
  OrderItem(this.id, this.customer, this.amount, this.status, this.payment);
  String id, customer, status, payment;
  double amount;
}

class CustomerItem {
  CustomerItem(this.id, this.name, this.email, this.status, this.orders);
  String id, name, email, status;
  int orders;
}

class OfferItem {
  OfferItem(this.code, this.description, this.value, this.status);
  String code, description, status;
  double value;
}

class VendorItem {
  VendorItem(this.id, this.name, this.email, this.status);
  String id, name, email, status;
}

class ResellerItem {
  ResellerItem(this.id, this.name, this.email, this.status);
  String id, name, email, status;
}

class AffiliateItem {
  AffiliateItem(this.id, this.name, this.email, this.earnings, this.status);
  String id, name, email, status;
  double earnings;
}

class CustomOrderItem {
  CustomOrderItem(this.id, this.customer, this.request, this.status);
  String id, customer, request, status;
}

class NotificationItem {
  NotificationItem(this.title, this.message, this.enabled);
  String title, message;
  bool enabled;
}

class StaffItem {
  StaffItem(this.id, this.name, this.email, this.role, this.active);
  String id, name, email, role;
  bool active;
}

class KStoreAdminData {
  KStoreAdminData({
    List<ProductItem>? products,
    List<CategoryItem>? categories,
    List<OrderItem>? orders,
    List<CustomerItem>? customers,
    List<OfferItem>? offers,
    List<VendorItem>? vendors,
    List<ResellerItem>? resellers,
    List<AffiliateItem>? affiliates,
    List<CustomOrderItem>? customOrders,
    List<NotificationItem>? notifications,
    List<StaffItem>? staff,
  })  : products = products ?? _demoProducts(),
        categories = categories ?? _demoCategories(),
        orders = orders ?? _demoOrders(),
        customers = customers ?? _demoCustomers(),
        offers = offers ?? _demoOffers(),
        vendors = vendors ?? _demoVendors(),
        resellers = resellers ?? _demoResellers(),
        affiliates = affiliates ?? _demoAffiliates(),
        customOrders = customOrders ?? _demoCustomOrders(),
        notifications = notifications ?? _demoNotifications(),
        staff = staff ?? _demoStaff();

  final List<ProductItem> products;
  final List<CategoryItem> categories;
  final List<OrderItem> orders;
  final List<CustomerItem> customers;
  final List<OfferItem> offers;
  final List<VendorItem> vendors;
  final List<ResellerItem> resellers;
  final List<AffiliateItem> affiliates;
  final List<CustomOrderItem> customOrders;
  final List<NotificationItem> notifications;
  final List<StaffItem> staff;
}

List<ProductItem> _demoProducts() => [
  ProductItem('P001', 'Wheat Atta 10kg', 'Grocery', 499, 42, 'Active'),
  ProductItem('P002', 'Herbal Hair Oil', 'Herbal', 380, 18, 'Active'),
  ProductItem('P003', 'Slim Trimz Powder', 'Herbal', 270, 7, 'Low Stock'),
  ProductItem('P004', 'Hanicyst Syrup', 'Herbal', 599, 25, 'Active'),
];

List<CategoryItem> _demoCategories() => [
  CategoryItem('C001', 'Grocery', 24, 'Active'),
  CategoryItem('C002', 'Herbal', 18, 'Active'),
  CategoryItem('C003', 'Personal Care', 12, 'Active'),
  CategoryItem('C004', 'Wellness', 9, 'Active'),
];

List<OrderItem> _demoOrders() => [
  OrderItem('ORD-1001', 'Rahul Kumar', 1299, 'Processing', 'Paid'),
  OrderItem('ORD-1002', 'Aman Khan', 799, 'Shipped', 'Paid'),
  OrderItem('ORD-1003', 'Sana Ali', 1599, 'Delivered', 'Paid'),
  OrderItem('ORD-1004', 'Vikas Singh', 499, 'Pending', 'COD'),
];

List<CustomerItem> _demoCustomers() => [
  CustomerItem('U001', 'Rahul Kumar', 'rahul@example.com', 'Active', 8),
  CustomerItem('U002', 'Aman Khan', 'aman@example.com', 'Active', 5),
  CustomerItem('U003', 'Sana Ali', 'sana@example.com', 'Active', 12),
  CustomerItem('U004', 'Vikas Singh', 'vikas@example.com', 'Blocked', 2),
];

List<OfferItem> _demoOffers() => [
  OfferItem('WELCOME100', 'Welcome discount', 100, 'Active'),
  OfferItem('SAVE200', 'Flat saving offer', 200, 'Active'),
  OfferItem('FREESHIP', 'Free delivery', 0, 'Active'),
];

List<VendorItem> _demoVendors() => [
  VendorItem('V001', 'Al-Hind Supplies', 'vendor@example.com', 'Approved'),
  VendorItem('V002', 'KIRZ Wholesale', 'wholesale@example.com', 'Pending'),
];

List<ResellerItem> _demoResellers() => [
  ResellerItem('R001', 'Mohit Store', 'mohit@example.com', 'Active'),
  ResellerItem('R002', 'Sana Reseller', 'sana.r@example.com', 'Active'),
];

List<AffiliateItem> _demoAffiliates() => [
  AffiliateItem('A001', 'Aamir', 'aamir@example.com', 4200, 'Active'),
  AffiliateItem('A002', 'Neha', 'neha@example.com', 1850, 'Pending'),
];

List<CustomOrderItem> _demoCustomOrders() => [
  CustomOrderItem('CO001', 'Rahul Kumar', 'Bulk herbal combo', 'New'),
  CustomOrderItem('CO002', 'Sana Ali', 'Custom gift pack', 'Processing'),
];

List<NotificationItem> _demoNotifications() => [
  NotificationItem('Order Confirmed', 'Order confirmation notification', true),
  NotificationItem('Order Shipped', 'Shipment update notification', true),
  NotificationItem('Payment Failed', 'Payment failure notification', true),
  NotificationItem('Welcome', 'Welcome notification', false),
];

List<StaffItem> _demoStaff() => [
  StaffItem('S001', 'Admin User', 'admin@kstore.com', 'Admin', true),
  StaffItem('S002', 'Support Staff', 'support@kstore.com', 'Support', true),
  StaffItem('S003', 'Operations', 'ops@kstore.com', 'Operations', false),
];

class KStoreAdminSystem extends StatefulWidget {
  const KStoreAdminSystem({super.key, this.data});

  final KStoreAdminData? data;

  @override
  State<KStoreAdminSystem> createState() => _KStoreAdminSystemState();
}

class _KStoreAdminSystemState extends State<KStoreAdminSystem> {
  late final KStoreAdminData data;
  int selectedIndex = 0;

  final List<String> modules = const [
    'Dashboard',
    'Products',
    'Categories',
    'Orders',
    'Customers',
    'Offers & Coupons',
    'Payments',
    'Delivery & Shipping',
    'Custom Orders',
    'Vendors',
    'Resellers',
    'Affiliates',
    'Wallet & Rewards',
    'Inventory',
    'Reports',
    'Marketing',
    'Notifications',
    'API & Integrations',
    'Staff & Roles',
    'Settings',
    'Account & Security',
  ];

  @override
  void initState() {
    super.initState();
    data = widget.data ?? KStoreAdminData();
  }

  Widget _page() {
    switch (selectedIndex) {
      case 0:
        return DashboardModule(data: data);
      case 1:
        return ProductsModule(data: data);
      case 2:
        return CategoriesModule(data: data);
      case 3:
        return OrdersModule(data: data);
      case 4:
        return CustomersModule(data: data);
      case 5:
        return OffersModule(data: data);
      case 6:
        return PaymentsModule(data: data);
      case 7:
        return DeliveryModule(data: data);
      case 8:
        return CustomOrdersModule(data: data);
      case 9:
        return VendorsModule(data: data);
      case 10:
        return ResellersModule(data: data);
      case 11:
        return AffiliatesModule(data: data);
      case 12:
        return WalletRewardsModule(data: data);
      case 13:
        return InventoryModule(data: data);
      case 14:
        return ReportModule(data: data);
      case 15:
        return MarketingModule(data: data);
      case 16:
        return NotificationModule(data: data);
      case 17:
        return ApiModule(data: data);
      case 18:
        return StaffRoleModule(data: data);
      case 19:
        return SettingsModule(data: data);
      case 20:
        return AccountSecurityModule(data: data);
      default:
        return DashboardModule(data: data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('K - Store Admin'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Text(
                    'K - Store\nAdmin Panel',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: modules.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Icon(_moduleIcon(index)),
                    title: Text(modules[index]),
                    selected: index == selectedIndex,
                    onTap: () {
                      setState(() => selectedIndex = index);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _page(),
    );
  }

  IconData _moduleIcon(int index) {
    const icons = [
      Icons.dashboard_outlined,
      Icons.inventory_2_outlined,
      Icons.category_outlined,
      Icons.shopping_bag_outlined,
      Icons.people_outline,
      Icons.local_offer_outlined,
      Icons.payments_outlined,
      Icons.local_shipping_outlined,
      Icons.assignment_outlined,
      Icons.store_outlined,
      Icons.groups_outlined,
      Icons.campaign_outlined,
      Icons.account_balance_wallet_outlined,
      Icons.warehouse_outlined,
      Icons.assessment_outlined,
      Icons.campaign_outlined,
      Icons.notifications_outlined,
      Icons.api_outlined,
      Icons.badge_outlined,
      Icons.settings_outlined,
      Icons.security_outlined,
    ];
    return icons[index];
  }
}

class ModuleShell extends StatelessWidget {
  const ModuleShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class _ModuleHeader extends StatelessWidget {
  const _ModuleHeader({
    required this.title,
    required this.subtitle,
    this.actions = const [],
  });

  final String title;
  final String subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text(subtitle),
              ],
            ),
          ),
          ...actions,
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.items});
  final List<List<dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = items[index];
          return SizedBox(
            width: 160,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(item[2] as IconData, size: 28),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item[1]}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('${item[0]}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({
    required this.title,
    required this.icon,
    required this.items,
  });

  final String title;
  final IconData icon;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(item),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Text(text),
        ),
      );
}

class StatCard extends StatelessWidget {
  const StatCard(this.title, this.value, this.icon, {super.key});
  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _DataCard extends StatelessWidget {
  const _DataCard({
    required this.title,
    required this.subtitle,
    this.icon = Icons.circle_outlined,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class DashboardModule extends StatelessWidget {
  const DashboardModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    final revenue = data.orders.fold<double>(0, (sum, order) => sum + order.amount);
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Dashboard',
            subtitle: 'K - Store business overview',
          ),
          _StatsRow(items: [
            ['Products', data.products.length, Icons.inventory_2_outlined],
            ['Orders', data.orders.length, Icons.shopping_bag_outlined],
            ['Customers', data.customers.length, Icons.people_outline],
            ['Revenue', '₹${revenue.toStringAsFixed(0)}', Icons.payments_outlined],
          ]),
          const SizedBox(height: 16),
          _ReportCard(
            title: 'Quick Overview',
            icon: Icons.insights_outlined,
            items: [
              '${data.categories.length} categories',
              '${data.vendors.length} vendors',
              '${data.resellers.length} resellers',
              '${data.affiliates.length} affiliates',
            ],
          ),
        ],
      ),
    );
  }
}

class ProductsModule extends StatefulWidget {
  const ProductsModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<ProductsModule> createState() => _ProductsModuleState();
}

class _ProductsModuleState extends State<ProductsModule> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final rows = widget.data.products
        .where(
          (p) => '${p.name} ${p.category} ${p.id}'
              .toLowerCase()
              .contains(query.toLowerCase()),
        )
        .toList();

    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ModuleHeader(
            title: 'Products',
            subtitle: 'Manage product catalogue and stock',
            actions: [
              IconButton(
                onPressed: () => _showMessage(context, 'Add Product'),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search products',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => query = value),
          ),
          const SizedBox(height: 12),
          ...rows.map(
            (p) => _DataCard(
              title: '${p.name} • ${p.id}',
              subtitle:
                  '₹${p.price.toStringAsFixed(0)} • ${p.stock} units • ${p.status}',
              icon: Icons.inventory_2_outlined,
            ),
          ),
          if (rows.isEmpty) const EmptyBox(text: 'No products found'),
        ],
      ),
    );
  }
}

class CategoriesModule extends StatelessWidget {
  const CategoriesModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Categories',
            subtitle: 'Manage product categories',
          ),
          ...data.categories.map(
            (c) => _DataCard(
              title: '${c.name} • ${c.id}',
              subtitle: '${c.products} products • ${c.status}',
              icon: Icons.category_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class OrdersModule extends StatefulWidget {
  const OrdersModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<OrdersModule> createState() => _OrdersModuleState();
}

class _OrdersModuleState extends State<OrdersModule> {
  String query = '';
  String status = 'All';

  @override
  Widget build(BuildContext context) {
    final rows = widget.data.orders.where((o) {
      final matchesQuery =
          '${o.id} ${o.customer}'.toLowerCase().contains(query.toLowerCase());
      final matchesStatus = status == 'All' || o.status == status;
      return matchesQuery && matchesStatus;
    }).toList();

    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Orders',
            subtitle: 'Search, track and update orders',
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search order ID or customer',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() => query = value),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: status,
            decoration: const InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(),
            ),
            items: const ['All', 'Pending', 'Processing', 'Shipped', 'Delivered']
                .map(
                  (s) => DropdownMenuItem(
                    value: s,
                    child: Text(s),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => status = value ?? 'All'),
          ),
          const SizedBox(height: 12),
          ...rows.map(
            (o) => _DataCard(
              title: '${o.id} • ${o.customer}',
              subtitle:
                  '₹${o.amount.toStringAsFixed(0)} • ${o.status} • ${o.payment}',
              icon: Icons.shopping_bag_outlined,
            ),
          ),
          if (rows.isEmpty) const EmptyBox(text: 'No orders found'),
        ],
      ),
    );
  }
}

class CustomersModule extends StatelessWidget {
  const CustomersModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Customers',
            subtitle: 'Customer accounts, orders and status',
          ),
          ...data.customers.map(
            (c) => _DataCard(
              title: '${c.name} • ${c.id}',
              subtitle: '${c.email} • ${c.orders} orders • ${c.status}',
              icon: Icons.person_outline,
            ),
          ),
        ],
      ),
    );
  }
}

class OffersModule extends StatelessWidget {
  const OffersModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Offers & Coupons',
            subtitle: 'Coupons, discounts and promotional offers',
          ),
          ...data.offers.map(
            (o) => _DataCard(
              title: o.code,
              subtitle:
                  '${o.description} • Value ₹${o.value.toStringAsFixed(0)} • ${o.status}',
              icon: Icons.local_offer_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentsModule extends StatelessWidget {
  const PaymentsModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    final total = data.orders.fold<double>(0, (sum, o) => sum + o.amount);
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Payments',
            subtitle: 'Payment collection and transaction overview',
          ),
          _StatsRow(items: [
            ['Collected', '₹${total.toStringAsFixed(0)}', Icons.payments_outlined],
            [
              'Paid Orders',
              data.orders.where((o) => o.payment == 'Paid').length,
              Icons.check_circle_outline
            ],
            [
              'COD Orders',
              data.orders.where((o) => o.payment == 'COD').length,
              Icons.money_outlined
            ],
          ]),
          const SizedBox(height: 12),
          ...data.orders.map(
            (o) => _DataCard(
              title: o.id,
              subtitle: '₹${o.amount.toStringAsFixed(0)} • ${o.payment}',
              icon: Icons.receipt_long_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class DeliveryModule extends StatelessWidget {
  const DeliveryModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Delivery & Shipping',
            subtitle: 'Courier, shipping and delivery controls',
          ),
          _ReportCard(
            title: 'Shipping Settings',
            icon: Icons.local_shipping_outlined,
            items: [
              'Free delivery above ₹999',
              'Standard delivery charge ₹49',
              'PIN-code delivery rules',
              'Courier integration ready',
            ],
          ),
          const SizedBox(height: 12),
          ...data.orders.map(
            (o) => _DataCard(
              title: o.id,
              subtitle: 'Customer: ${o.customer} • Status: ${o.status}',
              icon: Icons.local_shipping_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomOrdersModule extends StatelessWidget {
  const CustomOrdersModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Custom Orders',
            subtitle: 'Manage customer-specific order requests',
          ),
          ...data.customOrders.map(
            (o) => _DataCard(
              title: '${o.id} • ${o.customer}',
              subtitle: '${o.request} • ${o.status}',
              icon: Icons.assignment_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class VendorsModule extends StatelessWidget {
  const VendorsModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Vendors',
            subtitle: 'Vendor onboarding and management',
          ),
          ...data.vendors.map(
            (v) => _DataCard(
              title: '${v.name} • ${v.id}',
              subtitle: '${v.email} • ${v.status}',
              icon: Icons.store_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class ResellersModule extends StatelessWidget {
  const ResellersModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Resellers',
            subtitle: 'Reseller accounts and business activity',
          ),
          ...data.resellers.map(
            (r) => _DataCard(
              title: '${r.name} • ${r.id}',
              subtitle: '${r.email} • ${r.status}',
              icon: Icons.groups_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class AffiliatesModule extends StatelessWidget {
  const AffiliatesModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Affiliates',
            subtitle: 'Affiliate partners and commissions',
          ),
          ...data.affiliates.map(
            (a) => _DataCard(
              title: '${a.name} • ${a.id}',
              subtitle:
                  '${a.email} • Earnings ₹${a.earnings.toStringAsFixed(0)} • ${a.status}',
              icon: Icons.campaign_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class WalletRewardsModule extends StatelessWidget {
  const WalletRewardsModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Wallet & Rewards',
            subtitle: 'Wallet balance, rewards and loyalty controls',
          ),
          _StatsRow(items: [
            [
              'Wallet Users',
              data.customers.length,
              Icons.account_balance_wallet_outlined
            ],
            ['Reward Program', 'Active', Icons.stars_outlined],
            ['Referral', 'Enabled', Icons.share_outlined],
          ]),
          const SizedBox(height: 12),
          _ReportCard(
            title: 'Program Settings',
            icon: Icons.card_giftcard_outlined,
            items: [
              'Customer reward points',
              'Wallet credit and debit',
              'Referral rewards',
              'Redeem rules',
            ],
          ),
        ],
      ),
    );
  }
}

class InventoryModule extends StatefulWidget {
  const InventoryModule({super.key, this.data});
  final KStoreAdminData? data;

  @override
  State<InventoryModule> createState() => _InventoryModuleState();
}

class _InventoryModuleState extends State<InventoryModule> {
  late KStoreAdminData data;

  @override
  void initState() {
    super.initState();
    data = widget.data ?? KStoreAdminData();
  }

  @override
  Widget build(BuildContext context) {
    final products = data.products;
    final units = products.fold<int>(0, (sum, p) => sum + p.stock);
    final low = products.where((p) => p.stock < 10).length;

    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Inventory',
            subtitle: 'Stock levels, low-stock alerts and inventory control',
          ),
          _StatsRow(items: [
            ['Products', products.length, Icons.inventory_2_outlined],
            ['Stock Units', units, Icons.warehouse_outlined],
            ['Low Stock', low, Icons.warning_amber_outlined],
          ]),
          const SizedBox(height: 12),
          _ReportCard(
            title: 'Inventory Summary',
            icon: Icons.inventory_outlined,
            items: [
              '${products.length} products tracked',
              '$units total units',
              '$low products need attention',
            ],
          ),
          const SizedBox(height: 12),
          ...products.map(
            (p) => _DataCard(
              title: '${p.name} • ${p.id}',
              subtitle: '${p.stock} units • ${p.status}',
              icon: Icons.inventory_2_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class ReportModule extends StatelessWidget {
  const ReportModule({super.key, this.data});
  final KStoreAdminData? data;

  @override
  Widget build(BuildContext context) {
    final d = data ?? KStoreAdminData();
    final revenue = d.orders.fold<double>(0, (sum, o) => sum + o.amount);

    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Reports',
            subtitle: 'Business reports and analytics',
          ),
          _StatsRow(items: [
            ['Revenue', '₹${revenue.toStringAsFixed(0)}', Icons.currency_rupee],
            ['Orders', d.orders.length, Icons.shopping_bag_outlined],
            ['Customers', d.customers.length, Icons.people_outline],
          ]),
          const SizedBox(height: 12),
          _ReportCard(
            title: 'Available Reports',
            icon: Icons.assessment_outlined,
            items: [
              'Sales report',
              'Order report',
              'Customer report',
              'Product and inventory report',
              'Vendor and reseller report',
            ],
          ),
        ],
      ),
    );
  }
}

class MarketingModule extends StatefulWidget {
  const MarketingModule({super.key, this.data});
  final KStoreAdminData? data;

  @override
  State<MarketingModule> createState() => _MarketingModuleState();
}

class _MarketingModuleState extends State<MarketingModule> {
  late KStoreAdminData data;

  final List<Map<String, dynamic>> campaigns = [
    {'name': 'Festive Offer', 'status': 'Active', 'reach': 12000},
    {'name': 'Welcome Campaign', 'status': 'Active', 'reach': 8400},
    {'name': 'Old Customer Winback', 'status': 'Draft', 'reach': 5200},
  ];

  @override
  void initState() {
    super.initState();
    data = widget.data ?? KStoreAdminData();
  }

  @override
  Widget build(BuildContext context) {
    final active = campaigns.where((c) => c['status'] == 'Active').length;
    final reach = campaigns.fold<int>(
      0,
      (sum, c) => sum + (c['reach'] as int),
    );

    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ModuleHeader(
            title: 'Marketing',
            subtitle: 'Campaigns, customer reach and promotional activity',
            actions: [
              IconButton(
                tooltip: 'Create campaign',
                onPressed: () => _showMessage(context, 'Create Campaign'),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          _StatsRow(items: [
            ['Campaigns', campaigns.length, Icons.campaign_outlined],
            ['Active', active, Icons.play_circle_outline],
            ['Reach', reach, Icons.groups_outlined],
          ]),
          const SizedBox(height: 12),
          ...campaigns.map(
            (campaign) => _DataCard(
              title: '${campaign['name']}',
              subtitle: '${campaign['status']} • Reach ${campaign['reach']}',
              icon: Icons.campaign_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationModule extends StatefulWidget {
  const NotificationModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<NotificationModule> createState() => _NotificationModuleState();
}

class _NotificationModuleState extends State<NotificationModule> {
  late List<NotificationItem> templates;

  @override
  void initState() {
    super.initState();
    templates = List<NotificationItem>.from(widget.data.notifications);
  }

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Notifications',
            subtitle: 'Notification templates and delivery controls',
          ),
          ...templates.map(
            (item) => SwitchListTile(
              title: Text(item.title),
              subtitle: Text(item.message),
              value: item.enabled,
              onChanged: (value) {
                setState(() => item.enabled = value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ApiModule extends StatelessWidget {
  const ApiModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'API & Integrations',
            subtitle: 'Configure external services and integrations',
          ),
          _ReportCard(
            title: 'Integrations',
            icon: Icons.api_outlined,
            items: [
              'Shiprocket / Shipmojo',
              'Payment gateway',
              'WhatsApp notifications',
              'Firebase',
              'Future REST API',
            ],
          ),
        ],
      ),
    );
  }
}

class StaffRoleModule extends StatefulWidget {
  const StaffRoleModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<StaffRoleModule> createState() => _StaffRoleModuleState();
}

class _StaffRoleModuleState extends State<StaffRoleModule> {
  late List<StaffItem> staff;

  @override
  void initState() {
    super.initState();
    staff = List<StaffItem>.from(widget.data.staff);
  }

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Staff & Roles',
            subtitle: 'Staff accounts, roles and access',
          ),
          ...staff.map(
            (s) => SwitchListTile(
              title: Text(s.name),
              subtitle: Text('${s.role} • ${s.email}'),
              value: s.active,
              onChanged: (value) => setState(() => s.active = value),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsModule extends StatelessWidget {
  const SettingsModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Settings',
            subtitle: 'Store and admin configuration',
          ),
          _ReportCard(
            title: 'Store Settings',
            icon: Icons.settings_outlined,
            items: [
              'Store name: K - Store',
              'Currency: INR (₹)',
              'Free delivery threshold: ₹999',
              'Standard delivery charge: ₹49',
              'Order and customer controls',
            ],
          ),
        ],
      ),
    );
  }
}

class AccountSecurityModule extends StatelessWidget {
  const AccountSecurityModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ModuleHeader(
            title: 'Account & Security',
            subtitle: 'Admin account and security settings',
          ),
          _ReportCard(
            title: 'Security',
            icon: Icons.security_outlined,
            items: [
              'Change password',
              'Role-based access',
              'Login session control',
              'Activity and audit logging',
            ],
          ),
        ],
      ),
    );
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('$message is ready to configure.')),
  );
}
