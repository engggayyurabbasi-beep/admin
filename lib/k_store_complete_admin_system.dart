import 'package:flutter/material.dart';
import 'add_category_page.dart';

/// K - Store Admin Panel
/// Final colorful modular admin UI.
///
/// IMPORTANT:
/// - This file provides a complete working admin UI with local/in-memory CRUD.
/// - API integrations contain configuration/test controls, but real credentials
///   and live API calls must be connected to a secure backend before production.
/// - Each business area is implemented as a separate module so changes stay isolated.

class KStoreAdminData {
  final List<ProductAdmin> products = [
    ProductAdmin('P001', 'Wheat Atta 10kg', 'Grocery', 499, 42, true),
    ProductAdmin('P002', 'Herbal Hair Oil', 'Herbal', 380, 18, true),
    ProductAdmin('P003', 'Slim Trimz Powder', 'Herbal', 270, 7, true),
  ];
  final List<CategoryAdmin> categories = [
    CategoryAdmin('C001', 'Grocery', 'Daily grocery products', true),
    CategoryAdmin('C002', 'Herbal', 'Herbal and wellness products', true),
    CategoryAdmin('C003', 'Personal Care', 'Personal care products', true),
  ];
  final List<OrderAdmin> orders = [
    OrderAdmin('ORD-1001', 'Rahul Kumar', 1299, 'Processing', 'Paid'),
    OrderAdmin('ORD-1002', 'Aman Khan', 799, 'Shipped', 'Paid'),
    OrderAdmin('ORD-1003', 'Sana Ali', 1599, 'Delivered', 'Paid'),
  ];
  final List<CustomerAdmin> customers = [
    CustomerAdmin('U001', 'Rahul Kumar', 'rahul@example.com', true),
    CustomerAdmin('U002', 'Aman Khan', 'aman@example.com', true),
    CustomerAdmin('U003', 'Sana Ali', 'sana@example.com', true),
  ];
  final List<CouponAdmin> coupons = [
    CouponAdmin('WELCOME100', 'Welcome discount', '₹100', true),
    CouponAdmin('SAVE200', 'Flat discount', '₹200', true),
  ];
  final List<ShippingAdmin> shipping = [
    ShippingAdmin('S001', 'Shiprocket', 'API', 'Not Connected', false),
    ShippingAdmin('S002', 'Shipmojo', 'API', 'Not Connected', false),
  ];
  final List<CustomOrderAdmin> customOrders = [
    CustomOrderAdmin('CO001', 'Rahul Kumar', 'Bulk herbal combo', 'New'),
  ];
  final List<PartnerAdmin> vendors = [
    PartnerAdmin('V001', 'KIRZ Wholesale', 'vendor@example.com', 'Approved', true),
  ];
  final List<PartnerAdmin> resellers = [
    PartnerAdmin('R001', 'Mohit Store', 'mohit@example.com', 'Active', true),
  ];
  final List<AffiliateAdmin> affiliates = [
    AffiliateAdmin('A001', 'Aamir', 'aamir@example.com', 4200, 'Active', true),
  ];
  final List<WalletTransaction> wallet = [
    WalletTransaction('W001', 'Initial balance', 5000, 'Credit'),
  ];
  final List<MarketingTool> marketingTools = [
    MarketingTool('WhatsApp', 'WhatsApp API', 'Not Connected', false),
    MarketingTool('SMS', 'SMS Gateway', 'Not Connected', false),
    MarketingTool('Email', 'Email/SMTP', 'Not Connected', false),
    MarketingTool('Push', 'Firebase Push', 'Connected', true),
  ];
  final List<ApiIntegration> integrations = [
    ApiIntegration('I001', 'Razorpay', 'Payment', 'Enter key and secret', false),
    ApiIntegration('I002', 'Shiprocket', 'Shipping', 'Enter API credentials', false),
    ApiIntegration('I003', 'Firebase', 'Push/Authentication', 'Project configuration', true),
  ];
  final List<StaffAdmin> staff = [
    StaffAdmin('ST001', 'Admin User', 'admin@kstore.com', 'Admin', 'All', true),
    StaffAdmin('ST002', 'Support Staff', 'support@kstore.com', 'Support', 'Orders, Customers', true),
  ];
  final Map<String, bool> settings = {
    'Store Open': true,
    'Customer Registration': true,
    'COD': true,
    'Online Payments': true,
    'Guest Checkout': true,
    'Reviews': true,
    'Referral Program': true,
    'Reseller Program': true,
    'Affiliate Program': true,
    'Maintenance Mode': false,
  };
}

class ProductAdmin {
  ProductAdmin(this.id, this.name, this.category, this.price, this.stock, this.enabled);
  String id, name, category;
  double price;
  int stock;
  bool enabled;
}

class CategoryAdmin {
  CategoryAdmin(this.id, this.name, this.description, this.enabled);
  String id, name, description;
  bool enabled;
}

class OrderAdmin {
  OrderAdmin(this.id, this.customer, this.amount, this.status, this.payment);
  String id, customer, status, payment;
  double amount;
}

class CustomerAdmin {
  CustomerAdmin(this.id, this.name, this.email, this.enabled);
  String id, name, email;
  bool enabled;
}

class CouponAdmin {
  CouponAdmin(this.code, this.description, this.value, this.enabled);
  String code, description, value;
  bool enabled;
}

class ShippingAdmin {
  ShippingAdmin(this.id, this.name, this.type, this.status, this.enabled);
  String id, name, type, status;
  bool enabled;
}

class CustomOrderAdmin {
  CustomOrderAdmin(this.id, this.customer, this.request, this.status);
  String id, customer, request, status;
}

class PartnerAdmin {
  PartnerAdmin(this.id, this.name, this.email, this.status, this.enabled);
  String id, name, email, status;
  bool enabled;
}

class AffiliateAdmin {
  AffiliateAdmin(this.id, this.name, this.email, this.earnings, this.status, this.enabled);
  String id, name, email, status;
  double earnings;
  bool enabled;
}

class WalletTransaction {
  WalletTransaction(this.id, this.note, this.amount, this.type);
  String id, note, type;
  double amount;
}

class MarketingTool {
  MarketingTool(this.name, this.type, this.status, this.enabled);
  String name, type, status;
  bool enabled;
}

class ApiIntegration {
  ApiIntegration(this.id, this.name, this.type, this.description, this.enabled);
  String id, name, type, description;
  bool enabled;
}

class StaffAdmin {
  StaffAdmin(this.id, this.name, this.email, this.role, this.permissions, this.enabled);
  String id, name, email, role, permissions;
  bool enabled;
}

class KStoreAdminSystem extends StatefulWidget {
  const KStoreAdminSystem({super.key, this.data});
  final KStoreAdminData? data;

  @override
  State<KStoreAdminSystem> createState() => _KStoreAdminSystemState();
}

class _KStoreAdminSystemState extends State<KStoreAdminSystem> {
  late final KStoreAdminData data;
  int selected = 0;

  final modules = const [
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
    'Reports & Analytics',
    'Marketing',
    'Notifications',
    'API & Integrations',
    'Staff & Roles',
    'Settings',
    'Account & Security',
  ];

  final icons = const [
    Icons.home_rounded,
    Icons.inventory_2_rounded,
    Icons.category_rounded,
    Icons.shopping_cart_rounded,
    Icons.people_alt_rounded,
    Icons.local_offer_rounded,
    Icons.account_balance_wallet_rounded,
    Icons.local_shipping_rounded,
    Icons.assignment_rounded,
    Icons.store_rounded,
    Icons.groups_rounded,
    Icons.share_rounded,
    Icons.card_giftcard_rounded,
    Icons.warehouse_rounded,
    Icons.bar_chart_rounded,
    Icons.campaign_rounded,
    Icons.notifications_rounded,
    Icons.extension_rounded,
    Icons.manage_accounts_rounded,
    Icons.settings_rounded,
    Icons.security_rounded,
  ];

  final colors = const [
    Color(0xFFFF2D69),
    Color(0xFFFF315B),
    Color(0xFF8B3DFF),
    Color(0xFF16C96A),
    Color(0xFF2589E8),
    Color(0xFFFF9F0A),
    Color(0xFF7C3AED),
    Color(0xFFFFB20F),
    Color(0xFF12AFC0),
    Color(0xFF8B3DFF),
    Color(0xFFFF3E7D),
    Color(0xFF16C96A),
    Color(0xFFFF7A00),
    Color(0xFF2196F3),
    Color(0xFFE91E63),
    Color(0xFF1689E8),
    Color(0xFF8E44EC),
    Color(0xFF19B75A),
    Color(0xFF607080),
    Color(0xFF1976D2),
    Color(0xFFE83E67),
  ];

  @override
  void initState() {
    super.initState();
    data = widget.data ?? KStoreAdminData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: _buildSelectedModule(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF315B), Color(0xFF9B36FF)],
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Center(
              child: Text(
                'K',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'K - Store',
                style: TextStyle(
                  color: Color(0xFF101522),
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Admin Panel',
                style: TextStyle(color: Color(0xFF6C7480), fontSize: 13),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () => _select(16),
              icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF1B2030)),
            ),
            Positioned(
              right: 4,
              top: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF315B),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('5', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: CircleAvatar(
            radius: 21,
            backgroundColor: const Color(0xFFFFE5EC),
            child: const Icon(Icons.person_rounded, color: Color(0xFFFF315B)),
          ),
        ),
      ],
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFEFF5), Color(0xFFF2ECFF)],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFFF315B),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text('Admin', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('admin@kstore.com'),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: modules.length,
                itemBuilder: (context, i) => ListTile(
                  leading: Icon(icons[i], color: colors[i]),
                  title: Text(modules[i]),
                  selected: selected == i,
                  onTap: () {
                    _select(i);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _select(int index) => setState(() => selected = index);

  Widget _buildSelectedModule() {
    switch (selected) {
      case 0:
        return DashboardModule(data: data, onOpen: _select);
      case 1:
        return ProductsModule(data: data);
      case 2:
        return CategoriesModule(data: data);
      case 3:
        return OrdersModule(data: data);
      case 4:
        return CustomersModule(data: data);
      case 5:
        return OffersCouponsModule(data: data);
      case 6:
        return PaymentsModule(data: data);
      case 7:
        return DeliveryShippingModule(data: data);
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
        return ReportsModule(data: data);
      case 15:
        return MarketingModule(data: data);
      case 16:
        return NotificationsModule(data: data);
      case 17:
        return ApiIntegrationsModule(data: data);
      case 18:
        return StaffRolesModule(data: data);
      case 19:
        return SettingsModule(data: data);
      case 20:
        return SecurityModule(data: data);
      default:
        return DashboardModule(data: data, onOpen: _select);
    }
  }
}

// -----------------------------------------------------------------------------
// HOME / DASHBOARD
// -----------------------------------------------------------------------------

class DashboardModule extends StatelessWidget {
  const DashboardModule({super.key, required this.data, required this.onOpen});
  final KStoreAdminData data;
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    final revenue = data.orders.fold<double>(0, (sum, o) => sum + o.amount);

    return _Page(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeroBanner(
            title: 'Welcome, Admin!',
            subtitle: 'Manage your store from one place',
            icon: Icons.storefront_rounded,
          ),
          const SizedBox(height: 14),
          _StatsStrip(items: [
            ['Products', '${data.products.length}', Icons.inventory_2_rounded],
            ['Orders', '${data.orders.length}', Icons.shopping_bag_rounded],
            ['Customers', '${data.customers.length}', Icons.people_alt_rounded],
            ['Revenue', '₹${revenue.toStringAsFixed(0)}', Icons.currency_rupee_rounded],
          ]),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final count = constraints.maxWidth >= 650 ? 3 : 2;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 21,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: count == 3 ? 1.34 : 1.42,
                ),
                itemBuilder: (context, index) => _HomeModuleButton(
                  title: _homeTitle(index),
                  subtitle: _homeSubtitle(index),
                  icon: _homeIcon(index),
                  color: _homeColor(index),
                  onTap: () => onOpen(index),
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          _FooterAdminCard(
            onLogout: () => _showSnack(context, 'Logout action is ready.'),
          ),
        ],
      ),
    );
  }

  String _homeTitle(int i) => const [
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
        'Reports & Analytics',
        'Marketing',
        'Notifications',
        'API & Integrations',
        'Staff & Roles',
        'Settings',
      ][i];

  String _homeSubtitle(int i) => const [
        'Overview & Analytics',
        'Manage Products',
        'Manage Categories',
        'Manage Orders',
        'Customer Management',
        'Discounts & Promotions',
        'Payment Methods',
        'Courier & Delivery',
        'Manual Orders',
        'Manage Vendors',
        'Reseller Management',
        'Affiliate Marketing',
        'Wallet, Points & Rewards',
        'Stock Management',
        'Sales & Reports',
        'Banners, Tools & APIs',
        'Send Notifications',
        'Third Party Services',
        'Manage Staff & Roles',
        'General Settings',
      ][i];

  IconData _homeIcon(int i) => const [
        Icons.home_rounded,
        Icons.inventory_2_rounded,
        Icons.category_rounded,
        Icons.shopping_cart_rounded,
        Icons.people_alt_rounded,
        Icons.local_offer_rounded,
        Icons.account_balance_wallet_rounded,
        Icons.local_shipping_rounded,
        Icons.assignment_rounded,
        Icons.store_rounded,
        Icons.groups_rounded,
        Icons.share_rounded,
        Icons.card_giftcard_rounded,
        Icons.warehouse_rounded,
        Icons.bar_chart_rounded,
        Icons.campaign_rounded,
        Icons.notifications_rounded,
        Icons.extension_rounded,
        Icons.manage_accounts_rounded,
        Icons.settings_rounded,
      ][i];

  Color _homeColor(int i) => const [
        Color(0xFFFF315B),
        Color(0xFFFF315B),
        Color(0xFF8B3DFF),
        Color(0xFF16C96A),
        Color(0xFF2589E8),
        Color(0xFFFF9F0A),
        Color(0xFF7C3AED),
        Color(0xFFFFB20F),
        Color(0xFF12AFC0),
        Color(0xFF8B3DFF),
        Color(0xFFFF3E7D),
        Color(0xFF16C96A),
        Color(0xFFFF7A00),
        Color(0xFF2196F3),
        Color(0xFFE91E63),
        Color(0xFF1689E8),
        Color(0xFF8E44EC),
        Color(0xFF19B75A),
        Color(0xFF607080),
        Color(0xFF1976D2),
      ][i];
}

// -----------------------------------------------------------------------------
// PRODUCTS
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// PRODUCT MANAGEMENT - PROFESSIONAL UPGRADE
// Replace the existing ProductsModule section with this section.
// It intentionally reuses the existing KStoreAdminData, ProductAdmin and
// shared UI widgets already present in k_store_complete_admin_system.dart.
// -----------------------------------------------------------------------------

class ProductExtraAdmin {
  ProductExtraAdmin({
    this.brand = '',
    this.subCategory = '',
    this.productType = 'Physical Product',
    this.shortDescription = '',
    this.description = '',
    this.mrp = 0,
    this.costPrice = 0,
    this.discountPercent = 0,
    this.taxPercent = 0,
    this.wholesalePrice = 0,
    this.resellerPrice = 0,
    this.affiliateCommission = 0,
    this.lowStockAlert = 10,
    this.minimumStock = 0,
    this.warehouse = 'Main Warehouse',
    this.batchNumber = '',
    this.expiryDate = '',
    this.trackInventory = true,
    this.mainImage = '',
    this.galleryImages = '',
    this.videoUrl = '',
    this.ingredients = '',
    this.benefits = '',
    this.howToUse = '',
    this.faq = '',
    this.specifications = '',
    this.weight = '',
    this.packSize = '',
    this.freeGift = false,
    this.flashSale = false,
    this.featured = false,
    this.newArrival = false,
    this.couponEligible = true,
    this.freeDelivery = false,
    this.shippingWeight = '',
    this.length = '',
    this.width = '',
    this.height = '',
    this.shippingClass = 'Standard',
    this.codAvailable = true,
    this.metaTitle = '',
    this.metaDescription = '',
    this.seoKeywords = '',
    this.slug = '',
    this.showOnHome = false,
    this.showInCategory = true,
    this.customerVisible = true,
  });

  String brand;
  String subCategory;
  String productType;
  String shortDescription;
  String description;

  double mrp;
  double costPrice;
  double discountPercent;
  double taxPercent;
  double wholesalePrice;
  double resellerPrice;
  double affiliateCommission;

  int lowStockAlert;
  int minimumStock;
  String warehouse;
  String batchNumber;
  String expiryDate;
  bool trackInventory;

  String mainImage;
  String galleryImages;
  String videoUrl;

  String ingredients;
  String benefits;
  String howToUse;
  String faq;
  String specifications;
  String weight;
  String packSize;

  bool freeGift;
  bool flashSale;
  bool featured;
  bool newArrival;
  bool couponEligible;
  bool freeDelivery;

  String shippingWeight;
  String length;
  String width;
  String height;
  String shippingClass;
  bool codAvailable;

  String metaTitle;
  String metaDescription;
  String seoKeywords;
  String slug;

  bool showOnHome;
  bool showInCategory;
  bool customerVisible;

  final List<ProductBulkSlab> bulkSlabs = [];
}

class ProductBulkSlab {
  ProductBulkSlab({
    this.minQty = 1,
    this.maxQty = 10,
    this.price = 0,
  });

  int minQty;
  int maxQty;
  double price;
}

class ProductsModule extends StatefulWidget {
  const ProductsModule({super.key, required this.data});

  final KStoreAdminData data;

  @override
  State<ProductsModule> createState() => _ProductsModuleState();
}

class _ProductsModuleState extends State<ProductsModule> {
  String search = '';
  String filter = 'All';

  // ProductAdmin itself remains backward compatible. Extra product fields are
  // kept here so the existing main data model does not have to be rewritten.
  static final Map<String, ProductExtraAdmin> _extra = {};

  ProductExtraAdmin _details(ProductAdmin product) {
    return _extra.putIfAbsent(product.id, () {
      final d = ProductExtraAdmin(
        mrp: product.price,
        packSize: '',
        customerVisible: product.enabled,
      );
      d.bulkSlabs.add(
        ProductBulkSlab(minQty: 1, maxQty: 10, price: product.price),
      );
      return d;
    });
  }

  List<ProductAdmin> get _rows {
    final q = search.trim().toLowerCase();

    return widget.data.products.where((p) {
      final d = _details(p);
      final matchesSearch = q.isEmpty ||
          '${p.id} ${p.name} ${p.category} ${d.brand} ${d.subCategory}'
              .toLowerCase()
              .contains(q);

      final matchesFilter = switch (filter) {
        'Active' => p.enabled,
        'Paused' => !p.enabled,
        'Low Stock' => p.stock <= d.lowStockAlert,
        'Out of Stock' => p.stock <= 0,
        'Featured' => d.featured,
        'Flash Sale' => d.flashSale,
        _ => true,
      };

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.data.products;
    final active = products.where((p) => p.enabled).length;
    final low = products.where((p) => p.stock <= _details(p).lowStockAlert).length;
    final out = products.where((p) => p.stock <= 0).length;

    return _Page(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ModuleHeader(
            title: 'Products',
            subtitle:
                'Complete catalogue, pricing, inventory, offers and product details',
            icon: Icons.inventory_2_rounded,
            actions: [
              _PrimaryButton(
                label: 'Add Product',
                icon: Icons.add_rounded,
                onPressed: () => _openEditor(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _SearchBox(
            hint: 'Search name, SKU, brand, category...',
            onChanged: (v) => setState(() => search = v),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final item in const [
                  'All',
                  'Active',
                  'Paused',
                  'Low Stock',
                  'Out of Stock',
                  'Featured',
                  'Flash Sale',
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(item),
                      selected: filter == item,
                      onSelected: (_) => setState(() => filter = item),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _StatsStrip(
            items: [
              ['Products', '${products.length}', Icons.inventory_2_rounded],
              ['Active', '$active', Icons.check_circle_rounded],
              ['Low Stock', '$low', Icons.warning_amber_rounded],
              ['Out of Stock', '$out', Icons.remove_shopping_cart_rounded],
            ],
          ),
          const SizedBox(height: 14),
          ..._rows.map(_productCard),
          if (_rows.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: Text('No products found')),
            ),
        ],
      ),
    );
  }

  Widget _productCard(ProductAdmin p) {
    final d = _details(p);
    final status = p.stock <= 0
        ? 'OUT OF STOCK'
        : p.stock <= d.lowStockAlert
            ? 'LOW STOCK'
            : p.enabled
                ? 'ACTIVE'
                : 'PAUSED';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xFFFFE7ED),
                    ),
                    child: const Icon(
                      Icons.inventory_2_rounded,
                      color: Color(0xFFFF315B),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${p.id} • ${p.category}'
                          '${d.brand.isEmpty ? '' : ' • ${d.brand}'}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 7),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            _productBadge('₹${p.price.toStringAsFixed(0)}'),
                            _productBadge('Stock ${p.stock}'),
                            _productBadge(status),
                            if (d.featured) _productBadge('FEATURED'),
                            if (d.flashSale) _productBadge('FLASH SALE'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: p.enabled,
                    onChanged: (value) {
                      setState(() {
                        p.enabled = value;
                        d.customerVisible = value;
                      });
                    },
                  ),
                ],
              ),
              const Divider(height: 22),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _ActionChip(
                    label: 'View',
                    icon: Icons.visibility_rounded,
                    onTap: () => _showDetails(p),
                  ),
                  _ActionChip(
                    label: 'Edit',
                    icon: Icons.edit_rounded,
                    onTap: () => _openEditor(item: p),
                  ),
                  _ActionChip(
                    label: 'Stock',
                    icon: Icons.add_box_rounded,
                    onTap: () => _stockDialog(p),
                  ),
                  _ActionChip(
                    label: 'Duplicate',
                    icon: Icons.copy_rounded,
                    onTap: () => _duplicate(p),
                  ),
                  _ActionChip(
                    label: p.enabled ? 'Pause' : 'Activate',
                    icon: p.enabled
                        ? Icons.pause_circle_outline_rounded
                        : Icons.play_circle_outline_rounded,
                    onTap: () => setState(() => p.enabled = !p.enabled),
                  ),
                  _ActionChip(
                    label: 'Delete',
                    icon: Icons.delete_outline_rounded,
                    danger: true,
                    onTap: () => _deleteProduct(p),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }

  Future<void> _openEditor({ProductAdmin? item}) async {
    final created = await showModalBottomSheet<ProductAdmin>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ProductEditor(
        product: item,
        details: item == null ? ProductExtraAdmin() : _details(item),
        categories: widget.data.categories.map((c) => c.name).toList(),
      ),
    );

    if (created != null && mounted) {
      setState(() {
        if (item == null) {
          widget.data.products.add(created);
        }
        // The editor mutates the details object in-place. Keep it for the
        // product's lifetime in this admin session.
        _extra[created.id] = _ProductEditorState.takeReturnedDetails(created.id);
      });
      _showSnack(context, item == null ? 'Product added' : 'Product updated');
    }
  }

  Future<void> _stockDialog(ProductAdmin p) async {
    final controller = TextEditingController();
    final add = await showDialog<int>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Update Stock • ${p.name}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Quantity to add',
            hintText: 'Use a negative number to reduce stock',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext, int.tryParse(controller.text) ?? 0);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );

    if (add != null) {
      setState(() => p.stock = (p.stock + add).clamp(0, 999999));
      _showSnack(context, 'Stock updated');
    }
  }

  Future<void> _duplicate(ProductAdmin source) async {
    final id = 'P${DateTime.now().millisecondsSinceEpoch}';
    final copy = ProductAdmin(
      id,
      '${source.name} Copy',
      source.category,
      source.price,
      source.stock,
      source.enabled,
    );
    final original = _details(source);
    final copyDetails = ProductExtraAdmin(
      brand: original.brand,
      subCategory: original.subCategory,
      productType: original.productType,
      shortDescription: original.shortDescription,
      description: original.description,
      mrp: original.mrp,
      costPrice: original.costPrice,
      discountPercent: original.discountPercent,
      taxPercent: original.taxPercent,
      wholesalePrice: original.wholesalePrice,
      resellerPrice: original.resellerPrice,
      affiliateCommission: original.affiliateCommission,
      lowStockAlert: original.lowStockAlert,
      minimumStock: original.minimumStock,
      warehouse: original.warehouse,
      batchNumber: original.batchNumber,
      expiryDate: original.expiryDate,
      trackInventory: original.trackInventory,
      mainImage: original.mainImage,
      galleryImages: original.galleryImages,
      videoUrl: original.videoUrl,
      ingredients: original.ingredients,
      benefits: original.benefits,
      howToUse: original.howToUse,
      faq: original.faq,
      specifications: original.specifications,
      weight: original.weight,
      packSize: original.packSize,
      freeGift: original.freeGift,
      flashSale: original.flashSale,
      featured: original.featured,
      newArrival: original.newArrival,
      couponEligible: original.couponEligible,
      freeDelivery: original.freeDelivery,
      shippingWeight: original.shippingWeight,
      length: original.length,
      width: original.width,
      height: original.height,
      shippingClass: original.shippingClass,
      codAvailable: original.codAvailable,
      metaTitle: original.metaTitle,
      metaDescription: original.metaDescription,
      seoKeywords: original.seoKeywords,
      slug: original.slug,
      showOnHome: original.showOnHome,
      showInCategory: original.showInCategory,
      customerVisible: original.customerVisible,
    );
    for (final slab in original.bulkSlabs) {
      copyDetails.bulkSlabs.add(
        ProductBulkSlab(
          minQty: slab.minQty,
          maxQty: slab.maxQty,
          price: slab.price,
        ),
      );
    }

    setState(() {
      widget.data.products.add(copy);
      _extra[id] = copyDetails;
    });
    _showSnack(context, 'Product duplicated');
  }

  Future<void> _deleteProduct(ProductAdmin p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Product?'),
        content: Text('Delete "${p.name}" permanently from this admin session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (ok == true) {
      setState(() {
        widget.data.products.remove(p);
        _extra.remove(p.id);
      });
      _showSnack(context, 'Product deleted');
    }
  }

  void _showDetails(ProductAdmin p) {
    final d = _details(p);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _ProductDetailsSheet(product: p, details: d),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

// -----------------------------------------------------------------------------
// PRODUCT VIEW
// -----------------------------------------------------------------------------

class _ProductDetailsSheet extends StatelessWidget {
  const _ProductDetailsSheet({
    required this.product,
    required this.details,
  });

  final ProductAdmin product;
  final ProductExtraAdmin details;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: .86,
      minChildSize: .55,
      maxChildSize: .96,
      builder: (_, controller) => Material(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            Text('${product.id} • ${product.category}'),
            const SizedBox(height: 16),
            _InfoSection(
              title: 'Pricing & Inventory',
              icon: Icons.payments_rounded,
              children: [
                _info('Selling Price', '₹${product.price.toStringAsFixed(2)}'),
                _info('MRP', '₹${details.mrp.toStringAsFixed(2)}'),
                _info('Cost Price', '₹${details.costPrice.toStringAsFixed(2)}'),
                _info('Stock', '${product.stock}'),
                _info('Low Stock Alert', '${details.lowStockAlert}'),
                _info('Warehouse', details.warehouse),
              ],
            ),
            _InfoSection(
              title: 'Product Information',
              icon: Icons.description_rounded,
              children: [
                _info('Brand', details.brand),
                _info('Sub-category', details.subCategory),
                _info('Product Type', details.productType),
                _info('Pack Size', details.packSize),
                _info('Weight', details.weight),
                _info('Ingredients', details.ingredients),
                _info('Benefits', details.benefits),
                _info('How to Use', details.howToUse),
              ],
            ),
            _InfoSection(
              title: 'Offers & Visibility',
              icon: Icons.local_offer_rounded,
              children: [
                _info('Flash Sale', details.flashSale ? 'Yes' : 'No'),
                _info('Featured', details.featured ? 'Yes' : 'No'),
                _info('New Arrival', details.newArrival ? 'Yes' : 'No'),
                _info('Free Gift', details.freeGift ? 'Yes' : 'No'),
                _info('Free Delivery', details.freeDelivery ? 'Yes' : 'No'),
                _info('Customer Visible', details.customerVisible ? 'Yes' : 'No'),
              ],
            ),
            _InfoSection(
              title: 'Shipping & SEO',
              icon: Icons.local_shipping_rounded,
              children: [
                _info('Shipping Weight', details.shippingWeight),
                _info(
                  'Dimensions',
                  '${details.length} × ${details.width} × ${details.height}',
                ),
                _info('Shipping Class', details.shippingClass),
                _info('COD', details.codAvailable ? 'Available' : 'Not Available'),
                _info('SEO Slug', details.slug),
                _info('Meta Title', details.metaTitle),
                _info('Meta Description', details.metaDescription),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 135,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(child: Text(value.isEmpty ? '—' : value)),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PRODUCT EDITOR
// -----------------------------------------------------------------------------

class _ProductEditor extends StatefulWidget {
  const _ProductEditor({
    required this.product,
    required this.details,
    required this.categories,
  });

  final ProductAdmin? product;
  final ProductExtraAdmin details;
  final List<String> categories;

  @override
  State<_ProductEditor> createState() => _ProductEditorState();
}

class _ProductEditorState extends State<_ProductEditor> {
  late final TextEditingController sku;
  late final TextEditingController name;
  late final TextEditingController category;
  late final TextEditingController brand;
  late final TextEditingController subCategory;
  late final TextEditingController shortDescription;
  late final TextEditingController description;
  late final TextEditingController price;
  late final TextEditingController mrp;
  late final TextEditingController costPrice;
  late final TextEditingController tax;
  late final TextEditingController wholesale;
  late final TextEditingController reseller;
  late final TextEditingController commission;
  late final TextEditingController stock;
  late final TextEditingController lowStock;
  late final TextEditingController minimumStock;
  late final TextEditingController warehouse;
  late final TextEditingController batch;
  late final TextEditingController expiry;
  late final TextEditingController mainImage;
  late final TextEditingController gallery;
  late final TextEditingController video;
  late final TextEditingController ingredients;
  late final TextEditingController benefits;
  late final TextEditingController howToUse;
  late final TextEditingController faq;
  late final TextEditingController specifications;
  late final TextEditingController weight;
  late final TextEditingController packSize;
  late final TextEditingController shippingWeight;
  late final TextEditingController length;
  late final TextEditingController width;
  late final TextEditingController height;
  late final TextEditingController metaTitle;
  late final TextEditingController metaDescription;
  late final TextEditingController keywords;
  late final TextEditingController slug;

  String productType = 'Physical Product';
  String shippingClass = 'Standard';
  bool trackInventory = true;
  bool freeGift = false;
  bool flashSale = false;
  bool featured = false;
  bool newArrival = false;
  bool couponEligible = true;
  bool freeDelivery = false;
  bool codAvailable = true;
  bool showOnHome = false;
  bool showInCategory = true;
  bool customerVisible = true;

  final List<ProductBulkSlab> slabs = [];

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    final d = widget.details;

    sku = TextEditingController(text: p?.id ?? 'P${DateTime.now().millisecondsSinceEpoch}');
    name = TextEditingController(text: p?.name ?? '');
    category = TextEditingController(text: p?.category ?? '');
    brand = TextEditingController(text: d.brand);
    subCategory = TextEditingController(text: d.subCategory);
    shortDescription = TextEditingController(text: d.shortDescription);
    description = TextEditingController(text: d.description);
    price = TextEditingController(text: p == null ? '' : p.price.toString());
    mrp = TextEditingController(text: d.mrp == 0 ? '' : d.mrp.toString());
    costPrice = TextEditingController(text: d.costPrice == 0 ? '' : d.costPrice.toString());
    tax = TextEditingController(text: d.taxPercent.toString());
    wholesale = TextEditingController(
      text: d.wholesalePrice == 0 ? '' : d.wholesalePrice.toString(),
    );
    reseller = TextEditingController(
      text: d.resellerPrice == 0 ? '' : d.resellerPrice.toString(),
    );
    commission = TextEditingController(
      text: d.affiliateCommission == 0 ? '' : d.affiliateCommission.toString(),
    );
    stock = TextEditingController(text: '${p?.stock ?? 0}');
    lowStock = TextEditingController(text: '${d.lowStockAlert}');
    minimumStock = TextEditingController(text: '${d.minimumStock}');
    warehouse = TextEditingController(text: d.warehouse);
    batch = TextEditingController(text: d.batchNumber);
    expiry = TextEditingController(text: d.expiryDate);
    mainImage = TextEditingController(text: d.mainImage);
    gallery = TextEditingController(text: d.galleryImages);
    video = TextEditingController(text: d.videoUrl);
    ingredients = TextEditingController(text: d.ingredients);
    benefits = TextEditingController(text: d.benefits);
    howToUse = TextEditingController(text: d.howToUse);
    faq = TextEditingController(text: d.faq);
    specifications = TextEditingController(text: d.specifications);
    weight = TextEditingController(text: d.weight);
    packSize = TextEditingController(text: d.packSize);
    shippingWeight = TextEditingController(text: d.shippingWeight);
    length = TextEditingController(text: d.length);
    width = TextEditingController(text: d.width);
    height = TextEditingController(text: d.height);
    metaTitle = TextEditingController(text: d.metaTitle);
    metaDescription = TextEditingController(text: d.metaDescription);
    keywords = TextEditingController(text: d.seoKeywords);
    slug = TextEditingController(text: d.slug);

    productType = d.productType;
    shippingClass = d.shippingClass;
    trackInventory = d.trackInventory;
    freeGift = d.freeGift;
    flashSale = d.flashSale;
    featured = d.featured;
    newArrival = d.newArrival;
    couponEligible = d.couponEligible;
    freeDelivery = d.freeDelivery;
    codAvailable = d.codAvailable;
    showOnHome = d.showOnHome;
    showInCategory = d.showInCategory;
    customerVisible = d.customerVisible;

    slabs.addAll(
      d.bulkSlabs.isEmpty
          ? [ProductBulkSlab(minQty: 1, maxQty: 10, price: p?.price ?? 0)]
          : d.bulkSlabs.map(
              (s) => ProductBulkSlab(
                minQty: s.minQty,
                maxQty: s.maxQty,
                price: s.price,
              ),
            ),
    );
  }

  @override
  void dispose() {
    for (final c in [
      sku, name, category, brand, subCategory, shortDescription, description,
      price, mrp, costPrice, tax, wholesale, reseller, commission, stock,
      lowStock, minimumStock, warehouse, batch, expiry, mainImage, gallery,
      video, ingredients, benefits, howToUse, faq, specifications, weight,
      packSize, shippingWeight, length, width, height, metaTitle,
      metaDescription, keywords, slug,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .96,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                tooltip: 'Close',
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          body: Form(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
              children: [
                _editorSection(
                  '1. Basic Information',
                  Icons.info_outline_rounded,
                  [
                    _field(name, 'Product Name', Icons.inventory_2_rounded),
                    _field(sku, 'SKU / Product ID', Icons.qr_code_rounded),
                    _field(brand, 'Brand', Icons.branding_watermark_rounded),
                    _field(category, 'Category', Icons.category_rounded),
                    _field(subCategory, 'Sub-category', Icons.account_tree_rounded),
                    _dropdown(
                      label: 'Product Type',
                      value: productType,
                      items: const [
                        'Physical Product',
                        'Digital Product',
                        'Service',
                        'Bundle',
                      ],
                      onChanged: (v) => setState(() => productType = v!),
                    ),
                    _field(
                      shortDescription,
                      'Short Description',
                      Icons.short_text_rounded,
                      maxLines: 2,
                    ),
                    _field(
                      description,
                      'Full Description',
                      Icons.description_rounded,
                      maxLines: 5,
                    ),
                  ],
                ),
                _editorSection(
                  '2. Pricing & Tax',
                  Icons.payments_rounded,
                  [
                    _numberField(price, 'Selling Price'),
                    _numberField(mrp, 'MRP'),
                    _numberField(costPrice, 'Cost Price'),
                    _numberField(tax, 'GST / Tax %'),
                    _numberField(wholesale, 'Wholesale Price'),
                    _numberField(reseller, 'Reseller Price'),
                    _numberField(commission, 'Affiliate Commission %'),
                  ],
                ),
                _editorSection(
                  '3. Bulk / Wholesale Pricing',
                  Icons.price_change_rounded,
                  [
                    ...slabs.asMap().entries.map(
                      (entry) => _slabRow(entry.key, entry.value),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => setState(
                        () => slabs.add(
                          ProductBulkSlab(
                            minQty: slabs.isEmpty ? 1 : slabs.last.maxQty + 1,
                            maxQty: slabs.isEmpty ? 10 : slabs.last.maxQty + 30,
                            price: 0,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Add Pricing Slab'),
                    ),
                  ],
                ),
                _editorSection(
                  '4. Inventory',
                  Icons.warehouse_rounded,
                  [
                    _numberField(stock, 'Stock Quantity', integer: true),
                    _numberField(lowStock, 'Low Stock Alert', integer: true),
                    _numberField(minimumStock, 'Minimum Stock', integer: true),
                    _field(warehouse, 'Warehouse', Icons.warehouse_rounded),
                    _field(batch, 'Batch Number', Icons.tag_rounded),
                    _field(expiry, 'Expiry Date', Icons.event_rounded),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Track Inventory'),
                      value: trackInventory,
                      onChanged: (v) => setState(() => trackInventory = v),
                    ),
                  ],
                ),
                _editorSection(
                  '5. Images & Media',
                  Icons.photo_library_rounded,
                  [
                    _field(
                      mainImage,
                      'Main Image URL',
                      Icons.image_rounded,
                    ),
                    _field(
                      gallery,
                      'Gallery Image URLs (comma separated)',
                      Icons.collections_rounded,
                      maxLines: 3,
                    ),
                    _field(
                      video,
                      'Product Video URL',
                      Icons.video_library_rounded,
                    ),
                  ],
                ),
                _editorSection(
                  '6. Product Details',
                  Icons.description_rounded,
                  [
                    _field(ingredients, 'Ingredients', Icons.science_rounded, maxLines: 4),
                    _field(benefits, 'Benefits', Icons.favorite_rounded, maxLines: 4),
                    _field(howToUse, 'How to Use', Icons.menu_book_rounded, maxLines: 4),
                    _field(faq, 'FAQ', Icons.help_outline_rounded, maxLines: 4),
                    _field(
                      specifications,
                      'Specifications',
                      Icons.list_alt_rounded,
                      maxLines: 4,
                    ),
                    _field(weight, 'Weight', Icons.scale_rounded),
                    _field(packSize, 'Pack Size', Icons.inventory_rounded),
                  ],
                ),
                _editorSection(
                  '7. Offers & Visibility',
                  Icons.local_offer_rounded,
                  [
                    _toggle('Flash Sale', flashSale, (v) => flashSale = v),
                    _toggle('Free Gift', freeGift, (v) => freeGift = v),
                    _toggle('Featured Product', featured, (v) => featured = v),
                    _toggle('New Arrival', newArrival, (v) => newArrival = v),
                    _toggle('Coupon Eligible', couponEligible, (v) => couponEligible = v),
                    _toggle('Free Delivery', freeDelivery, (v) => freeDelivery = v),
                    _toggle('Show on Home', showOnHome, (v) => showOnHome = v),
                    _toggle('Show in Category', showInCategory, (v) => showInCategory = v),
                    _toggle('Customer Visible', customerVisible, (v) => customerVisible = v),
                  ],
                ),
                _editorSection(
                  '8. Shipping',
                  Icons.local_shipping_rounded,
                  [
                    _field(shippingWeight, 'Shipping Weight', Icons.scale_rounded),
                    Row(
                      children: [
                        Expanded(child: _field(length, 'Length', Icons.straighten_rounded)),
                        const SizedBox(width: 8),
                        Expanded(child: _field(width, 'Width', Icons.straighten_rounded)),
                        const SizedBox(width: 8),
                        Expanded(child: _field(height, 'Height', Icons.height_rounded)),
                      ],
                    ),
                    _dropdown(
                      label: 'Shipping Class',
                      value: shippingClass,
                      items: const ['Standard', 'Fragile', 'Heavy', 'Free Shipping'],
                      onChanged: (v) => setState(() => shippingClass = v!),
                    ),
                    _toggle('COD Available', codAvailable, (v) => codAvailable = v),
                  ],
                ),
                _editorSection(
                  '9. SEO',
                  Icons.search_rounded,
                  [
                    _field(metaTitle, 'Meta Title', Icons.title_rounded),
                    _field(
                      metaDescription,
                      'Meta Description',
                      Icons.notes_rounded,
                      maxLines: 3,
                    ),
                    _field(
                      keywords,
                      'SEO Keywords',
                      Icons.key_rounded,
                      maxLines: 2,
                    ),
                    _field(slug, 'URL Slug', Icons.link_rounded),
                  ],
                ),
                const SizedBox(height: 14),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    backgroundColor: const Color(0xFFFF315B),
                  ),
                  onPressed: _save,
                  icon: const Icon(Icons.save_rounded),
                  label: Text(
                    widget.product == null ? 'Save Product' : 'Save Changes',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _editorSection(String title, IconData icon, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 17,
                  child: Icon(icon, size: 18),
                ),
                const SizedBox(width: 9),
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: maxLines == 1 ? Icon(icon) : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _numberField(
    TextEditingController controller,
    String label, {
    bool integer = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: !integer),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.currency_rupee_rounded),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: items.contains(value) ? value : items.first,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: [
          for (final item in items)
            DropdownMenuItem(value: item, child: Text(item)),
        ],
        onChanged: onChanged,
      ),
    );
  }

  Widget _toggle(String label, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: value,
      onChanged: (v) => setState(() => onChanged(v)),
    );
  }

  Widget _slabRow(int index, ProductBulkSlab slab) {
    final min = TextEditingController(text: '${slab.minQty}');
    final max = TextEditingController(text: '${slab.maxQty}');
    final amount = TextEditingController(text: '${slab.price}');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: min,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Min Qty'),
              onChanged: (v) => slab.minQty = int.tryParse(v) ?? slab.minQty,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: max,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Max Qty'),
              onChanged: (v) => slab.maxQty = int.tryParse(v) ?? slab.maxQty,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: amount,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Price'),
              onChanged: (v) => slab.price = double.tryParse(v) ?? slab.price,
            ),
          ),
          IconButton(
            tooltip: 'Remove slab',
            onPressed: slabs.length <= 1
                ? null
                : () => setState(() => slabs.removeAt(index)),
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
    );
  }

  void _save() {
    final productName = name.text.trim();
    final productId = sku.text.trim();
    final categoryName = category.text.trim();
    final sellingPrice = double.tryParse(price.text.trim());

    if (productName.isEmpty ||
        productId.isEmpty ||
        categoryName.isEmpty ||
        sellingPrice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Name, SKU, Category and Selling Price are required.'),
        ),
      );
      return;
    }

    final product = widget.product ??
        ProductAdmin(
          productId,
          productName,
          categoryName,
          sellingPrice,
          int.tryParse(stock.text) ?? 0,
          customerVisible,
        );

    product.id = productId;
    product.name = productName;
    product.category = categoryName;
    product.price = sellingPrice;
    product.stock = int.tryParse(stock.text) ?? 0;
    product.enabled = customerVisible;

    final d = widget.details;
    d.brand = brand.text.trim();
    d.subCategory = subCategory.text.trim();
    d.productType = productType;
    d.shortDescription = shortDescription.text.trim();
    d.description = description.text.trim();
    d.mrp = double.tryParse(mrp.text) ?? sellingPrice;
    d.costPrice = double.tryParse(costPrice.text) ?? 0;
    d.taxPercent = double.tryParse(tax.text) ?? 0;
    d.wholesalePrice = double.tryParse(wholesale.text) ?? 0;
    d.resellerPrice = double.tryParse(reseller.text) ?? 0;
    d.affiliateCommission = double.tryParse(commission.text) ?? 0;
    d.lowStockAlert = int.tryParse(lowStock.text) ?? 10;
    d.minimumStock = int.tryParse(minimumStock.text) ?? 0;
    d.warehouse = warehouse.text.trim();
    d.batchNumber = batch.text.trim();
    d.expiryDate = expiry.text.trim();
    d.trackInventory = trackInventory;
    d.mainImage = mainImage.text.trim();
    d.galleryImages = gallery.text.trim();
    d.videoUrl = video.text.trim();
    d.ingredients = ingredients.text.trim();
    d.benefits = benefits.text.trim();
    d.howToUse = howToUse.text.trim();
    d.faq = faq.text.trim();
    d.specifications = specifications.text.trim();
    d.weight = weight.text.trim();
    d.packSize = packSize.text.trim();
    d.freeGift = freeGift;
    d.flashSale = flashSale;
    d.featured = featured;
    d.newArrival = newArrival;
    d.couponEligible = couponEligible;
    d.freeDelivery = freeDelivery;
    d.shippingWeight = shippingWeight.text.trim();
    d.length = length.text.trim();
    d.width = width.text.trim();
    d.height = height.text.trim();
    d.shippingClass = shippingClass;
    d.codAvailable = codAvailable;
    d.metaTitle = metaTitle.text.trim();
    d.metaDescription = metaDescription.text.trim();
    d.seoKeywords = keywords.text.trim();
    d.slug = slug.text.trim();
    d.showOnHome = showOnHome;
    d.showInCategory = showInCategory;
    d.customerVisible = customerVisible;
    d.bulkSlabs
      ..clear()
      ..addAll(
        slabs.map(
          (s) => ProductBulkSlab(
            minQty: s.minQty,
            maxQty: s.maxQty,
            price: s.price,
          ),
        ),
      );

    _returnDetails[product.id] = d;
    Navigator.pop(context, product);
  }

  static final Map<String, ProductExtraAdmin> _returnDetails = {};

  static ProductExtraAdmin takeReturnedDetails(String id) {
    return _returnDetails.remove(id) ?? ProductExtraAdmin();
  }
}
class CategoriesModule extends StatefulWidget {
  const CategoriesModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<CategoriesModule> createState() => _CategoriesModuleState();
}

class _CategoriesModuleState extends State<CategoriesModule> {
  @override
  Widget build(BuildContext context) {
    return _Page(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'Categories',
            subtitle: 'Create, edit, delete, pause and activate categories',
            icon: Icons.category_rounded,
            actions: [
              _PrimaryButton(label: 'Add Category', icon: Icons.add_rounded, onPressed: () => _openAddCategory()),
            ],
          ),
          ...widget.data.categories.map(
            (c) => _AdminListCard(
              title: '${c.name} • ${c.id}',
              subtitle: c.description,
              icon: Icons.category_rounded,
              color: const Color(0xFF8B3DFF),
              enabled: c.enabled,
              onToggle: (v) => setState(() => c.enabled = v),
              actions: [
                _ActionChip(label: 'Edit', icon: Icons.edit_rounded, onTap: () => _dialog(item: c)),
                _ActionChip(label: 'Delete', icon: Icons.delete_outline_rounded, danger: true, onTap: () => setState(() => widget.data.categories.remove(c))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openAddCategory() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => const AddCategoryPage(),
      ),
    );

    if (!mounted || result == null) return;

    final name = (result['name'] ?? '').toString().trim();
    final description = (result['description'] ?? '').toString().trim();
    final id = (result['id'] ?? '').toString().trim();

    if (name.isEmpty || id.isEmpty) return;

    setState(() {
      widget.data.categories.add(
        CategoryAdmin(
          id,
          name,
          description,
          result['status'] == 'Active',
        ),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name category added successfully'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _dialog({CategoryAdmin? item}) async {
    final name = TextEditingController(text: item?.name ?? '');
    final desc = TextEditingController(text: item?.description ?? '');
    final id = TextEditingController(text: item?.id ?? 'C${DateTime.now().millisecondsSinceEpoch}');
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: item == null ? 'Add Category' : 'Edit Category',
        children: [
          _Field(id, 'Category ID'),
          _Field(name, 'Category Name'),
          _Field(desc, 'Description'),
        ],
        onSave: () {
          setState(() {
            if (item == null) {
              widget.data.categories.add(CategoryAdmin(id.text, name.text, desc.text, true));
            } else {
              item.id = id.text;
              item.name = name.text;
              item.description = desc.text;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
    name.dispose();
    desc.dispose();
    id.dispose();
  }
}

// -----------------------------------------------------------------------------
// ORDERS
// -----------------------------------------------------------------------------

/// Complete Orders module for K - Store Admin Panel.
///
/// IMPORTANT:
/// This file is designed to replace the existing OrdersModule section in
/// k_store_complete_admin_system.dart. It expects these existing public types
/// from that file:
///
///   KStoreAdminData
///   OrderAdmin
///
/// It also expects OrderAdmin to expose mutable:
///   id, customer, amount, status, payment
///
/// The KIRZ order number generator is included in this file so the Orders
/// module and numbering system are installed together.
///
/// Production note:
/// For a real multi-device store, the final order number must be generated
/// atomically by the backend/database. The local generator is for the current
/// local/in-memory Admin Panel.

class KirzOrderNumber {
  static const String prefix = 'KIRZ';

  static String fromNumber(int number) {
    if (number < 1) {
      throw ArgumentError('Order number must be greater than 0.');
    }
    return '$prefix${number.toString().padLeft(6, '0')}';
  }

  static int? parse(String orderNumber) {
    final value = orderNumber.trim().toUpperCase();
    if (!value.startsWith(prefix)) return null;

    final numericPart = value.substring(prefix.length);
    if (numericPart.length != 6) return null;

    return int.tryParse(numericPart);
  }

  static String nextFrom(Iterable<String> existingOrderNumbers) {
    var highest = 0;

    for (final orderNumber in existingOrderNumbers) {
      final number = parse(orderNumber);
      if (number != null && number > highest) {
        highest = number;
      }
    }

    return fromNumber(highest + 1);
  }
}

class KirzOrderSequence {
  String next(Iterable<String> existingOrderNumbers) {
    return KirzOrderNumber.nextFrom(existingOrderNumbers);
  }
}

class FinalOrderItem {
  FinalOrderItem({
    required this.product,
    required this.quantity,
    required this.unitPrice,
    this.discount = 0,
  });

  final ProductAdmin product;
  int quantity;
  double unitPrice;
  double discount;

  double get lineTotal =>
      (unitPrice * quantity) - discount.clamp(0, unitPrice * quantity).toDouble();
}

class FinalOrderData {
  FinalOrderData({
    required this.order,
    required this.items,
    required this.customerName,
    required this.mobile,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.shippingMethod,
    required this.awb,
    required this.courier,
    required this.notes,
    required this.discount,
    required this.shippingCharge,
    required this.coupon,
  });

  final OrderAdmin order;
  final List<FinalOrderItem> items;
  final String customerName;
  final String mobile;
  final String email;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String paymentMethod;
  final String paymentStatus;
  final String shippingMethod;
  final String awb;
  final String courier;
  final String notes;
  final double discount;
  final double shippingCharge;
  final String coupon;
}

class OrdersModule extends StatefulWidget {
  const OrdersModule({
    super.key,
    required this.data,
  });

  final KStoreAdminData data;

  @override
  State<OrdersModule> createState() => _OrdersModuleState();
}

class _OrdersModuleState extends State<OrdersModule> {
  final _searchController = TextEditingController();
  String _status = 'All';
  String _payment = 'All';
  String _sort = 'Newest';
  final Set<String> _selected = <String>{};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _nextNumber() => KirzOrderNumber.nextFrom(widget.data.orders.map((e) => e.id));

  List<OrderAdmin> get _filtered {
    final q = _searchController.text.trim().toLowerCase();
    final result = widget.data.orders.where((o) {
      final searchMatch = q.isEmpty ||
          o.id.toLowerCase().contains(q) ||
          o.customer.toLowerCase().contains(q) ||
          o.status.toLowerCase().contains(q) ||
          o.payment.toLowerCase().contains(q);

      final statusMatch = _status == 'All' || o.status == _status;
      final paymentMatch = _payment == 'All' || o.payment == _payment;
      return searchMatch && statusMatch && paymentMatch;
    }).toList();

    if (_sort == 'Amount High') {
      result.sort((a, b) => b.amount.compareTo(a.amount));
    } else if (_sort == 'Amount Low') {
      result.sort((a, b) => a.amount.compareTo(b.amount));
    } else {
      result.sort(
        (a, b) => (KirzOrderNumber.parse(b.id) ?? 0)
            .compareTo((KirzOrderNumber.parse(a.id) ?? 0)),
      );
    }
    return result;
  }

  double get _totalSales =>
      widget.data.orders.fold(0, (sum, o) => sum + o.amount);

  int _count(String status) =>
      widget.data.orders.where((o) => o.status == status).length;

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
    );
  }

  Future<void> _manualOrder() async {
    final result = await Navigator.push<FinalOrderData>(
      context,
      MaterialPageRoute(
        builder: (_) => FinalManualOrderPage(
          products: widget.data.products,
          customers: widget.data.customers,
          nextOrderNumber: _nextNumber,
        ),
      ),
    );

    if (!mounted || result == null) return;

    setState(() {
      widget.data.orders.add(result.order);
    });
    _message('${result.order.id} created successfully.');
  }

  void _openDetails(OrderAdmin order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FinalOrderDetailsPage(
          order: order,
          products: widget.data.products,
          customers: widget.data.customers,
          onChanged: () => setState(() {}),
        ),
      ),
    );
  }

  void _bulkStatus() {
    if (_selected.isEmpty) {
      _message('Select at least one order.');
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Update selected orders'),
        children: [
          for (final status in const [
            'Confirmed',
            'Processing',
            'Shipped',
            'Delivered',
            'Cancelled',
          ])
            SimpleDialogOption(
              onPressed: () {
                setState(() {
                  for (final order in widget.data.orders) {
                    if (_selected.contains(order.id)) {
                      order.status = status;
                    }
                  }
                  _selected.clear();
                });
                Navigator.pop(context);
                _message('Orders updated.');
              },
              child: Text(status),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh_rounded),
          ),
          IconButton(
            tooltip: 'Bulk update',
            onPressed: _bulkStatus,
            icon: const Icon(Icons.done_all_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _header(context),
            const SizedBox(height: 14),
            _summary(),
            const SizedBox(height: 14),
            _filters(),
            const SizedBox(height: 14),
            if (list.isEmpty)
              _empty()
            else
              ...list.map(_orderCard),
            const SizedBox(height: 90),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _manualOrder,
        icon: const Icon(Icons.add_shopping_cart_rounded),
        label: const Text('Manual Order'),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 650;
            return Flex(
              direction: narrow ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment:
                  narrow ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Management',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Manage, track and update every customer order.',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                if (narrow) const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _manualOrder,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Create Order'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _summary() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth < 600 ? 2 : 4;
        return GridView.count(
          crossAxisCount: width,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: width == 2 ? 1.8 : 1.7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _stat('Total Orders', '${widget.data.orders.length}', Icons.receipt_long_rounded),
            _stat('Pending', '${_count('Pending')}', Icons.schedule_rounded),
            _stat('Delivered', '${_count('Delivered')}', Icons.check_circle_rounded),
            _stat('Sales', '₹${_totalSales.toStringAsFixed(0)}', Icons.currency_rupee_rounded),
          ],
        );
      },
    );
  }

  Widget _stat(String title, String value, IconData icon) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 21,
              child: Icon(icon, size: 21),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 3),
                  FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filters() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: 'Search order, customer, status...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            _select(
              'Status',
              _status,
              ['All', 'Pending', 'Confirmed', 'Processing', 'Shipped', 'Delivered', 'Cancelled'],
              (v) => setState(() => _status = v),
            ),
            _select(
              'Payment',
              _payment,
              ['All', 'Pending', 'Paid', 'COD', 'Online', 'Failed'],
              (v) => setState(() => _payment = v),
            ),
            _select(
              'Sort',
              _sort,
              ['Newest', 'Amount High', 'Amount Low'],
              (v) => setState(() => _sort = v),
            ),
          ],
        ),
      ),
    );
  }

  Widget _select(
    String label,
    String value,
    List<String> values,
    ValueChanged<String> onChanged,
  ) {
    return SizedBox(
      width: 175,
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: values
            .map((v) => DropdownMenuItem(value: v, child: Text(v)))
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }

  Widget _orderCard(OrderAdmin order) {
    final selected = _selected.contains(order.id);
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: selected ? Theme.of(context).colorScheme.primary : Colors.black12,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _openDetails(order),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Checkbox(
                value: selected,
                onChanged: (v) {
                  setState(() {
                    if (v == true) {
                      _selected.add(order.id);
                    } else {
                      _selected.remove(order.id);
                    }
                  });
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(order.customer),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _chip(order.status),
                        _chip(order.payment),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${order.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.06),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _empty() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
        child: Column(
          children: [
            Icon(Icons.receipt_long_rounded, size: 56, color: Colors.grey.shade500),
            const SizedBox(height: 14),
            const Text(
              'No orders found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 7),
            const Text('Try changing the filters or create a manual order.'),
          ],
        ),
      ),
    );
  }
}

class FinalManualOrderPage extends StatefulWidget {
  const FinalManualOrderPage({
    super.key,
    required this.products,
    required this.customers,
    required this.nextOrderNumber,
  });

  final List<ProductAdmin> products;
  final List<CustomerAdmin> customers;
  final String Function() nextOrderNumber;

  @override
  State<FinalManualOrderPage> createState() => _FinalManualOrderPageState();
}

class _FinalManualOrderPageState extends State<FinalManualOrderPage> {
  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _pin = TextEditingController();
  final _coupon = TextEditingController();
  final _notes = TextEditingController();
  final _search = TextEditingController();

  String _paymentMethod = 'COD';
  String _paymentStatus = 'Pending';
  String _shippingMethod = 'Standard Delivery';
  double _shipping = 0;
  double _discount = 0;
  CustomerAdmin? _customer;
  final List<FinalOrderItem> _items = [];

  @override
  void dispose() {
    for (final c in [
      _name, _mobile, _email, _address, _city, _state, _pin, _coupon, _notes, _search
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  double get _subtotal => _items.fold(0, (sum, item) => sum + item.lineTotal);
  double get _grandTotal => (_subtotal - _discount + _shipping).clamp(0, double.infinity).toDouble();

  void _pickCustomer() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * .75,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Select Customer',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 12),
                ...widget.customers.where((c) => c.enabled).map(
                  (customer) => ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person_rounded)),
                    title: Text(customer.name),
                    subtitle: Text(customer.email),
                    onTap: () {
                      setState(() {
                        _customer = customer;
                        _name.text = customer.name;
                        _email.text = customer.email;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addProduct(ProductAdmin product) {
    final existing = _items.where((i) => i.product.id == product.id);
    if (existing.isNotEmpty) {
      setState(() => existing.first.quantity++);
    } else {
      setState(() {
        _items.add(
          FinalOrderItem(product: product, quantity: 1, unitPrice: product.price),
        );
      });
    }
    _search.clear();
  }

  void _submit() {
    if (_name.text.trim().isEmpty) {
      _message('Enter customer name.');
      return;
    }
    if (_items.isEmpty) {
      _message('Add at least one product.');
      return;
    }

    final id = widget.nextOrderNumber();
    final payment = _paymentStatus == 'Paid'
        ? 'Paid'
        : _paymentMethod == 'COD'
            ? 'COD'
            : 'Pending';

    final order = OrderAdmin(
      id,
      _name.text.trim(),
      _grandTotal,
      'Pending',
      payment,
    );

    Navigator.pop(
      context,
      FinalOrderData(
        order: order,
        items: List<FinalOrderItem>.from(_items),
        customerName: _name.text.trim(),
        mobile: _mobile.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        city: _city.text.trim(),
        state: _state.text.trim(),
        pincode: _pin.text.trim(),
        paymentMethod: _paymentMethod,
        paymentStatus: _paymentStatus,
        shippingMethod: _shippingMethod,
        awb: '',
        courier: '',
        notes: _notes.text.trim(),
        discount: _discount,
        shippingCharge: _shipping,
        coupon: _coupon.text.trim(),
      ),
    );
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderNumber = widget.nextOrderNumber();
    final available = widget.products.where((p) => p.enabled).where((p) {
      final q = _search.text.trim().toLowerCase();
      return q.isEmpty ||
          p.name.toLowerCase().contains(q) ||
          p.id.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q);
    }).take(8).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: Text(
          'Manual Order • $orderNumber',
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(
            'Customer',
            Icons.person_outline_rounded,
            [
              Row(
                children: [
                  Expanded(child: _field(_name, 'Customer Name', Icons.person_rounded)),
                  const SizedBox(width: 10),
                  OutlinedButton.icon(
                    onPressed: _pickCustomer,
                    icon: const Icon(Icons.people_alt_rounded),
                    label: const Text('Select'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _field(_mobile, 'Mobile Number', Icons.phone_rounded,
                  keyboard: TextInputType.phone),
              const SizedBox(height: 10),
              _field(_email, 'Email', Icons.email_rounded,
                  keyboard: TextInputType.emailAddress),
            ],
          ),
          _section(
            'Products',
            Icons.inventory_2_outlined,
            [
              TextField(
                controller: _search,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search_rounded),
                  hintText: 'Search product by name, ID or category',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              if (_search.text.trim().isNotEmpty)
                ...available.map(
                  (p) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(child: Icon(Icons.inventory_2_rounded)),
                    title: Text(p.name),
                    subtitle: Text('${p.id} • ${p.category} • Stock ${p.stock}'),
                    trailing: Text(
                      '₹${p.price.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    onTap: () => _addProduct(p),
                  ),
                ),
              if (_items.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: Text('No products added yet.')),
                )
              else
                ..._items.map(_itemRow),
            ],
          ),
          _section(
            'Delivery Address',
            Icons.location_on_outlined,
            [
              _field(_address, 'Full Address', Icons.home_rounded, maxLines: 2),
              const SizedBox(height: 10),
              _responsiveFields([
                _field(_city, 'City', Icons.location_city_rounded),
                _field(_state, 'State', Icons.map_rounded),
                _field(_pin, 'PIN Code', Icons.pin_drop_rounded,
                    keyboard: TextInputType.number),
              ]),
            ],
          ),
          _section(
            'Payment & Shipping',
            Icons.payments_outlined,
            [
              _responsiveFields([
                _drop(
                  'Payment Method',
                  _paymentMethod,
                  ['COD', 'Online', 'UPI', 'Bank Transfer'],
                  (v) => setState(() => _paymentMethod = v),
                ),
                _drop(
                  'Payment Status',
                  _paymentStatus,
                  ['Pending', 'Paid', 'Failed'],
                  (v) => setState(() => _paymentStatus = v),
                ),
                _drop(
                  'Shipping',
                  _shippingMethod,
                  ['Standard Delivery', 'Express Delivery', 'Local Delivery', 'Pickup'],
                  (v) => setState(() => _shippingMethod = v),
                ),
              ]),
              const SizedBox(height: 10),
              _responsiveFields([
                _numberField(
                  'Shipping Charge',
                  _shipping,
                  (v) => setState(() => _shipping = v),
                ),
                _numberField(
                  'Order Discount',
                  _discount,
                  (v) => setState(() => _discount = v),
                ),
                _field(_coupon, 'Coupon Code', Icons.local_offer_rounded),
              ]),
            ],
          ),
          _section(
            'Order Summary',
            Icons.receipt_long_outlined,
            [
              _summaryLine('Subtotal', _subtotal),
              _summaryLine('Discount', -_discount),
              _summaryLine('Shipping', _shipping),
              const Divider(height: 22),
              _summaryLine('Grand Total', _grandTotal, bold: true),
            ],
          ),
          _section(
            'Internal Notes',
            Icons.notes_rounded,
            [
              _field(_notes, 'Notes for admin/staff', Icons.notes_rounded, maxLines: 4),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.check_circle_rounded),
            label: Text('Create $orderNumber'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _section(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 9),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType? keyboard,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: maxLines == 1 ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _numberField(String label, double value, ValueChanged<double> onChanged) {
    return TextFormField(
      initialValue: value.toStringAsFixed(0),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        prefixText: '₹ ',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (v) => onChanged(double.tryParse(v) ?? 0),
    );
  }

  Widget _drop(
    String label,
    String value,
    List<String> values,
    ValueChanged<String> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: values.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }

  Widget _responsiveFields(List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 650) {
          return Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                children[i],
                if (i != children.length - 1) const SizedBox(height: 10),
              ],
            ],
          );
        }
        return Row(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              Expanded(child: children[i]),
              if (i != children.length - 1) const SizedBox(width: 10),
            ],
          ],
        );
      },
    );
  }

  Widget _itemRow(FinalOrderItem item) {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                  Text('₹${item.unitPrice.toStringAsFixed(2)} each'),
                ],
              ),
            ),
            IconButton(
              onPressed: () => setState(() {
                if (item.quantity > 1) {
                  item.quantity--;
                } else {
                  _items.remove(item);
                }
              }),
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.w800)),
            IconButton(
              onPressed: () => setState(() => item.quantity++),
              icon: const Icon(Icons.add_circle_outline),
            ),
            Text(
              '₹${item.lineTotal.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryLine(String label, double value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: bold ? FontWeight.w900 : FontWeight.w500)),
        Text(
          '${value < 0 ? '-' : ''}₹${value.abs().toStringAsFixed(2)}',
          style: TextStyle(fontWeight: bold ? FontWeight.w900 : FontWeight.w700),
        ),
      ],
    );
  }
}

class FinalOrderDetailsPage extends StatefulWidget {
  const FinalOrderDetailsPage({
    super.key,
    required this.order,
    required this.products,
    required this.customers,
    required this.onChanged,
  });

  final OrderAdmin order;
  final List<ProductAdmin> products;
  final List<CustomerAdmin> customers;
  final VoidCallback onChanged;

  @override
  State<FinalOrderDetailsPage> createState() => _FinalOrderDetailsPageState();
}

class _FinalOrderDetailsPageState extends State<FinalOrderDetailsPage> {
  String _status = 'Pending';
  String _courier = '';
  String _awb = '';
  String _notes = '';
  String _paymentStatus = 'Pending';

  @override
  void initState() {
    super.initState();
    _status = widget.order.status;
    _paymentStatus = widget.order.payment == 'Paid' ? 'Paid' : 'Pending';
  }

  void _saveStatus(String value) {
    setState(() {
      _status = value;
      widget.order.status = value;
    });
    widget.onChanged();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order status updated.')),
    );
  }

  void _cancelOrder() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order?'),
        content: Text('Are you sure you want to cancel ${widget.order.id}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          FilledButton(
            onPressed: () {
              _saveStatus('Cancelled');
              Navigator.pop(context);
            },
            child: const Text('Cancel Order'),
          ),
        ],
      ),
    );
  }

  void _showTracking() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Shipping & Tracking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Courier',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => _courier = v,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'AWB / Tracking Number',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => _awb = v,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          FilledButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tracking details saved.')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _invoice() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invoice • ${widget.order.id}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${widget.order.customer}'),
            const SizedBox(height: 8),
            Text('Order: ${widget.order.id}'),
            const SizedBox(height: 8),
            Text('Status: ${widget.order.status}'),
            const SizedBox(height: 8),
            Text('Payment: ${widget.order.payment}'),
            const Divider(height: 22),
            Text(
              'Total: ₹${widget.order.amount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invoice preview ready. PDF/print integration can be connected later.'),
                ),
              );
            },
            icon: const Icon(Icons.print_rounded),
            label: const Text('Print'),
          ),
        ],
      ),
    );
  }

  void _refund() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Refund Order'),
        content: Text(
          'Refund workflow for ${widget.order.id} will use ₹${widget.order.amount.toStringAsFixed(2)} as the maximum amount.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Refund marked for processing.')),
              );
            },
            child: const Text('Mark Refund'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statuses = const [
      'Pending',
      'Confirmed',
      'Processing',
      'Shipped',
      'Delivered',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: Text(
          widget.order.id,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            tooltip: 'Invoice',
            onPressed: _invoice,
            icon: const Icon(Icons.receipt_long_rounded),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'cancel') _cancelOrder();
              if (value == 'refund') _refund();
              if (value == 'tracking') _showTracking();
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'tracking', child: Text('Shipping & Tracking')),
              PopupMenuItem(value: 'refund', child: Text('Refund')),
              PopupMenuItem(value: 'cancel', child: Text('Cancel Order')),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _hero(),
          _section(
            'Order Status',
            Icons.timeline_rounded,
            [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: statuses
                    .map(
                      (s) => ChoiceChip(
                        label: Text(s),
                        selected: _status == s,
                        onSelected: (_) => _saveStatus(s),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 18),
              _timeline(statuses),
            ],
          ),
          _section(
            'Customer',
            Icons.person_outline_rounded,
            [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(child: Icon(Icons.person_rounded)),
                title: Text(widget.order.customer),
                subtitle: const Text('Customer information'),
                trailing: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Customer profile opened.')),
                    );
                  },
                  child: const Text('View'),
                ),
              ),
            ],
          ),
          _section(
            'Payment',
            Icons.payments_outlined,
            [
              _infoRow('Payment', widget.order.payment),
              _infoRow('Payment Status', _paymentStatus),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _paymentStatus = _paymentStatus == 'Paid' ? 'Pending' : 'Paid';
                    widget.order.payment = _paymentStatus == 'Paid' ? 'Paid' : 'Pending';
                  });
                  widget.onChanged();
                },
                icon: const Icon(Icons.sync_rounded),
                label: Text(
                  _paymentStatus == 'Paid'
                      ? 'Mark Payment Pending'
                      : 'Mark as Paid',
                ),
              ),
            ],
          ),
          _section(
            'Order Amount',
            Icons.currency_rupee_rounded,
            [
              _infoRow('Order Total', '₹${widget.order.amount.toStringAsFixed(2)}', bold: true),
            ],
          ),
          _section(
            'Shipping & Tracking',
            Icons.local_shipping_outlined,
            [
              _infoRow('Courier', _courier.isEmpty ? 'Not assigned' : _courier),
              _infoRow('AWB', _awb.isEmpty ? 'Not assigned' : _awb),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: _showTracking,
                icon: const Icon(Icons.local_shipping_rounded),
                label: const Text('Update Tracking'),
              ),
            ],
          ),
          _section(
            'Internal Notes',
            Icons.notes_rounded,
            [
              TextField(
                maxLines: 4,
                controller: TextEditingController(text: _notes),
                onChanged: (v) => _notes = v,
                decoration: const InputDecoration(
                  hintText: 'Add staff/admin notes...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _cancelOrder,
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('Cancel Order'),
          ),
          const SizedBox(height: 10),
          FilledButton.icon(
            onPressed: _refund,
            icon: const Icon(Icons.currency_exchange_rounded),
            label: const Text('Return / Refund'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _hero() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '₹${widget.order.amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 5),
            Text(widget.order.customer, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _badge(widget.order.status),
                _badge(widget.order.payment),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeline(List<String> statuses) {
    final current = statuses.indexOf(_status);
    return Column(
      children: [
        for (var i = 0; i < statuses.length; i++)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 15,
              child: Icon(
                i <= current ? Icons.check_rounded : Icons.circle_outlined,
                size: 17,
              ),
            ),
            title: Text(
              statuses[i],
              style: TextStyle(
                fontWeight: i == current ? FontWeight.w900 : FontWeight.w500,
              ),
            ),
            subtitle: i == current ? const Text('Current status') : null,
          ),
      ],
    );
  }

  Widget _section(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(top: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 9),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: Colors.black54))),
          Text(value, style: TextStyle(fontWeight: bold ? FontWeight.w900 : FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _badge(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.06),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}


class CustomersModule extends StatefulWidget {
  const CustomersModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<CustomersModule> createState() => _CustomersModuleState();
}

class _CustomerExtra {
  String mobile = '';
  String alternateMobile = '';
  String dob = '';
  String gender = 'Not specified';
  String address = '';
  String city = '';
  String state = '';
  String pincode = '';
  String landmark = '';
  String type = 'Regular';
  String notes = '';
  double wallet = 0;
  int points = 0;
}

class _CustomersModuleState extends State<CustomersModule> {
  final _search = TextEditingController();
  final Map<String, _CustomerExtra> _extra = {};
  String _status = 'All';
  String _type = 'All';
  String _sort = 'Newest';

  _CustomerExtra extra(CustomerAdmin c) =>
      _extra.putIfAbsent(c.id, _CustomerExtra.new);

  List<CustomerAdmin> get customers {
    final q = _search.text.trim().toLowerCase();
    final list = widget.data.customers.where((c) {
      final x = extra(c);
      final match = q.isEmpty ||
          c.id.toLowerCase().contains(q) ||
          c.name.toLowerCase().contains(q) ||
          c.email.toLowerCase().contains(q) ||
          x.mobile.toLowerCase().contains(q);
      final status = _status == 'All' ||
          (_status == 'Active' && c.enabled) ||
          (_status == 'Blocked' && !c.enabled);
      final type = _type == 'All' || x.type == _type;
      return match && status && type;
    }).toList();

    if (_sort == 'Name A-Z') {
      list.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } else if (_sort == 'Orders') {
      list.sort((a, b) => _orders(b).compareTo(_orders(a)));
    } else if (_sort == 'Spending') {
      list.sort((a, b) => _spend(b).compareTo(_spend(a)));
    }
    return list;
  }

  int _orders(CustomerAdmin c) =>
      widget.data.orders.where((o) => o.customer == c.name).length;

  double _spend(CustomerAdmin c) => widget.data.orders
      .where((o) => o.customer == c.name)
      .fold<double>(0, (s, o) => s + o.amount);

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final active = widget.data.customers.where((c) => c.enabled).length;
    final blocked = widget.data.customers.length - active;
    final sales = widget.data.orders.fold<double>(0, (s, o) => s + o.amount);

    return _Page(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ModuleHeader(
            title: 'Customers',
            subtitle:
                'Profiles, orders, addresses, wallet, rewards and account controls',
            icon: Icons.people_alt_rounded,
            actions: [
              _PrimaryButton(
                label: 'Add Customer',
                icon: Icons.person_add_alt_1_rounded,
                onPressed: () => _form(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _StatsStrip(items: [
            ['Customers', '${widget.data.customers.length}', Icons.people_alt_rounded],
            ['Active', '$active', Icons.check_circle_rounded],
            ['Blocked', '$blocked', Icons.block_rounded],
            ['Orders', '${widget.data.orders.length}', Icons.shopping_bag_rounded],
            ['Sales', '₹${sales.toStringAsFixed(0)}', Icons.currency_rupee_rounded],
          ]),
          const SizedBox(height: 12),
          _toolbar(),
          const SizedBox(height: 10),
          ...customers.map(_card),
          if (customers.isEmpty) _empty(),
        ],
      ),
    );
  }

  Widget _toolbar() => _SectionCard(
        title: 'Customer Directory',
        icon: Icons.manage_search_rounded,
        child: Column(
          children: [
            TextField(
              controller: _search,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search name, mobile, email or customer ID',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _search.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _search.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear_rounded),
                      ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...['All', 'Active', 'Blocked'].map((v) => ChoiceChip(
                      label: Text(v),
                      selected: _status == v,
                      onSelected: (_) => setState(() => _status = v),
                    )),
                _drop(_type, ['All', 'Regular', 'Wholesale', 'Reseller', 'VIP'],
                    (v) => setState(() => _type = v!)),
                _drop(_sort, ['Newest', 'Name A-Z', 'Orders', 'Spending'],
                    (v) => setState(() => _sort = v!)),
              ],
            ),
          ],
        ),
      );

  Widget _drop(String value, List<String> items, ValueChanged<String?> onChanged) =>
      SizedBox(
        width: 155,
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            labelText: 'Filter',
            border: OutlineInputBorder(),
            isDense: true,
          ),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      );

  Widget _card(CustomerAdmin c) {
    final x = extra(c);
    final count = _orders(c);
    final spend = _spend(c);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: Text(
                      c.name.isEmpty ? '?' : c.name[0].toUpperCase(),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.name,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800)),
                        Text('${c.id} • ${x.type}'),
                        Text(x.mobile.isEmpty ? c.email : '${x.mobile} • ${c.email}',
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Switch(
                    value: c.enabled,
                    onChanged: (v) => setState(() => c.enabled = v),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _metric('Orders', '$count'),
                  _metric('Spent', '₹${spend.toStringAsFixed(0)}'),
                  _metric('Wallet', '₹${x.wallet.toStringAsFixed(0)}'),
                  _metric('Points', '${x.points}'),
                ],
              ),
              const Divider(height: 22),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _ActionChip(
                    label: 'Profile',
                    icon: Icons.person_outline_rounded,
                    onTap: () => _profile(c),
                  ),
                  _ActionChip(
                    label: 'Edit',
                    icon: Icons.edit_rounded,
                    onTap: () => _form(item: c),
                  ),
                  _ActionChip(
                    label: 'Orders',
                    icon: Icons.shopping_bag_outlined,
                    onTap: () => _ordersDialog(c),
                  ),
                  _ActionChip(
                    label: c.enabled ? 'Block' : 'Activate',
                    icon: c.enabled
                        ? Icons.lock_outline_rounded
                        : Icons.lock_open_rounded,
                    onTap: () => setState(() => c.enabled = !c.enabled),
                  ),
                  _ActionChip(
                    label: 'Wallet',
                    icon: Icons.account_balance_wallet_outlined,
                    onTap: () => _wallet(c),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metric(String title, String value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F5FA),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Text('$title\n$value',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
      );

  Widget _empty() => _SectionCard(
        title: 'No customers found',
        icon: Icons.person_search_rounded,
        child: const Center(child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('Try another search/filter or add a new customer.'),
        )),
      );

  Future<void> _form({CustomerAdmin? item}) async {
    final x = item == null ? _CustomerExtra() : extra(item);
    final id = TextEditingController(
        text: item?.id ?? 'U${DateTime.now().millisecondsSinceEpoch}');
    final name = TextEditingController(text: item?.name ?? '');
    final mobile = TextEditingController(text: x.mobile);
    final alt = TextEditingController(text: x.alternateMobile);
    final email = TextEditingController(text: item?.email ?? '');
    final dob = TextEditingController(text: x.dob);
    final address = TextEditingController(text: x.address);
    final city = TextEditingController(text: x.city);
    final state = TextEditingController(text: x.state);
    final pin = TextEditingController(text: x.pincode);
    final landmark = TextEditingController(text: x.landmark);
    final notes = TextEditingController(text: x.notes);
    String gender = x.gender;
    String type = x.type;

    await showDialog(
      context: context,
      builder: (dialog) => StatefulBuilder(
        builder: (context, setD) => AlertDialog(
          title: Text(item == null ? 'Add Customer' : 'Edit Customer'),
          content: SizedBox(
            width: 650,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _section('Account Information', Icons.badge_outlined, [
                    _field(id, 'Customer ID', readOnly: true),
                    _field(name, 'Full Name *'),
                    _field(mobile, 'Mobile Number *', keyboard: TextInputType.phone),
                    _field(alt, 'Alternate Mobile', keyboard: TextInputType.phone),
                    _field(email, 'Email', keyboard: TextInputType.emailAddress),
                  ]),
                  _section('Personal & Type', Icons.person_outline_rounded, [
                    _field(dob, 'Date of Birth'),
                    _select('Gender', gender,
                        ['Not specified', 'Male', 'Female', 'Other'],
                        (v) => setD(() => gender = v!)),
                    _select('Customer Type', type,
                        ['Regular', 'Wholesale', 'Reseller', 'VIP'],
                        (v) => setD(() => type = v!)),
                  ]),
                  _section('Address', Icons.location_on_outlined, [
                    _field(address, 'Address', lines: 2),
                    _field(landmark, 'Landmark'),
                    _field(city, 'City'),
                    _field(state, 'State'),
                    _field(pin, 'Pincode', keyboard: TextInputType.number),
                  ]),
                  _section('Internal Notes', Icons.notes_rounded, [
                    _field(notes, 'Private notes', lines: 3),
                  ]),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialog), child: const Text('Cancel')),
            FilledButton.icon(
              icon: const Icon(Icons.save_rounded),
              label: Text(item == null ? 'Create Customer' : 'Save Changes'),
              onPressed: () {
                if (name.text.trim().isEmpty || mobile.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Name and mobile are required.')));
                  return;
                }
                setState(() {
                  if (item == null) {
                    final c = CustomerAdmin(
                        id.text.trim(), name.text.trim(), email.text.trim(), true);
                    widget.data.customers.add(c);
                    final n = extra(c);
                    n.mobile = mobile.text.trim();
                    n.alternateMobile = alt.text.trim();
                    n.dob = dob.text.trim();
                    n.gender = gender;
                    n.type = type;
                    n.address = address.text.trim();
                    n.city = city.text.trim();
                    n.state = state.text.trim();
                    n.pincode = pin.text.trim();
                    n.landmark = landmark.text.trim();
                    n.notes = notes.text.trim();
                  } else {
                    item.id = id.text.trim();
                    item.name = name.text.trim();
                    item.email = email.text.trim();
                    x.mobile = mobile.text.trim();
                    x.alternateMobile = alt.text.trim();
                    x.dob = dob.text.trim();
                    x.gender = gender;
                    x.type = type;
                    x.address = address.text.trim();
                    x.city = city.text.trim();
                    x.state = state.text.trim();
                    x.pincode = pin.text.trim();
                    x.landmark = landmark.text.trim();
                    x.notes = notes.text.trim();
                  }
                });
                Navigator.pop(dialog);
              },
            ),
          ],
        ),
      ),
    );

    for (final c in [
      id, name, mobile, alt, email, dob, address, city, state, pin, landmark, notes
    ]) {
      c.dispose();
    }
  }

  Widget _section(String title, IconData icon, List<Widget> children) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Icon(icon, size: 19), const SizedBox(width: 7),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800))]),
            const SizedBox(height: 9),
            ...children,
          ],
        ),
      );

  Widget _field(TextEditingController c, String label,
      {bool readOnly = false, TextInputType? keyboard, int lines = 1}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: TextField(
          controller: c,
          readOnly: readOnly,
          keyboardType: keyboard,
          maxLines: lines,
          decoration: InputDecoration(
              labelText: label, border: const OutlineInputBorder()),
        ),
      );

  Widget _select(String label, String value, List<String> items,
          ValueChanged<String?> onChanged) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
              labelText: label, border: const OutlineInputBorder()),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      );

  void _profile(CustomerAdmin c) {
    final x = extra(c);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _CustomerProfilePage(
          customer: c,
          extra: x,
          orders: widget.data.orders.where((o) => o.customer == c.name).toList(),
          spend: _spend(c),
        ),
      ),
    ).then((_) => mounted ? setState(() {}) : null);
  }

  void _ordersDialog(CustomerAdmin c) {
    final orders = widget.data.orders.where((o) => o.customer == c.name).toList();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .72,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${c.name} — Orders',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              Expanded(
                child: orders.isEmpty
                    ? const Center(child: Text('No orders found.'))
                    : ListView.separated(
                        itemCount: orders.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 7),
                        itemBuilder: (_, i) {
                          final o = orders[i];
                          return ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                                side: BorderSide(color: Colors.grey.shade300)),
                            leading: const Icon(Icons.receipt_long_rounded),
                            title: Text(o.id),
                            subtitle: Text('${o.status} • ${o.payment}'),
                            trailing: Text('₹${o.amount.toStringAsFixed(0)}',
                                style: const TextStyle(fontWeight: FontWeight.w800)),
                          );
                        },
                      ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _wallet(CustomerAdmin c) {
    final x = extra(c);
    final amount = TextEditingController();
    String action = 'Add';
    showDialog(
      context: context,
      builder: (dialog) => StatefulBuilder(
        builder: (context, setD) => AlertDialog(
          title: Text('${c.name} — Wallet'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('Current: ₹${x.wallet.toStringAsFixed(2)}'),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: action,
              items: const [
                DropdownMenuItem(value: 'Add', child: Text('Add Balance')),
                DropdownMenuItem(value: 'Deduct', child: Text('Deduct Balance')),
              ],
              onChanged: (v) => setD(() => action = v!),
              decoration: const InputDecoration(
                  labelText: 'Action', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 9),
            TextField(
              controller: amount,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                  labelText: 'Amount', prefixText: '₹ ',
                  border: OutlineInputBorder()),
            ),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialog), child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                final v = double.tryParse(amount.text.trim()) ?? 0;
                if (v <= 0) return;
                setState(() {
                  x.wallet = action == 'Add'
                      ? x.wallet + v
                      : (x.wallet - v).clamp(0, double.infinity).toDouble();
                });
                Navigator.pop(dialog);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    ).then((_) => amount.dispose());
  }
}

class _CustomerProfilePage extends StatelessWidget {
  const _CustomerProfilePage({
    required this.customer,
    required this.extra,
    required this.orders,
    required this.spend,
  });

  final CustomerAdmin customer;
  final _CustomerExtra extra;
  final List<OrderAdmin> orders;
  final double spend;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Profile'),
        actions: [
          IconButton(
            icon: Icon(customer.enabled
                ? Icons.lock_outline_rounded
                : Icons.lock_open_rounded),
            onPressed: () {
              customer.enabled = !customer.enabled;
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _hero(),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: [
            _stat('Orders', '${orders.length}'),
            _stat('Spent', '₹${spend.toStringAsFixed(0)}'),
            _stat('Wallet', '₹${extra.wallet.toStringAsFixed(0)}'),
            _stat('Points', '${extra.points}'),
          ]),
          const SizedBox(height: 12),
          _section('Personal Information', Icons.person_outline_rounded, [
            _info('Customer ID', customer.id),
            _info('Name', customer.name),
            _info('Mobile', extra.mobile),
            _info('Alternate Mobile', extra.alternateMobile),
            _info('Email', customer.email),
            _info('DOB', extra.dob),
            _info('Gender', extra.gender),
            _info('Type', extra.type),
          ]),
          _section('Address', Icons.location_on_outlined, [
            _info('Address', extra.address),
            _info('Landmark', extra.landmark),
            _info('City', extra.city),
            _info('State', extra.state),
            _info('Pincode', extra.pincode),
          ]),
          _section('Order History', Icons.shopping_bag_outlined, orders.isEmpty
              ? [const Text('No orders found.')]
              : orders.map((o) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.receipt_long_rounded),
                    title: Text(o.id),
                    subtitle: Text('${o.status} • ${o.payment}'),
                    trailing: Text('₹${o.amount.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.w800)),
                  )).toList()),
          _section('Notes', Icons.notes_rounded, [
            Text(extra.notes.isEmpty ? 'No internal notes.' : extra.notes),
          ]),
        ],
      ),
    );
  }

  Widget _hero() => Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(children: [
            CircleAvatar(
              radius: 32,
              child: Text(customer.name.isEmpty ? '?' : customer.name[0].toUpperCase(),
                  style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800)),
            ),
            const SizedBox(width: 13),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(customer.name,
                  style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
              Text('${customer.id} • ${extra.type}'),
              const SizedBox(height: 4),
              Text(customer.enabled ? 'Active' : 'Blocked'),
            ])),
          ]),
        ),
      );

  Widget _stat(String title, String value) => Container(
        width: 145,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        ]),
      );

  Widget _section(String title, IconData icon, List<Widget> children) => Card(
        elevation: 0,
        margin: const EdgeInsets.only(top: 12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Icon(icon, size: 20), const SizedBox(width: 7),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            ]),
            const Divider(height: 22),
            ...children,
          ]),
        ),
      );

  Widget _info(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: 105, child: Text(label,
              style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600))),
          Expanded(child: Text(value.isEmpty ? '—' : value,
              style: const TextStyle(fontWeight: FontWeight.w600))),
        ]),
      );
}

class CustomOrdersModule extends StatefulWidget {
  const CustomOrdersModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<CustomOrdersModule> createState() => _CustomOrdersModuleState();
}

class _CustomOrdersModuleState extends State<CustomOrdersModule> {
  @override
  Widget build(BuildContext context) {
    return _Page(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'Custom Orders',
            subtitle: 'Create manual orders, quotations, items, price and status',
            icon: Icons.assignment_rounded,
            actions: [
              _PrimaryButton(label: 'New Custom Order', icon: Icons.add_rounded, onPressed: () => _dialog()),
            ],
          ),
          ...widget.data.customOrders.map(
            (o) => _AdminListCard(
              title: '${o.id} • ${o.customer}',
              subtitle: '${o.request} • ${o.status}',
              icon: Icons.assignment_rounded,
              color: const Color(0xFF12AFC0),
              actions: [
                _ActionChip(label: 'Edit', icon: Icons.edit_rounded, onTap: () => _dialog(item: o)),
                _ActionChip(label: 'Status', icon: Icons.sync_rounded, onTap: () => _status(o)),
                _ActionChip(label: 'Delete', icon: Icons.delete_outline_rounded, danger: true, onTap: () => setState(() => widget.data.customOrders.remove(o))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialog({CustomOrderAdmin? item}) async {
    final id = TextEditingController(text: item?.id ?? 'CO${DateTime.now().millisecondsSinceEpoch}');
    final customer = TextEditingController(text: item?.customer ?? '');
    final request = TextEditingController(text: item?.request ?? '');
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: item == null ? 'New Custom Order' : 'Edit Custom Order',
        children: [_Field(id, 'Order ID'), _Field(customer, 'Customer'), _Field(request, 'Requirement', lines: 4)],
        onSave: () {
          setState(() {
            if (item == null) {
              widget.data.customOrders.add(CustomOrderAdmin(id.text, customer.text, request.text, 'New'));
            } else {
              item.id = id.text;
              item.customer = customer.text;
              item.request = request.text;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
    id.dispose();
    customer.dispose();
    request.dispose();
  }

  Future<void> _status(CustomOrderAdmin item) async {
    await showDialog(
      context: context,
      builder: (context) => _ChoiceDialog(
        title: 'Custom Order Status',
        value: item.status,
        choices: const ['New', 'Quotation', 'Processing', 'Ready', 'Completed', 'Cancelled'],
        onSave: (v) {
          setState(() => item.status = v);
          Navigator.pop(context);
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// VENDORS
// -----------------------------------------------------------------------------

class VendorsModule extends StatefulWidget {
  const VendorsModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<VendorsModule> createState() => _VendorsModuleState();
}

class _VendorsModuleState extends State<VendorsModule> {
  @override
  Widget build(BuildContext context) {
    return _PartnerModule(
      title: 'Vendors',
      subtitle: 'Add, approve, edit, pause, activate and delete vendors',
      icon: Icons.store_rounded,
      color: const Color(0xFF8B3DFF),
      items: widget.data.vendors,
      onAdd: () => _dialog(),
      onEdit: (p) => _dialog(item: p),
      onDelete: (p) => setState(() => widget.data.vendors.remove(p)),
      onToggle: (p, v) => setState(() => p.enabled = v),
    );
  }

  Future<void> _dialog({PartnerAdmin? item}) async {
    final id = TextEditingController(text: item?.id ?? 'V${DateTime.now().millisecondsSinceEpoch}');
    final name = TextEditingController(text: item?.name ?? '');
    final email = TextEditingController(text: item?.email ?? '');
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: item == null ? 'Add Vendor' : 'Edit Vendor',
        children: [_Field(id, 'Vendor ID'), _Field(name, 'Vendor Name'), _Field(email, 'Email')],
        onSave: () {
          setState(() {
            if (item == null) {
              widget.data.vendors.add(PartnerAdmin(id.text, name.text, email.text, 'Pending', true));
            } else {
              item.id = id.text;
              item.name = name.text;
              item.email = email.text;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
    id.dispose();
    name.dispose();
    email.dispose();
  }
}

// -----------------------------------------------------------------------------
// RESELLERS
// -----------------------------------------------------------------------------

class ResellersModule extends StatefulWidget {
  const ResellersModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<ResellersModule> createState() => _ResellersModuleState();
}

class _ResellersModuleState extends State<ResellersModule> {
  @override
  Widget build(BuildContext context) {
    return _PartnerModule(
      title: 'Resellers',
      subtitle: 'Create, edit, pause, activate, block and delete reseller accounts',
      icon: Icons.groups_rounded,
      color: const Color(0xFFFF3E7D),
      items: widget.data.resellers,
      onAdd: () => _dialog(),
      onEdit: (p) => _dialog(item: p),
      onDelete: (p) => setState(() => widget.data.resellers.remove(p)),
      onToggle: (p, v) => setState(() => p.enabled = v),
    );
  }

  Future<void> _dialog({PartnerAdmin? item}) async {
    final id = TextEditingController(text: item?.id ?? 'R${DateTime.now().millisecondsSinceEpoch}');
    final name = TextEditingController(text: item?.name ?? '');
    final email = TextEditingController(text: item?.email ?? '');
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: item == null ? 'Add Reseller' : 'Edit Reseller',
        children: [_Field(id, 'Reseller ID'), _Field(name, 'Name'), _Field(email, 'Email')],
        onSave: () {
          setState(() {
            if (item == null) {
              widget.data.resellers.add(PartnerAdmin(id.text, name.text, email.text, 'Active', true));
            } else {
              item.id = id.text;
              item.name = name.text;
              item.email = email.text;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
    id.dispose();
    name.dispose();
    email.dispose();
  }
}

class _PartnerModule extends StatelessWidget {
  const _PartnerModule({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.items,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  final String title, subtitle;
  final IconData icon;
  final Color color;
  final List<PartnerAdmin> items;
  final VoidCallback onAdd;
  final ValueChanged<PartnerAdmin> onEdit;
  final ValueChanged<PartnerAdmin> onDelete;
  final void Function(PartnerAdmin, bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return _Page(
      child: Column(
        children: [
          _ModuleHeader(
            title: title,
            subtitle: subtitle,
            icon: icon,
            actions: [_PrimaryButton(label: 'Add ${title.substring(0, title.length - 1)}', icon: Icons.add_rounded, onPressed: onAdd)],
          ),
          ...items.map(
            (p) => _AdminListCard(
              title: '${p.name} • ${p.id}',
              subtitle: '${p.email} • ${p.status}',
              icon: icon,
              color: color,
              enabled: p.enabled,
              onToggle: (v) => onToggle(p, v),
              actions: [
                _ActionChip(label: 'Edit', icon: Icons.edit_rounded, onTap: () => onEdit(p)),
                _ActionChip(label: p.enabled ? 'Pause' : 'Activate', icon: Icons.pause_circle_outline_rounded, onTap: () => onToggle(p, !p.enabled)),
                _ActionChip(label: 'Delete', icon: Icons.delete_outline_rounded, danger: true, onTap: () => onDelete(p)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// AFFILIATES
// -----------------------------------------------------------------------------

class AffiliatesModule extends StatefulWidget {
  const AffiliatesModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<AffiliatesModule> createState() => _AffiliatesModuleState();
}

class _AffiliatesModuleState extends State<AffiliatesModule> {
  @override
  Widget build(BuildContext context) {
    return _Page(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'Affiliates',
            subtitle: 'Create affiliates, commissions, pause, activate and payout controls',
            icon: Icons.share_rounded,
            actions: [_PrimaryButton(label: 'Add Affiliate', icon: Icons.add_rounded, onPressed: () => _dialog())],
          ),
          ...widget.data.affiliates.map(
            (a) => _AdminListCard(
              title: '${a.name} • ${a.id}',
              subtitle: '${a.email} • Earnings ₹${a.earnings.toStringAsFixed(0)} • ${a.status}',
              icon: Icons.share_rounded,
              color: const Color(0xFF16C96A),
              enabled: a.enabled,
              onToggle: (v) => setState(() => a.enabled = v),
              actions: [
                _ActionChip(label: 'Edit', icon: Icons.edit_rounded, onTap: () => _dialog(item: a)),
                _ActionChip(label: 'Payout', icon: Icons.payments_rounded, onTap: () => _showSnack(context, 'Affiliate payout opened.')),
                _ActionChip(label: 'Delete', icon: Icons.delete_outline_rounded, danger: true, onTap: () => setState(() => widget.data.affiliates.remove(a))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialog({AffiliateAdmin? item}) async {
    final id = TextEditingController(text: item?.id ?? 'A${DateTime.now().millisecondsSinceEpoch}');
    final name = TextEditingController(text: item?.name ?? '');
    final email = TextEditingController(text: item?.email ?? '');
    final earnings = TextEditingController(text: item?.earnings.toString() ?? '0');
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: item == null ? 'Add Affiliate' : 'Edit Affiliate',
        children: [_Field(id, 'Affiliate ID'), _Field(name, 'Name'), _Field(email, 'Email'), _Field(earnings, 'Earnings', keyboard: TextInputType.number)],
        onSave: () {
          setState(() {
            if (item == null) {
              widget.data.affiliates.add(AffiliateAdmin(id.text, name.text, email.text, double.tryParse(earnings.text) ?? 0, 'Active', true));
            } else {
              item.id = id.text;
              item.name = name.text;
              item.email = email.text;
              item.earnings = double.tryParse(earnings.text) ?? item.earnings;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
    id.dispose();
    name.dispose();
    email.dispose();
    earnings.dispose();
  }
}

// -----------------------------------------------------------------------------
// WALLET & REWARDS
// -----------------------------------------------------------------------------

class WalletRewardsModule extends StatefulWidget {
  const WalletRewardsModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<WalletRewardsModule> createState() => _WalletRewardsModuleState();
}

class _WalletRewardsModuleState extends State<WalletRewardsModule> {
  @override
  Widget build(BuildContext context) {
    final balance = widget.data.wallet.fold<double>(
      0,
      (sum, x) => sum + (x.type == 'Credit' ? x.amount : -x.amount),
    );

    return _Page(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'Wallet & Rewards',
            subtitle: 'Add money, debit, credit, rewards and transaction controls',
            icon: Icons.card_giftcard_rounded,
            actions: [
              _PrimaryButton(label: 'Add Money', icon: Icons.add_rounded, onPressed: () => _moneyDialog()),
            ],
          ),
          _StatsStrip(items: [
            ['Balance', '₹${balance.toStringAsFixed(0)}', Icons.account_balance_wallet_rounded],
            ['Transactions', '${widget.data.wallet.length}', Icons.receipt_long_rounded],
            ['Rewards', 'Active', Icons.stars_rounded],
          ]),
          const SizedBox(height: 12),
          _ActionGrid(
            actions: [
              _ToolAction('Add Money', Icons.add_circle_rounded, _moneyDialog),
              _ToolAction('Debit Money', Icons.remove_circle_rounded, () => _moneyDialog(debit: true)),
              _ToolAction('Reward Points', Icons.stars_rounded, () => _showSnack(context, 'Reward point rules opened.')),
              _ToolAction('Referral Rules', Icons.share_rounded, () => _showSnack(context, 'Referral rules opened.')),
              _ToolAction('Wallet Limits', Icons.speed_rounded, () => _showSnack(context, 'Wallet limits opened.')),
              _ToolAction('Transactions', Icons.receipt_long_rounded, () => _showSnack(context, 'Wallet transactions opened.')),
            ],
          ),
          const SizedBox(height: 12),
          ...widget.data.wallet.map(
            (w) => _AdminListCard(
              title: '${w.type} • ₹${w.amount.toStringAsFixed(0)}',
              subtitle: w.note,
              icon: w.type == 'Credit' ? Icons.add_circle_rounded : Icons.remove_circle_rounded,
              color: w.type == 'Credit' ? const Color(0xFF16C96A) : const Color(0xFFFF315B),
              actions: [
                _ActionChip(label: 'Delete', icon: Icons.delete_outline_rounded, danger: true, onTap: () => setState(() => widget.data.wallet.remove(w))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _moneyDialog({bool debit = false}) async {
    final amount = TextEditingController();
    final note = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: debit ? 'Debit Wallet Money' : 'Add Wallet Money',
        children: [_Field(amount, 'Amount', keyboard: TextInputType.number), _Field(note, 'Note')],
        onSave: () {
          final value = double.tryParse(amount.text) ?? 0;
          if (value > 0) {
            setState(() {
              widget.data.wallet.add(
                WalletTransaction(
                  'W${DateTime.now().millisecondsSinceEpoch}',
                  note.text.isEmpty ? (debit ? 'Wallet debit' : 'Manual wallet credit') : note.text,
                  value,
                  debit ? 'Debit' : 'Credit',
                ),
              );
            });
          }
          Navigator.pop(context);
        },
      ),
    );
    amount.dispose();
    note.dispose();
  }
}

// -----------------------------------------------------------------------------
// INVENTORY
// -----------------------------------------------------------------------------

class InventoryModule extends StatefulWidget {
  const InventoryModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<InventoryModule> createState() => _InventoryModuleState();
}

class _InventoryModuleState extends State<InventoryModule> {
  @override
  Widget build(BuildContext context) {
    final low = widget.data.products.where((p) => p.stock < 10).length;
    final total = widget.data.products.fold<int>(0, (s, p) => s + p.stock);

    return _Page(
      child: Column(
        children: [
          const _ModuleHeader(
            title: 'Inventory',
            subtitle: 'Stock, purchase, low-stock alerts and inventory controls',
            icon: Icons.warehouse_rounded,
          ),
          _StatsStrip(items: [
            ['Products', '${widget.data.products.length}', Icons.inventory_2_rounded],
            ['Units', '$total', Icons.warehouse_rounded],
            ['Low Stock', '$low', Icons.warning_amber_rounded],
          ]),
          const SizedBox(height: 12),
          _ActionGrid(
            actions: [
              _ToolAction('Stock In', Icons.add_box_rounded, () => _stockDialog(true)),
              _ToolAction('Stock Out', Icons.indeterminate_check_box_rounded, () => _stockDialog(false)),
              _ToolAction('Purchase', Icons.shopping_cart_checkout_rounded, () => _showSnack(context, 'Purchase entry opened.')),
              _ToolAction('Suppliers', Icons.business_rounded, () => _showSnack(context, 'Supplier management opened.')),
              _ToolAction('Low Stock', Icons.warning_amber_rounded, () => _showSnack(context, '$low products need attention.')),
              _ToolAction('Stock Report', Icons.assessment_rounded, () => _showSnack(context, 'Stock report opened.')),
            ],
          ),
          const SizedBox(height: 12),
          ...widget.data.products.map(
            (p) => _AdminListCard(
              title: '${p.name} • Stock ${p.stock}',
              subtitle: p.stock < 10 ? 'Low stock' : 'Stock available',
              icon: Icons.inventory_2_rounded,
              color: p.stock < 10 ? const Color(0xFFFF9F0A) : const Color(0xFF2196F3),
              actions: [
                _ActionChip(label: 'Adjust', icon: Icons.tune_rounded, onTap: () => _adjust(p)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _stockDialog(bool add) async {
    if (widget.data.products.isEmpty) return;
    final amount = TextEditingController(text: '1');
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: add ? 'Stock In' : 'Stock Out',
        children: [_Field(amount, 'Units', keyboard: TextInputType.number)],
        onSave: () {
          final value = int.tryParse(amount.text) ?? 0;
          if (value > 0) {
            setState(() {
              final p = widget.data.products.first;
              final nextStock = add ? p.stock + value : p.stock - value;
              p.stock = nextStock < 0
                  ? 0
                  : nextStock > 999999
                      ? 999999
                      : nextStock;
            });
          }
          Navigator.pop(context);
        },
      ),
    );
    amount.dispose();
  }

  Future<void> _adjust(ProductAdmin p) async {
    final amount = TextEditingController(text: p.stock.toString());
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: 'Set Stock • ${p.name}',
        children: [_Field(amount, 'Current Stock', keyboard: TextInputType.number)],
        onSave: () {
          setState(() {
            final nextStock = int.tryParse(amount.text);
            if (nextStock != null && nextStock >= 0) {
              p.stock = nextStock;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
    amount.dispose();
  }
}

// -----------------------------------------------------------------------------
// REPORTS
// -----------------------------------------------------------------------------

class ReportsModule extends StatelessWidget {
  const ReportsModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    final revenue = data.orders.fold<double>(0, (s, o) => s + o.amount);
    return _Page(
      child: Column(
        children: [
          const _ModuleHeader(
            title: 'Reports & Analytics',
            subtitle: 'Sales, customers, products, partners and financial reports',
            icon: Icons.bar_chart_rounded,
          ),
          _StatsStrip(items: [
            ['Revenue', '₹${revenue.toStringAsFixed(0)}', Icons.currency_rupee_rounded],
            ['Orders', '${data.orders.length}', Icons.shopping_bag_rounded],
            ['Customers', '${data.customers.length}', Icons.people_alt_rounded],
          ]),
          const SizedBox(height: 12),
          _ActionGrid(
            actions: [
              _ToolAction('Sales Report', Icons.show_chart_rounded, () => _report(context, 'Sales Report')),
              _ToolAction('Orders Report', Icons.receipt_long_rounded, () => _report(context, 'Orders Report')),
              _ToolAction('Customer Report', Icons.people_alt_rounded, () => _report(context, 'Customer Report')),
              _ToolAction('Inventory Report', Icons.inventory_2_rounded, () => _report(context, 'Inventory Report')),
              _ToolAction('Vendor Report', Icons.store_rounded, () => _report(context, 'Vendor Report')),
              _ToolAction('Export', Icons.download_rounded, () => _showSnack(context, 'Export options opened.')),
            ],
          ),
        ],
      ),
    );
  }

  void _report(BuildContext context, String title) {
    _showDetails(context, title, 'Report filters, date range, export and print options are ready.');
  }
}

// -----------------------------------------------------------------------------
// MARKETING
// -----------------------------------------------------------------------------

class MarketingModule extends StatefulWidget {
  const MarketingModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<MarketingModule> createState() => _MarketingModuleState();
}

class _MarketingModuleState extends State<MarketingModule> {
  final Map<String, bool> tools = {
    'WhatsApp Marketing': false,
    'SMS Marketing': false,
    'Email Marketing': false,
    'Push Notifications': true,
    'Referral Campaigns': true,
    'Affiliate Campaigns': true,
  };

  final List<String> campaigns = ['Festive Offer', 'Welcome Campaign'];

  @override
  Widget build(BuildContext context) {
    return _Page(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'Marketing',
            subtitle: 'Campaigns, banners, WhatsApp/SMS/email tools and API controls',
            icon: Icons.campaign_rounded,
            actions: [
              _PrimaryButton(label: 'Create Campaign', icon: Icons.add_rounded, onPressed: () => _campaignDialog()),
            ],
          ),
          _ActionGrid(
            actions: [
              _ToolAction('Banners', Icons.image_rounded, () => _showSnack(context, 'Banner manager opened.')),
              _ToolAction('WhatsApp', Icons.chat_rounded, () => _credentialDialog('WhatsApp API')),
              _ToolAction('SMS', Icons.sms_rounded, () => _credentialDialog('SMS API')),
              _ToolAction('Email', Icons.email_rounded, () => _credentialDialog('SMTP / Email API')),
              _ToolAction('Push', Icons.notifications_active_rounded, () => _credentialDialog('Firebase Push')),
              _ToolAction('Coupons', Icons.local_offer_rounded, () => _showSnack(context, 'Coupon manager opened.')),
              _ToolAction('Referral', Icons.share_rounded, () => _showSnack(context, 'Referral campaign opened.')),
              _ToolAction('Analytics', Icons.analytics_rounded, () => _showSnack(context, 'Marketing analytics opened.')),
            ],
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Marketing Tools',
            icon: Icons.tune_rounded,
            child: Column(
              children: tools.entries
                  .map(
                    (e) => SwitchListTile(
                      title: Text(e.key),
                      subtitle: Text(e.value ? 'Enabled' : 'Disabled'),
                      value: e.value,
                      onChanged: (v) => setState(() => tools[e.key] = v),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          ...campaigns.map(
            (c) => _AdminListCard(
              title: c,
              subtitle: 'Campaign ready to edit or pause',
              icon: Icons.campaign_rounded,
              color: const Color(0xFF1689E8),
              actions: [
                _ActionChip(label: 'Edit', icon: Icons.edit_rounded, onTap: () => _campaignDialog(name: c)),
                _ActionChip(label: 'Delete', icon: Icons.delete_outline_rounded, danger: true, onTap: () => setState(() => campaigns.remove(c))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _campaignDialog({String? name}) async {
    final controller = TextEditingController(text: name ?? '');
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: name == null ? 'Create Campaign' : 'Edit Campaign',
        children: [_Field(controller, 'Campaign Name')],
        onSave: () {
          setState(() {
            if (name == null) {
              campaigns.add(controller.text);
            } else {
              final index = campaigns.indexOf(name);
              if (index >= 0) campaigns[index] = controller.text;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
    controller.dispose();
  }

  void _credentialDialog(String title) => showDialog(
        context: context,
        builder: (context) => _CredentialDialog(title: title),
      );
}

// -----------------------------------------------------------------------------
// NOTIFICATIONS
// -----------------------------------------------------------------------------

class NotificationsModule extends StatefulWidget {
  const NotificationsModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<NotificationsModule> createState() => _NotificationsModuleState();
}

class _NotificationsModuleState extends State<NotificationsModule> {
  final List<Map<String, dynamic>> templates = [
    {'title': 'Order Confirmed', 'message': 'Your order has been confirmed.', 'enabled': true},
    {'title': 'Order Shipped', 'message': 'Your order is on the way.', 'enabled': true},
    {'title': 'Payment Failed', 'message': 'Payment could not be completed.', 'enabled': true},
    {'title': 'Welcome', 'message': 'Welcome to K - Store.', 'enabled': false},
  ];

  @override
  Widget build(BuildContext context) {
    return _Page(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'Notifications',
            subtitle: 'Templates, push notifications and customer communication',
            icon: Icons.notifications_rounded,
            actions: [
              _PrimaryButton(label: 'Add Template', icon: Icons.add_rounded, onPressed: () => _dialog()),
            ],
          ),
          ...templates.map(
            (t) => _AdminListCard(
              title: t['title'] as String,
              subtitle: t['message'] as String,
              icon: Icons.notifications_rounded,
              color: const Color(0xFF8E44EC),
              enabled: t['enabled'] as bool,
              onToggle: (v) => setState(() => t['enabled'] = v),
              actions: [
                _ActionChip(label: 'Edit', icon: Icons.edit_rounded, onTap: () => _dialog(item: t)),
                _ActionChip(label: 'Delete', icon: Icons.delete_outline_rounded, danger: true, onTap: () => setState(() => templates.remove(t))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _ActionGrid(
            actions: [
              _ToolAction('Send Now', Icons.send_rounded, () => _showSnack(context, 'Send notification opened.')),
              _ToolAction('Schedule', Icons.schedule_rounded, () => _showSnack(context, 'Notification scheduler opened.')),
              _ToolAction('Push Settings', Icons.settings_rounded, () => _showSnack(context, 'Push settings opened.')),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _dialog({Map<String, dynamic>? item}) async {
    final title = TextEditingController(text: item?['title'] as String? ?? '');
    final message = TextEditingController(text: item?['message'] as String? ?? '');
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: item == null ? 'Add Notification Template' : 'Edit Notification Template',
        children: [_Field(title, 'Title'), _Field(message, 'Message', lines: 3)],
        onSave: () {
          setState(() {
            if (item == null) {
              templates.add({'title': title.text, 'message': message.text, 'enabled': true});
            } else {
              item['title'] = title.text;
              item['message'] = message.text;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
    title.dispose();
    message.dispose();
  }
}

// -----------------------------------------------------------------------------
// API INTEGRATIONS
// -----------------------------------------------------------------------------

class ApiIntegrationsModule extends StatefulWidget {
  const ApiIntegrationsModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<ApiIntegrationsModule> createState() => _ApiIntegrationsModuleState();
}

class _ApiIntegrationsModuleState extends State<ApiIntegrationsModule> {
  @override
  Widget build(BuildContext context) {
    return _Page(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'API & Integrations',
            subtitle: 'Add, edit, test, enable, disable and remove any integration',
            icon: Icons.extension_rounded,
            actions: [
              _PrimaryButton(label: 'Add API', icon: Icons.add_rounded, onPressed: () => _dialog()),
            ],
          ),
          _InfoBanner(
            icon: Icons.lock_rounded,
            text: 'For production, store API keys and secrets on a secure backend, not inside the mobile APK.',
          ),
          const SizedBox(height: 12),
          ...widget.data.integrations.map(
            (i) => _AdminListCard(
              title: '${i.name} • ${i.id}',
              subtitle: '${i.type} • ${i.description}',
              icon: Icons.extension_rounded,
              color: const Color(0xFF19B75A),
              enabled: i.enabled,
              onToggle: (v) => setState(() => i.enabled = v),
              actions: [
                _ActionChip(label: 'Configure', icon: Icons.settings_rounded, onTap: () => _dialog(item: i)),
                _ActionChip(label: 'Test', icon: Icons.bolt_rounded, onTap: () => _showSnack(context, '${i.name} test initiated.')),
                _ActionChip(label: 'Delete', icon: Icons.delete_outline_rounded, danger: true, onTap: () => setState(() => widget.data.integrations.remove(i))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _ActionGrid(
            actions: [
              _ToolAction('Payment APIs', Icons.payments_rounded, () => _dialog(type: 'Payment')),
              _ToolAction('Shipping APIs', Icons.local_shipping_rounded, () => _dialog(type: 'Shipping')),
              _ToolAction('Marketing APIs', Icons.campaign_rounded, () => _dialog(type: 'Marketing')),
              _ToolAction('WhatsApp API', Icons.chat_rounded, () => _dialog(type: 'WhatsApp')),
              _ToolAction('Firebase', Icons.cloud_rounded, () => _dialog(type: 'Firebase')),
              _ToolAction('Webhooks', Icons.webhook_rounded, () => _showSnack(context, 'Webhook manager opened.')),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _dialog({ApiIntegration? item, String? type}) async {
    final id = TextEditingController(text: item?.id ?? 'I${DateTime.now().millisecondsSinceEpoch}');
    final name = TextEditingController(text: item?.name ?? '');
    final kind = TextEditingController(text: item?.type ?? type ?? 'Custom API');
    final key = TextEditingController();
    final secret = TextEditingController();
    final endpoint = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: item == null ? 'Add API Integration' : 'Configure ${item.name}',
        children: [
          _Field(id, 'Integration ID'),
          _Field(name, 'Service Name'),
          _Field(kind, 'API Type'),
          _Field(endpoint, 'API Endpoint / Base URL'),
          _Field(key, 'API Key / Client ID'),
          _Field(secret, 'Secret / Password', obscure: true),
        ],
        onSave: () {
          setState(() {
            if (item == null) {
              widget.data.integrations.add(ApiIntegration(id.text, name.text, kind.text, 'Configured', true));
            } else {
              item.id = id.text;
              item.name = name.text;
              item.type = kind.text;
              item.description = endpoint.text.isEmpty ? 'Configured' : endpoint.text;
              item.enabled = true;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
    id.dispose();
    name.dispose();
    kind.dispose();
    key.dispose();
    secret.dispose();
    endpoint.dispose();
  }
}

// -----------------------------------------------------------------------------
// STAFF & ROLES
// -----------------------------------------------------------------------------

class StaffRolesModule extends StatefulWidget {
  const StaffRolesModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<StaffRolesModule> createState() => _StaffRolesModuleState();
}

class _StaffRolesModuleState extends State<StaffRolesModule> {
  final Map<String, bool> roleLimits = {
    'Products': true,
    'Orders': true,
    'Customers': true,
    'Payments': false,
    'Settings': false,
    'API & Integrations': false,
    'Reports': true,
  };

  @override
  Widget build(BuildContext context) {
    return _Page(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'Staff & Roles',
            subtitle: 'Create staff IDs/passwords, assign work, limits and permissions',
            icon: Icons.manage_accounts_rounded,
            actions: [
              _PrimaryButton(label: 'Add Staff', icon: Icons.person_add_rounded, onPressed: () => _dialog()),
            ],
          ),
          ...widget.data.staff.map(
            (s) => _AdminListCard(
              title: '${s.name} • ${s.id}',
              subtitle: '${s.email} • ${s.role} • ${s.permissions}',
              icon: Icons.manage_accounts_rounded,
              color: const Color(0xFF607080),
              enabled: s.enabled,
              onToggle: (v) => setState(() => s.enabled = v),
              actions: [
                _ActionChip(label: 'Edit', icon: Icons.edit_rounded, onTap: () => _dialog(item: s)),
                _ActionChip(label: 'Permissions', icon: Icons.admin_panel_settings_rounded, onTap: () => _permissions(s)),
                _ActionChip(label: 'Reset Password', icon: Icons.password_rounded, onTap: () => _showSnack(context, 'Password reset workflow opened.')),
                _ActionChip(label: 'Delete', icon: Icons.delete_outline_rounded, danger: true, onTap: () => setState(() => widget.data.staff.remove(s))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Default Role Limits',
            icon: Icons.lock_person_rounded,
            child: Column(
              children: roleLimits.entries
                  .map(
                    (e) => SwitchListTile(
                      title: Text(e.key),
                      subtitle: const Text('Allow this module for selected staff roles'),
                      value: e.value,
                      onChanged: (v) => setState(() => roleLimits[e.key] = v),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialog({StaffAdmin? item}) async {
    final id = TextEditingController(text: item?.id ?? 'ST${DateTime.now().millisecondsSinceEpoch}');
    final name = TextEditingController(text: item?.name ?? '');
    final email = TextEditingController(text: item?.email ?? '');
    final role = TextEditingController(text: item?.role ?? 'Staff');
    final password = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: item == null ? 'Add Staff' : 'Edit Staff',
        children: [
          _Field(id, 'Staff ID / Login ID'),
          _Field(name, 'Name'),
          _Field(email, 'Email'),
          _Field(role, 'Role'),
          _Field(password, item == null ? 'Password' : 'New Password', obscure: true),
        ],
        onSave: () {
          setState(() {
            if (item == null) {
              widget.data.staff.add(StaffAdmin(id.text, name.text, email.text, role.text, 'Selected permissions', true));
            } else {
              item.id = id.text;
              item.name = name.text;
              item.email = email.text;
              item.role = role.text;
            }
          });
          Navigator.pop(context);
        },
      ),
    );
    id.dispose();
    name.dispose();
    email.dispose();
    role.dispose();
    password.dispose();
  }

  Future<void> _permissions(StaffAdmin staff) async {
    await showDialog(
      context: context,
      builder: (context) => _PermissionsDialog(
        title: '${staff.name} Permissions',
        onSave: (value) => setState(() => staff.permissions = value),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SETTINGS
// -----------------------------------------------------------------------------

class SettingsModule extends StatefulWidget {
  const SettingsModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<SettingsModule> createState() => _SettingsModuleState();
}

class _SettingsModuleState extends State<SettingsModule> {
  @override
  Widget build(BuildContext context) {
    return _Page(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'Settings',
            subtitle: 'Manage every major store, order, payment, customer and business setting',
            icon: Icons.settings_rounded,
            actions: [
              _PrimaryButton(label: 'Add Setting', icon: Icons.add_rounded, onPressed: () => _customSetting()),
            ],
          ),
          _SettingsGroup(
            title: 'Store & Checkout',
            icon: Icons.storefront_rounded,
            entries: ['Store Open', 'Customer Registration', 'Guest Checkout', 'COD', 'Online Payments'],
            values: widget.data.settings,
            onChanged: (k, v) => setState(() => widget.data.settings[k] = v),
          ),
          _SettingsGroup(
            title: 'Growth & Loyalty',
            icon: Icons.trending_up_rounded,
            entries: ['Reviews', 'Referral Program', 'Reseller Program', 'Affiliate Program'],
            values: widget.data.settings,
            onChanged: (k, v) => setState(() => widget.data.settings[k] = v),
          ),
          _SettingsGroup(
            title: 'System',
            icon: Icons.tune_rounded,
            entries: ['Maintenance Mode'],
            values: widget.data.settings,
            onChanged: (k, v) => setState(() => widget.data.settings[k] = v),
          ),
          const SizedBox(height: 12),
          _ActionGrid(
            actions: [
              _ToolAction('Store Profile', Icons.store_rounded, () => _keyDialog('Store Profile')),
              _ToolAction('Tax / GST', Icons.receipt_long_rounded, () => _keyDialog('Tax & GST')),
              _ToolAction('Invoice', Icons.description_rounded, () => _keyDialog('Invoice Settings')),
              _ToolAction('Email', Icons.email_rounded, () => _keyDialog('Email Settings')),
              _ToolAction('WhatsApp', Icons.chat_rounded, () => _keyDialog('WhatsApp Settings')),
              _ToolAction('Backup', Icons.backup_rounded, () => _showSnack(context, 'Backup options opened.')),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _customSetting() async {
    final name = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => _FormDialog(
        title: 'Add Setting',
        children: [_Field(name, 'Setting Name')],
        onSave: () {
          setState(() => widget.data.settings[name.text] = true);
          Navigator.pop(context);
        },
      ),
    );
    name.dispose();
  }

  void _keyDialog(String title) => showDialog(
        context: context,
        builder: (context) => _CredentialDialog(title: title),
      );
}

// -----------------------------------------------------------------------------
// SECURITY
// -----------------------------------------------------------------------------

class SecurityModule extends StatefulWidget {
  const SecurityModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<SecurityModule> createState() => _SecurityModuleState();
}

class _SecurityModuleState extends State<SecurityModule> {
  final Map<String, bool> security = {
    'Two-factor authentication': true,
    'Login attempt limit': true,
    'Session timeout': true,
    'Password policy': true,
    'Device/session management': true,
    'Audit log': true,
    'API secret protection': true,
    'Admin notification on login': true,
  };

  @override
  Widget build(BuildContext context) {
    return _Page(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'Account & Security',
            subtitle: 'Protect admin access, sessions, passwords, API secrets and activity',
            icon: Icons.security_rounded,
            actions: [
              _PrimaryButton(label: 'Security Test', icon: Icons.shield_rounded, onPressed: () => _showSnack(context, 'Security checklist opened.')),
            ],
          ),
          _InfoBanner(
            icon: Icons.warning_amber_rounded,
            text: 'Never store real admin passwords or API secrets directly in the mobile app.',
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Security Controls',
            icon: Icons.security_rounded,
            child: Column(
              children: security.entries
                  .map(
                    (e) => SwitchListTile(
                      title: Text(e.key),
                      value: e.value,
                      onChanged: (v) => setState(() => security[e.key] = v),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          _ActionGrid(
            actions: [
              _ToolAction('Change Password', Icons.password_rounded, () => _credentialDialog('Change Password')),
              _ToolAction('2FA Setup', Icons.verified_user_rounded, () => _showSnack(context, '2FA setup opened.')),
              _ToolAction('Active Sessions', Icons.devices_rounded, () => _showSnack(context, 'Active sessions opened.')),
              _ToolAction('Audit Logs', Icons.history_rounded, () => _showSnack(context, 'Audit logs opened.')),
              _ToolAction('Login Rules', Icons.rule_rounded, () => _showSnack(context, 'Login rules opened.')),
              _ToolAction('API Secrets', Icons.key_rounded, () => _showSnack(context, 'Secure API secret manager opened.')),
            ],
          ),
        ],
      ),
    );
  }

  void _credentialDialog(String title) => showDialog(
        context: context,
        builder: (context) => _CredentialDialog(title: title),
      );
}

// -----------------------------------------------------------------------------
// SHARED UI
// -----------------------------------------------------------------------------

class _Page extends StatelessWidget {
  const _Page({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            constraints.maxWidth > 800 ? 28 : 14,
            18,
            constraints.maxWidth > 800 ? 28 : 14,
            28,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.title, required this.subtitle, required this.icon});
  final String title, subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFEFF5), Color(0xFFF2ECFF)],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(fontSize: 16, color: Color(0xFF626B79))),
              ],
            ),
          ),
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFF315B), Color(0xFF8B3DFF)]),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(icon, color: Colors.white, size: 40),
          ),
        ],
      ),
    );
  }
}

class _HomeModuleButton extends StatelessWidget {
  const _HomeModuleButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title, subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(19),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(11, 11, 8, 9),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(.045),
                color.withOpacity(.10),
              ],
            ),
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: color.withOpacity(.10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 47,
                    height: 47,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(.18),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 27),
                  ),
                  const Spacer(),
                  Icon(Icons.chevron_right_rounded, color: color, size: 27),
                ],
              ),
              const Spacer(),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11.5, color: Color(0xFF6C7480)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsStrip extends StatelessWidget {
  const _StatsStrip({required this.items});
  final List<List<dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, index) => const SizedBox(width: 9),
        itemBuilder: (context, index) {
          final x = items[index];
          return Container(
            width: 150,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: const Color(0xFFECEEF3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 39,
                  height: 39,
                  decoration: BoxDecoration(
                    color: (x[2] as IconData).hashCode.isEven
                        ? const Color(0xFFFFEFF5)
                        : const Color(0xFFF0ECFF),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(x[2] as IconData, size: 21, color: const Color(0xFFFF315B)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${x[1]}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
                      Text('${x[0]}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Color(0xFF707887))),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ModuleHeader extends StatelessWidget {
  const _ModuleHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.actions = const [],
  });

  final String title, subtitle;
  final IconData icon;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFF315B), Color(0xFF8B3DFF)]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                const SizedBox(height: 3),
                Text(subtitle, style: const TextStyle(color: Color(0xFF687180), fontSize: 12)),
              ],
            ),
          ),
          ...actions,
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.icon, required this.onPressed});
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF315B),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox({required this.hint, required this.onChanged});
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search_rounded),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: BorderSide.none),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.value, required this.values, required this.onChanged});
  final String value;
  final List<String> values;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: 'Filter',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
      ),
      items: values.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}

class _AdminListCard extends StatelessWidget {
  const _AdminListCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.enabled,
    this.onToggle,
    this.actions = const [],
  });

  final String title, subtitle;
  final IconData icon;
  final Color color;
  final bool? enabled;
  final ValueChanged<bool>? onToggle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
        side: const BorderSide(color: Color(0xFFECEEF3)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: color.withOpacity(.11),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 3),
                      Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Color(0xFF697383))),
                    ],
                  ),
                ),
                if (enabled != null && onToggle != null)
                  Switch(value: enabled!, onChanged: onToggle),
              ],
            ),
            if (actions.isNotEmpty) ...[
              const Divider(height: 18),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(spacing: 6, runSpacing: 6, children: actions),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.label,
    required this.icon,
    required this.onTap,
    this.danger = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? const Color(0xFFD92D4B) : const Color(0xFF344054);
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 15),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({required this.actions});
  final List<_ToolAction> actions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final count = c.maxWidth > 700 ? 4 : 2;
        return GridView.count(
          crossAxisCount: count,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 9,
          mainAxisSpacing: 9,
          childAspectRatio: 2.7,
          children: actions.map((a) => _ToolButton(action: a)).toList(),
        );
      },
    );
  }
}

class _ToolAction {
  const _ToolAction(this.label, this.icon, this.onTap);
  final String label;
  final IconData icon;
  final VoidCallback onTap;
}

class _ToolButton extends StatelessWidget {
  const _ToolButton({required this.action});
  final _ToolAction action;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: action.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFE8EAF0)),
          ),
          child: Row(
            children: [
              Icon(action.icon, color: const Color(0xFFFF315B), size: 22),
              const SizedBox(width: 8),
              Expanded(child: Text(action.label, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
              const Icon(Icons.chevron_right_rounded, size: 19),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.icon, required this.child});
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
        side: const BorderSide(color: Color(0xFFECEEF3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFFFF315B)),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
              ],
            ),
            const Divider(height: 18),
            child,
          ],
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({
    required this.title,
    required this.icon,
    required this.entries,
    required this.values,
    required this.onChanged,
  });

  final String title;
  final IconData icon;
  final List<String> entries;
  final Map<String, bool> values;
  final void Function(String, bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: title,
      icon: icon,
      child: Column(
        children: entries
            .map(
              (key) => SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(key),
                value: values[key] ?? false,
                onChanged: (v) => onChanged(key, v),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6E6),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFFFE1A8)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: Color(0xFFB26A00)),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12.5))),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Center(child: Text(text, style: const TextStyle(color: Color(0xFF777F8B)))),
    );
  }
}

class _FooterAdminCard extends StatelessWidget {
  const _FooterAdminCard({required this.onLogout});
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xFFFFE6EE),
          child: Icon(Icons.person_rounded, color: Color(0xFFFF315B)),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Admin', style: TextStyle(fontWeight: FontWeight.w800)),
              Text('admin@kstore.com', style: TextStyle(color: Color(0xFF6C7480), fontSize: 12)),
            ],
          ),
        ),
        OutlinedButton.icon(
          onPressed: onLogout,
          icon: const Icon(Icons.logout_rounded),
          label: const Text('Logout'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFFF315B),
            side: const BorderSide(color: Color(0xFFFFC2D0)),
          ),
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  const _Field(
    this.controller,
    this.label, {
    this.keyboard,
    this.lines = 1,
    this.obscure = false,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboard;
  final int lines;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        maxLines: obscure ? 1 : lines,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _FormDialog extends StatelessWidget {
  const _FormDialog({
    required this.title,
    required this.children,
    required this.onSave,
  });

  final String title;
  final List<Widget> children;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: onSave, child: const Text('Save')),
      ],
    );
  }
}

class _CredentialDialog extends StatefulWidget {
  const _CredentialDialog({required this.title});
  final String title;

  @override
  State<_CredentialDialog> createState() => _CredentialDialogState();
}

class _CredentialDialogState extends State<_CredentialDialog> {
  final keyController = TextEditingController();
  final secretController = TextEditingController();
  final endpointController = TextEditingController();
  bool enabled = true;

  @override
  void dispose() {
    keyController.dispose();
    secretController.dispose();
    endpointController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Field(endpointController, 'Endpoint / URL'),
            _Field(keyController, 'API Key / Client ID'),
            _Field(secretController, 'Secret / Password', obscure: true),
            SwitchListTile(
              title: const Text('Enable after save'),
              value: enabled,
              onChanged: (v) => setState(() => enabled = v),
            ),
            const SizedBox(height: 5),
            const Text(
              'Keys entered here are demo UI fields. Use a secure backend/secret store for real production credentials.',
              style: TextStyle(fontSize: 11, color: Color(0xFF687180)),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        OutlinedButton(
          onPressed: () => _showSnack(context, 'Connection test initiated.'),
          child: const Text('Test'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _ChoiceDialog extends StatefulWidget {
  const _ChoiceDialog({
    required this.title,
    required this.value,
    required this.choices,
    required this.onSave,
  });

  final String title, value;
  final List<String> choices;
  final ValueChanged<String> onSave;

  @override
  State<_ChoiceDialog> createState() => _ChoiceDialogState();
}

class _ChoiceDialogState extends State<_ChoiceDialog> {
  late String value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: DropdownButtonFormField<String>(
        initialValue: value,
        items: widget.choices.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() => value = v ?? value),
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: () => widget.onSave(value), child: const Text('Save')),
      ],
    );
  }
}

class _PermissionsDialog extends StatefulWidget {
  const _PermissionsDialog({required this.title, required this.onSave});
  final String title;
  final ValueChanged<String> onSave;

  @override
  State<_PermissionsDialog> createState() => _PermissionsDialogState();
}

class _PermissionsDialogState extends State<_PermissionsDialog> {
  final Map<String, bool> permissions = {
    'Products': true,
    'Orders': true,
    'Customers': true,
    'Payments': false,
    'Marketing': false,
    'Vendors': false,
    'Resellers': false,
    'Reports': true,
    'Settings': false,
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            children: permissions.entries
                .map(
                  (e) => SwitchListTile(
                    title: Text(e.key),
                    value: e.value,
                    onChanged: (v) => setState(() => permissions[e.key] = v),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            final enabled = permissions.entries.where((e) => e.value).map((e) => e.key).join(', ');
            widget.onSave(enabled);
            Navigator.pop(context);
          },
          child: const Text('Save Permissions'),
        ),
      ],
    );
  }
}

void _showDetails(BuildContext context, String title, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    ),
  );
}

void _showSnack(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}
