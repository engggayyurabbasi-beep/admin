import 'package:flutter/material.dart';

/// K - Store Complete Admin System
/// Single-file admin system for the K - Store Admin Panel.
///
/// This file intentionally keeps the complete UI/module structure in one file.
/// It uses local in-memory state so every control is functional immediately.
/// Backend/API/database wiring can later replace the repository methods without
/// changing the page architecture.

class KStoreAdminSystem extends StatefulWidget {
  const KStoreAdminSystem({super.key});

  @override
  State<KStoreAdminSystem> createState() => _KStoreAdminSystemState();
}

class _KStoreAdminSystemState extends State<KStoreAdminSystem> {
  int selected = 0;
  final List<int> history = [0];

  final KStoreAdminData data = KStoreAdminData.seed();

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
    Icons.dashboard_outlined,
    Icons.inventory_2_outlined,
    Icons.category_outlined,
    Icons.shopping_bag_outlined,
    Icons.people_outline,
    Icons.local_offer_outlined,
    Icons.payments_outlined,
    Icons.local_shipping_outlined,
    Icons.assignment_outlined,
    Icons.storefront_outlined,
    Icons.groups_outlined,
    Icons.campaign_outlined,
    Icons.account_balance_wallet_outlined,
    Icons.warehouse_outlined,
    Icons.analytics_outlined,
    Icons.campaign_outlined,
    Icons.notifications_none,
    Icons.api_outlined,
    Icons.admin_panel_settings_outlined,
    Icons.settings_outlined,
    Icons.security_outlined,
  ];

  void openModule(int value) {
    if (value == selected) return;
    setState(() {
      history.add(value);
      selected = value;
    });
  }

  void goBack() {
    if (history.length <= 1) return;
    setState(() {
      history.removeLast();
      selected = history.last;
    });
  }

  @override
  Widget build(BuildContext context) {
    final page = _page(selected);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (history.length > 1) {
          goBack();
          return;
        }
        showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Exit Admin Panel?'),
            content: const Text('Do you want to close the K - Store Admin Panel?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Exit'),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        appBar: AppBar(
          title: Text(modules[selected]),
          leading: history.length > 1
              ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: goBack)
              : null,
          actions: [
            IconButton(
              tooltip: 'Notifications',
              onPressed: () => openModule(16),
              icon: const Icon(Icons.notifications_none),
            ),
            IconButton(
              tooltip: 'Account',
              onPressed: () => openModule(20),
              icon: const Icon(Icons.account_circle_outlined),
            ),
          ],
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                const UserAccountsDrawerHeader(
                  accountName: Text('K - Store Admin'),
                  accountEmail: Text('Administrator'),
                  currentAccountPicture: CircleAvatar(
                    child: Text('K', style: TextStyle(fontSize: 26)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: modules.length,
                    itemBuilder: (_, i) => ListTile(
                      selected: selected == i,
                      leading: Icon(icons[i]),
                      title: Text(modules[i]),
                      onTap: () {
                        Navigator.pop(context);
                        openModule(i);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: page,
      ),
    );
  }

  Widget _page(int i) {
    switch (i) {
      case 0:
        return DashboardModule(data: data, onOpen: openModule);
      case 1:
        return ProductModule(data: data);
      case 2:
        return CategoryModule(data: data);
      case 3:
        return OrderModule(data: data);
      case 4:
        return CustomerModule(data: data);
      case 5:
        return OfferModule(data: data);
      case 6:
        return PaymentModule(data: data);
      case 7:
        return ShippingModule(data: data);
      case 8:
        return CustomOrderModule(data: data);
      case 9:
        return VendorModule(data: data);
      case 10:
        return ResellerModule(data: data);
      case 11:
        return AffiliateModule(data: data);
      case 12:
        return WalletRewardModule(data: data);
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
        return SecurityModule(data: data);
      default:
        return DashboardModule(data: data, onOpen: openModule);
    }
  }
}

// -----------------------------------------------------------------------------
// DATA
// -----------------------------------------------------------------------------

class KStoreAdminData extends ChangeNotifier {
  KStoreAdminData.seed();

  final List<ProductItem> products = [
    ProductItem('P001', 'Herbal Product A', 'General', 299, 399, 50),
    ProductItem('P002', 'Premium Herbal Syrup', 'Syrups', 499, 599, 24),
    ProductItem('P003', 'Wellness Powder', 'Powders', 249, 299, 8),
  ];

  final List<CategoryItem> categories = [
    CategoryItem('C001', 'Ayurvedic', 24, true),
    CategoryItem('C002', 'Unani', 18, true),
    CategoryItem('C003', 'Herbal', 32, true),
  ];

  final List<OrderItem> orders = [
    OrderItem('ORD-1001', 'Customer One', 1299, 'Pending', 'COD'),
    OrderItem('ORD-1002', 'Customer Two', 899, 'Processing', 'UPI'),
    OrderItem('ORD-1003', 'Customer Three', 2199, 'Shipped', 'Card'),
  ];

  final List<CustomerItem> customers = [
    CustomerItem('CU001', 'Customer One', 'customer1@example.com', 'Active', 6),
    CustomerItem('CU002', 'Customer Two', 'customer2@example.com', 'Active', 3),
    CustomerItem('CU003', 'Customer Three', 'customer3@example.com', 'Blocked', 1),
  ];

  final List<OfferItem> offers = [
    OfferItem('WELCOME100', '100 off on first order', 100, 'Active'),
    OfferItem('SAVE200', '200 off above 999', 200, 'Active'),
  ];

  final List<VendorItem> vendors = [
    VendorItem('V001', 'Demo Vendor', 'vendor@example.com', 'Approved'),
  ];

  final List<ResellerItem> resellers = [
    ResellerItem('R001', 'Demo Reseller', 'reseller@example.com', 'Active'),
  ];

  final List<AffiliateItem> affiliates = [
    AffiliateItem('A001', 'Demo Affiliate', 'affiliate@example.com', 1250, 'Active'),
  ];

  final List<CustomOrderItem> customOrders = [
    CustomOrderItem('CO001', 'Customer One', 'Custom Product Request', 'New'),
  ];

  final List<NotificationItem> notifications = [
    NotificationItem('Order alert', 'New order received', true),
    NotificationItem('Low stock', 'Some products are low in stock', true),
  ];

  final List<StaffItem> staff = [
    StaffItem('S001', 'Administrator', 'admin@kstore.com', 'Super Admin', true),
  ];

  final Map<String, bool> settings = {
    'Store open': true,
    'COD enabled': true,
    'Online payment': true,
    'Low stock alerts': true,
    'New order notifications': true,
    'Customer registration': true,
    'Maintenance mode': false,
  };

  double get sales => orders.fold(0, (sum, o) => sum + o.amount);
  int get lowStock => products.where((p) => p.stock > 0 && p.stock <= 10).length;
  int get outOfStock => products.where((p) => p.stock == 0).length;

  void changed() => notifyListeners();
}

class ProductItem {
  ProductItem(
    this.id,
    this.name,
    this.category,
    this.price,
    this.mrp,
    this.stock, {
    this.sku = '',
    this.brand = '',
    this.shortDescription = '',
    this.description = '',
    this.ingredients = '',
    this.howToUse = '',
    this.benefits = '',
    this.unit = 'Piece',
    this.tax = 0,
    this.weight = 0,
    this.lowStockLimit = 10,
    this.barcode = '',
    this.imageUrl = '',
    this.status = 'Active',
    this.featured = false,
    this.newArrival = false,
    this.freeShipping = false,
    this.metaTitle = '',
    this.metaDescription = '',
    this.slug = '',
    this.tags = '',
    this.bulkPricing = const [],
    this.variants = const [],
    this.faq = const [],
  });

  String id, name, category;
  double price, mrp;
  int stock;
  String sku, brand, shortDescription, description, ingredients;
  String howToUse, benefits, unit, barcode, imageUrl, status;
  String metaTitle, metaDescription, slug, tags;
  double tax, weight;
  int lowStockLimit;
  bool featured, newArrival, freeShipping;
  List<BulkPrice> bulkPricing;
  List<ProductVariant> variants;
  List<ProductFaq> faq;
}

class BulkPrice {
  BulkPrice(this.minQty, this.maxQty, this.price);
  int minQty, maxQty;
  double price;
}

class ProductVariant {
  ProductVariant(this.name, this.value, this.priceAdjustment, this.stock);
  String name, value;
  double priceAdjustment;
  int stock;
}

class ProductFaq {
  ProductFaq(this.question, this.answer);
  String question, answer;
}

class CategoryItem {
  CategoryItem(this.id, this.name, this.products, this.active);
  String id, name;
  int products;
  bool active;
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

// -----------------------------------------------------------------------------
// COMMON UI
// -----------------------------------------------------------------------------

class ModuleShell extends StatelessWidget {
  const ModuleShell({
    super.key,
    required this.child,
    this.actions = const [],
  });

  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (actions.isNotEmpty)
            Align(
              alignment: Alignment.centerRight,
              child: Wrap(spacing: 8, children: actions),
            ),
          if (actions.isNotEmpty) const SizedBox(height: 12),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard(this.title, this.value, this.icon, {super.key});

  final String title, value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(child: Icon(icon)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 4),
                  Text(value, style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            child,
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
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}

void showFormDialog(
  BuildContext context, {
  required String title,
  required List<Widget> fields,
  required VoidCallback onSave,
}) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: fields),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            onSave();
            Navigator.pop(dialogContext);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// 0 DASHBOARD
// -----------------------------------------------------------------------------

class DashboardModule extends StatelessWidget {
  const DashboardModule({super.key, required this.data, required this.onOpen});
  final KStoreAdminData data;
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: ListView(
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(width: 220, child: StatCard('Products', '${data.products.length}', Icons.inventory_2)),
              SizedBox(width: 220, child: StatCard('Orders', '${data.orders.length}', Icons.shopping_bag)),
              SizedBox(width: 220, child: StatCard('Customers', '${data.customers.length}', Icons.people)),
              SizedBox(width: 220, child: StatCard('Sales', '₹${data.sales.toStringAsFixed(0)}', Icons.currency_rupee)),
              SizedBox(width: 220, child: StatCard('Low Stock', '${data.lowStock}', Icons.warning_amber)),
            ],
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: 'Store Controls',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(onPressed: () => onOpen(1), icon: const Icon(Icons.inventory), label: const Text('Products')),
                FilledButton.tonalIcon(onPressed: () => onOpen(2), icon: const Icon(Icons.category), label: const Text('Categories')),
                FilledButton.tonalIcon(onPressed: () => onOpen(3), icon: const Icon(Icons.shopping_bag), label: const Text('Orders')),
                FilledButton.tonalIcon(onPressed: () => onOpen(13), icon: const Icon(Icons.warehouse), label: const Text('Inventory')),
                FilledButton.tonalIcon(onPressed: () => onOpen(14), icon: const Icon(Icons.analytics), label: const Text('Reports')),
              ],
            ),
          ),
          SectionCard(
            title: 'Recent Orders',
            child: Column(
              children: data.orders.take(5).map((o) => ListTile(
                leading: const Icon(Icons.receipt_long),
                title: Text(o.id),
                subtitle: Text('${o.customer} • ${o.status}'),
                trailing: Text('₹${o.amount.toStringAsFixed(0)}'),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 1 PRODUCTS
// -----------------------------------------------------------------------------

class ProductModule extends StatefulWidget {
  const ProductModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<ProductModule> createState() => _ProductModuleState();
}

class _ProductModuleState extends State<ProductModule> {
  String query = '';
  String stockFilter = 'All';
  String categoryFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final categories = ['All', ...widget.data.categories.map((c) => c.name)];
    final products = widget.data.products.where((p) {
      final q = query.trim().toLowerCase();
      final matchesSearch = q.isEmpty ||
          p.name.toLowerCase().contains(q) ||
          p.id.toLowerCase().contains(q) ||
          p.sku.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q);
      final matchesCategory =
          categoryFilter == 'All' || p.category == categoryFilter;
      final matchesStock = stockFilter == 'All' ||
          (stockFilter == 'In Stock' && p.stock > p.lowStockLimit) ||
          (stockFilter == 'Low Stock' &&
              p.stock > 0 &&
              p.stock <= p.lowStockLimit) ||
          (stockFilter == 'Out of Stock' && p.stock == 0);
      return matchesSearch && matchesCategory && matchesStock;
    }).toList();

    return ModuleShell(
      actions: [
        OutlinedButton.icon(
          onPressed: () => _showProductGuide(context),
          icon: const Icon(Icons.help_outline),
          label: const Text('Product Fields'),
        ),
        FilledButton.icon(
          onPressed: () => _openProductForm(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Product'),
        ),
      ],
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SizedBox(
                width: 320,
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search name, SKU, barcode or category',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) => setState(() => query = v),
                ),
              ),
              DropdownButton<String>(
                value: categoryFilter,
                items: categories
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => categoryFilter = v ?? 'All'),
              ),
              DropdownButton<String>(
                value: stockFilter,
                items: const ['All', 'In Stock', 'Low Stock', 'Out of Stock']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) => setState(() => stockFilter = v ?? 'All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: products.isEmpty
                ? const EmptyBox(text: 'No products found.')
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (_, i) {
                      final p = products[i];
                      final stockLabel = p.stock == 0
                          ? 'Out of Stock'
                          : p.stock <= p.lowStockLimit
                              ? 'Low Stock'
                              : 'In Stock';
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: p.imageUrl.isEmpty
                                ? const Icon(Icons.inventory_2)
                                : const Icon(Icons.image),
                          ),
                          title: Text(p.name),
                          subtitle: Text(
                            '${p.sku.isEmpty ? p.id : p.sku} • ${p.category} • '
                            'Stock: ${p.stock} • $stockLabel',
                          ),
                          isThreeLine: true,
                          trailing: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                '₹${p.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                tooltip: 'View',
                                onPressed: () => _showProductDetails(context, p),
                                icon: const Icon(Icons.visibility_outlined),
                              ),
                              IconButton(
                                tooltip: 'Edit',
                                onPressed: () => _openProductForm(
                                  context,
                                  product: p,
                                ),
                                icon: const Icon(Icons.edit_outlined),
                              ),
                              IconButton(
                                tooltip: 'Delete',
                                onPressed: () => _deleteProduct(context, p),
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showProductGuide(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Complete Product Setup'),
        content: SingleChildScrollView(
          child: Text(
            'The product form includes Basic Information, Pricing & Tax, '
            'Inventory, Images, Description, Ingredients, How to Use, '
            'Benefits, Variants, Bulk Pricing, FAQ and SEO fields. '
            'All values are stored in the current admin session.',
          ),
        ),
      ),
    );
  }

  void _openProductForm(BuildContext context, {ProductItem? product}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductEditorPage(
          product: product,
          categories: widget.data.categories.map((c) => c.name).toList(),
          onSave: (saved) {
            if (product == null) {
              widget.data.products.add(saved);
            }
            widget.data.changed();
            setState(() {});
          },
        ),
      ),
    );
  }

  void _showProductDetails(BuildContext context, ProductItem p) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailsAdminPage(product: p),
      ),
    );
  }

  void _deleteProduct(BuildContext context, ProductItem p) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Product?'),
        content: Text('Delete "${p.name}" from the product catalogue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              widget.data.products.remove(p);
              widget.data.changed();
              Navigator.pop(dialogContext);
              setState(() {});
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class ProductEditorPage extends StatefulWidget {
  const ProductEditorPage({
    super.key,
    this.product,
    required this.categories,
    required this.onSave,
  });

  final ProductItem? product;
  final List<String> categories;
  final ValueChanged<ProductItem> onSave;

  @override
  State<ProductEditorPage> createState() => _ProductEditorPageState();
}

class _ProductEditorPageState extends State<ProductEditorPage> {
  final formKey = GlobalKey<FormState>();
  int step = 0;

  late final TextEditingController name;
  late final TextEditingController sku;
  late final TextEditingController brand;
  late final TextEditingController barcode;
  late final TextEditingController price;
  late final TextEditingController mrp;
  late final TextEditingController tax;
  late final TextEditingController stock;
  late final TextEditingController lowStock;
  late final TextEditingController weight;
  late final TextEditingController unit;
  late final TextEditingController imageUrl;
  late final TextEditingController shortDescription;
  late final TextEditingController description;
  late final TextEditingController ingredients;
  late final TextEditingController howToUse;
  late final TextEditingController benefits;
  late final TextEditingController tags;
  late final TextEditingController metaTitle;
  late final TextEditingController metaDescription;
  late final TextEditingController slug;

  late String category;
  late String status;
  bool featured = false;
  bool newArrival = false;
  bool freeShipping = false;

  final List<BulkPrice> bulkPricing = [];
  final List<ProductVariant> variants = [];
  final List<ProductFaq> faq = [];

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    name = TextEditingController(text: p?.name ?? '');
    sku = TextEditingController(text: p?.sku ?? p?.id ?? '');
    brand = TextEditingController(text: p?.brand ?? '');
    barcode = TextEditingController(text: p?.barcode ?? '');
    price = TextEditingController(text: p == null ? '' : p.price.toString());
    mrp = TextEditingController(text: p == null ? '' : p.mrp.toString());
    tax = TextEditingController(text: p == null ? '0' : p.tax.toString());
    stock = TextEditingController(text: p == null ? '0' : p.stock.toString());
    lowStock = TextEditingController(
      text: p == null ? '10' : p.lowStockLimit.toString(),
    );
    weight = TextEditingController(
      text: p == null ? '' : p.weight.toString(),
    );
    unit = TextEditingController(text: p?.unit ?? 'Piece');
    imageUrl = TextEditingController(text: p?.imageUrl ?? '');
    shortDescription =
        TextEditingController(text: p?.shortDescription ?? '');
    description = TextEditingController(text: p?.description ?? '');
    ingredients = TextEditingController(text: p?.ingredients ?? '');
    howToUse = TextEditingController(text: p?.howToUse ?? '');
    benefits = TextEditingController(text: p?.benefits ?? '');
    tags = TextEditingController(text: p?.tags ?? '');
    metaTitle = TextEditingController(text: p?.metaTitle ?? '');
    metaDescription = TextEditingController(text: p?.metaDescription ?? '');
    slug = TextEditingController(text: p?.slug ?? '');
    category = p?.category ??
        (widget.categories.isEmpty ? 'General' : widget.categories.first);
    status = p?.status ?? 'Active';
    featured = p?.featured ?? false;
    newArrival = p?.newArrival ?? false;
    freeShipping = p?.freeShipping ?? false;
    bulkPricing.addAll(p?.bulkPricing ?? const []);
    variants.addAll(p?.variants ?? const []);
    faq.addAll(p?.faq ?? const []);
  }

  @override
  void dispose() {
    for (final c in [
      name,
      sku,
      brand,
      barcode,
      price,
      mrp,
      tax,
      stock,
      lowStock,
      weight,
      unit,
      imageUrl,
      shortDescription,
      description,
      ingredients,
      howToUse,
      benefits,
      tags,
      metaTitle,
      metaDescription,
      slug,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.product != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Edit Product' : 'Add Product'),
        actions: [
          TextButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save Product'),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Stepper(
          currentStep: step,
          onStepContinue: () {
            if (step < 5) {
              setState(() => step++);
            } else {
              _save();
            }
          },
          onStepCancel: () {
            if (step > 0) {
              setState(() => step--);
            } else {
              Navigator.pop(context);
            }
          },
          controlsBuilder: (context, details) {
            return Row(
              children: [
                FilledButton(
                  onPressed: details.onStepContinue,
                  child: Text(step == 5 ? 'Save Product' : 'Next'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: details.onStepCancel,
                  child: Text(step == 0 ? 'Cancel' : 'Back'),
                ),
              ],
            );
          },
          steps: [
            Step(
              title: const Text('Basic Information'),
              isActive: step >= 0,
              content: _basicFields(),
            ),
            Step(
              title: const Text('Pricing & Tax'),
              isActive: step >= 1,
              content: _pricingFields(),
            ),
            Step(
              title: const Text('Inventory & Shipping'),
              isActive: step >= 2,
              content: _inventoryFields(),
            ),
            Step(
              title: const Text('Description & Benefits'),
              isActive: step >= 3,
              content: _contentFields(),
            ),
            Step(
              title: const Text('Variants & Bulk Pricing'),
              isActive: step >= 4,
              content: _variantFields(),
            ),
            Step(
              title: const Text('SEO, FAQ & Publish'),
              isActive: step >= 5,
              content: _seoFields(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _basicFields() {
    return Column(
      children: [
        _field(name, 'Product Name', requiredField: true),
        _field(sku, 'SKU / Product Code'),
        _field(brand, 'Brand / Manufacturer'),
        _field(barcode, 'Barcode / EAN / UPC'),
        DropdownButtonFormField<String>(
          value: category,
          decoration: const InputDecoration(labelText: 'Category'),
          items: {
            ...widget.categories,
            'General',
          }.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
          onChanged: (v) => setState(() => category = v ?? category),
        ),
        _field(
          shortDescription,
          'Short Description',
          maxLines: 2,
        ),
        const SizedBox(height: 8),
        Text(
          'Product image URL',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        _field(imageUrl, 'Image URL'),
      ],
    );
  }

  Widget _pricingFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _field(price, 'Selling Price', number: true, requiredField: true)),
            const SizedBox(width: 8),
            Expanded(child: _field(mrp, 'MRP', number: true, requiredField: true)),
          ],
        ),
        Row(
          children: [
            Expanded(child: _field(tax, 'GST / Tax %', number: true)),
            const SizedBox(width: 8),
            Expanded(child: _field(unit, 'Unit')),
          ],
        ),
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Pricing note: selling price should normally be equal to or below MRP.',
          ),
        ),
      ],
    );
  }

  Widget _inventoryFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _field(stock, 'Opening / Current Stock', number: true)),
            const SizedBox(width: 8),
            Expanded(child: _field(lowStock, 'Low Stock Alert At', number: true)),
          ],
        ),
        _field(weight, 'Weight (grams)', number: true),
        SwitchListTile(
          value: freeShipping,
          onChanged: (v) => setState(() => freeShipping = v),
          title: const Text('Free Shipping'),
        ),
        const ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.local_shipping_outlined),
          title: Text('Shipping'),
          subtitle: Text(
            'Delivery charge can be controlled from Delivery & Shipping.',
          ),
        ),
      ],
    );
  }

  Widget _contentFields() {
    return Column(
      children: [
        _field(description, 'Full Product Description', maxLines: 5),
        _field(ingredients, 'Ingredients / Composition', maxLines: 4),
        _field(howToUse, 'How to Use', maxLines: 4),
        _field(benefits, 'Benefits / Key Features', maxLines: 4),
        _field(tags, 'Search Tags / Keywords', maxLines: 2),
      ],
    );
  }

  Widget _variantFields() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.icon(
            onPressed: _addVariant,
            icon: const Icon(Icons.add),
            label: const Text('Add Variant'),
          ),
        ),
        ...variants.asMap().entries.map(
          (entry) => Card(
            child: ListTile(
              title: Text('${entry.value.name}: ${entry.value.value}'),
              subtitle: Text(
                'Price adjustment: ₹${entry.value.priceAdjustment.toStringAsFixed(0)}'
                ' • Stock: ${entry.value.stock}',
              ),
              trailing: IconButton(
                onPressed: () => setState(() => variants.removeAt(entry.key)),
                icon: const Icon(Icons.delete_outline),
              ),
            ),
          ),
        ),
        const Divider(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.icon(
            onPressed: _addBulkPrice,
            icon: const Icon(Icons.price_change_outlined),
            label: const Text('Add Bulk Pricing Slab'),
          ),
        ),
        ...bulkPricing.asMap().entries.map(
          (entry) => Card(
            child: ListTile(
              title: Text(
                '${entry.value.minQty} - ${entry.value.maxQty} units',
              ),
              subtitle: Text(
                '₹${entry.value.price.toStringAsFixed(2)} per unit',
              ),
              trailing: IconButton(
                onPressed: () => setState(
                  () => bulkPricing.removeAt(entry.key),
                ),
                icon: const Icon(Icons.delete_outline),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _seoFields() {
    return Column(
      children: [
        _field(slug, 'URL Slug'),
        _field(metaTitle, 'SEO Meta Title'),
        _field(metaDescription, 'SEO Meta Description', maxLines: 3),
        DropdownButtonFormField<String>(
          value: status,
          decoration: const InputDecoration(labelText: 'Product Status'),
          items: const ['Active', 'Draft', 'Out of Stock', 'Disabled']
              .map((v) => DropdownMenuItem(value: v, child: Text(v)))
              .toList(),
          onChanged: (v) => setState(() => status = v ?? status),
        ),
        SwitchListTile(
          value: featured,
          onChanged: (v) => setState(() => featured = v),
          title: const Text('Featured Product'),
        ),
        SwitchListTile(
          value: newArrival,
          onChanged: (v) => setState(() => newArrival = v),
          title: const Text('New Arrival'),
        ),
        const Divider(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.icon(
            onPressed: _addFaq,
            icon: const Icon(Icons.help_outline),
            label: const Text('Add FAQ'),
          ),
        ),
        ...faq.asMap().entries.map(
          (entry) => Card(
            child: ListTile(
              title: Text(entry.value.question),
              subtitle: Text(entry.value.answer),
              trailing: IconButton(
                onPressed: () => setState(() => faq.removeAt(entry.key)),
                icon: const Icon(Icons.delete_outline),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool number = false,
    bool requiredField = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: number
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: requiredField
            ? (v) => v == null || v.trim().isEmpty ? 'Required' : null
            : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void _addVariant() {
    final name = TextEditingController();
    final value = TextEditingController();
    final adjustment = TextEditingController(text: '0');
    final stockController = TextEditingController(text: '0');

    showFormDialog(
      context,
      title: 'Add Product Variant',
      fields: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Variant Name (e.g. Size)')),
        TextField(controller: value, decoration: const InputDecoration(labelText: 'Variant Value (e.g. 100g)')),
        TextField(controller: adjustment, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price Adjustment')),
        TextField(controller: stockController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stock')),
      ],
      onSave: () {
        setState(() {
          variants.add(
            ProductVariant(
              name.text.isEmpty ? 'Variant' : name.text,
              value.text,
              double.tryParse(adjustment.text) ?? 0,
              int.tryParse(stockController.text) ?? 0,
            ),
          );
        });
      },
    );
  }

  void _addBulkPrice() {
    final min = TextEditingController();
    final max = TextEditingController();
    final slabPrice = TextEditingController();

    showFormDialog(
      context,
      title: 'Bulk Pricing Slab',
      fields: [
        TextField(controller: min, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Minimum Quantity')),
        TextField(controller: max, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Maximum Quantity')),
        TextField(controller: slabPrice, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price Per Unit')),
      ],
      onSave: () {
        setState(() {
          bulkPricing.add(
            BulkPrice(
              int.tryParse(min.text) ?? 1,
              int.tryParse(max.text) ?? 1,
              double.tryParse(slabPrice.text) ?? 0,
            ),
          );
        });
      },
    );
  }

  void _addFaq() {
    final question = TextEditingController();
    final answer = TextEditingController();

    showFormDialog(
      context,
      title: 'Add Product FAQ',
      fields: [
        TextField(controller: question, decoration: const InputDecoration(labelText: 'Question')),
        TextField(controller: answer, maxLines: 3, decoration: const InputDecoration(labelText: 'Answer')),
      ],
      onSave: () {
        setState(() => faq.add(ProductFaq(question.text, answer.text)));
      },
    );
  }

  void _save() {
    if (!(formKey.currentState?.validate() ?? false)) {
      setState(() => step = 0);
      return;
    }

    final product = ProductItem(
      widget.product?.id ?? 'P${DateTime.now().millisecondsSinceEpoch}',
      name.text.trim(),
      category,
      double.tryParse(price.text) ?? 0,
      double.tryParse(mrp.text) ?? 0,
      int.tryParse(stock.text) ?? 0,
      sku: sku.text.trim(),
      brand: brand.text.trim(),
      shortDescription: shortDescription.text.trim(),
      description: description.text.trim(),
      ingredients: ingredients.text.trim(),
      howToUse: howToUse.text.trim(),
      benefits: benefits.text.trim(),
      unit: unit.text.trim().isEmpty ? 'Piece' : unit.text.trim(),
      tax: double.tryParse(tax.text) ?? 0,
      weight: double.tryParse(weight.text) ?? 0,
      lowStockLimit: int.tryParse(lowStock.text) ?? 10,
      barcode: barcode.text.trim(),
      imageUrl: imageUrl.text.trim(),
      status: status,
      featured: featured,
      newArrival: newArrival,
      freeShipping: freeShipping,
      metaTitle: metaTitle.text.trim(),
      metaDescription: metaDescription.text.trim(),
      slug: slug.text.trim(),
      tags: tags.text.trim(),
      bulkPricing: List<BulkPrice>.from(bulkPricing),
      variants: List<ProductVariant>.from(variants),
      faq: List<ProductFaq>.from(faq),
    );

    if (widget.product != null) {
      final old = widget.product!;
      old.name = product.name;
      old.category = product.category;
      old.price = product.price;
      old.mrp = product.mrp;
      old.stock = product.stock;
      old.sku = product.sku;
      old.brand = product.brand;
      old.shortDescription = product.shortDescription;
      old.description = product.description;
      old.ingredients = product.ingredients;
      old.howToUse = product.howToUse;
      old.benefits = product.benefits;
      old.unit = product.unit;
      old.tax = product.tax;
      old.weight = product.weight;
      old.lowStockLimit = product.lowStockLimit;
      old.barcode = product.barcode;
      old.imageUrl = product.imageUrl;
      old.status = product.status;
      old.featured = product.featured;
      old.newArrival = product.newArrival;
      old.freeShipping = product.freeShipping;
      old.metaTitle = product.metaTitle;
      old.metaDescription = product.metaDescription;
      old.slug = product.slug;
      old.tags = product.tags;
      old.bulkPricing = product.bulkPricing;
      old.variants = product.variants;
      old.faq = product.faq;
      widget.onSave(old);
    } else {
      widget.onSave(product);
    }

    Navigator.pop(context);
  }
}

class ProductDetailsAdminPage extends StatelessWidget {
  const ProductDetailsAdminPage({super.key, required this.product});
  final ProductItem product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  Text('${product.category} • ${product.sku}'),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(label: Text('₹${product.price.toStringAsFixed(0)}')),
                      Chip(label: Text('MRP ₹${product.mrp.toStringAsFixed(0)}')),
                      Chip(label: Text('Stock ${product.stock}')),
                      Chip(label: Text(product.status)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SectionCard(
            title: 'Basic Information',
            child: Column(
              children: [
                ListTile(title: const Text('Brand'), trailing: Text(product.brand.isEmpty ? '-' : product.brand)),
                ListTile(title: const Text('Barcode'), trailing: Text(product.barcode.isEmpty ? '-' : product.barcode)),
                ListTile(title: const Text('Unit'), trailing: Text(product.unit)),
                ListTile(title: const Text('Weight'), trailing: Text('${product.weight} g')),
              ],
            ),
          ),
          SectionCard(
            title: 'Description',
            child: Text(product.description.isEmpty ? 'Not added' : product.description),
          ),
          SectionCard(
            title: 'Ingredients / Composition',
            child: Text(product.ingredients.isEmpty ? 'Not added' : product.ingredients),
          ),
          SectionCard(
            title: 'How to Use',
            child: Text(product.howToUse.isEmpty ? 'Not added' : product.howToUse),
          ),
          SectionCard(
            title: 'Benefits / Features',
            child: Text(product.benefits.isEmpty ? 'Not added' : product.benefits),
          ),
          if (product.bulkPricing.isNotEmpty)
            SectionCard(
              title: 'Bulk Pricing',
              child: Column(
                children: product.bulkPricing.map((b) => ListTile(
                  title: Text('${b.minQty} - ${b.maxQty} units'),
                  trailing: Text('₹${b.price.toStringAsFixed(2)}'),
                )).toList(),
              ),
            ),
          if (product.variants.isNotEmpty)
            SectionCard(
              title: 'Variants',
              child: Column(
                children: product.variants.map((v) => ListTile(
                  title: Text('${v.name}: ${v.value}'),
                  subtitle: Text('Stock: ${v.stock}'),
                  trailing: Text(
                    v.priceAdjustment == 0
                        ? 'Base'
                        : '${v.priceAdjustment > 0 ? '+' : ''}₹${v.priceAdjustment.toStringAsFixed(0)}',
                  ),
                )).toList(),
              ),
            ),
          if (product.faq.isNotEmpty)
            SectionCard(
              title: 'FAQ',
              child: Column(
                children: product.faq.map((f) => ExpansionTile(
                  title: Text(f.question),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(f.answer),
                      ),
                    ),
                  ],
                )).toList(),
              ),
            ),
          SectionCard(
            title: 'SEO',
            child: Column(
              children: [
                ListTile(title: const Text('Slug'), subtitle: Text(product.slug.isEmpty ? '-' : product.slug)),
                ListTile(title: const Text('Meta Title'), subtitle: Text(product.metaTitle.isEmpty ? '-' : product.metaTitle)),
                ListTile(title: const Text('Meta Description'), subtitle: Text(product.metaDescription.isEmpty ? '-' : product.metaDescription)),
                ListTile(title: const Text('Tags'), subtitle: Text(product.tags.isEmpty ? '-' : product.tags)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2 CATEGORIES
// -----------------------------------------------------------------------------

class CategoryModule extends StatefulWidget {
  const CategoryModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<CategoryModule> createState() => _CategoryModuleState();
}

class _CategoryModuleState extends State<CategoryModule> {
  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [
        FilledButton.icon(onPressed: _add, icon: const Icon(Icons.add), label: const Text('Add Category')),
      ],
      child: ListView(
        children: widget.data.categories.map((c) => Card(
          child: ListTile(
            leading: const Icon(Icons.category),
            title: Text(c.name),
            subtitle: Text('${c.products} products • ${c.id}'),
            trailing: Switch(
              value: c.active,
              onChanged: (v) => setState(() => c.active = v),
            ),
          ),
        )).toList(),
      ),
    );
  }

  void _add() {
    final name = TextEditingController();
    showFormDialog(
      context,
      title: 'Add Category',
      fields: [TextField(controller: name, decoration: const InputDecoration(labelText: 'Category Name'))],
      onSave: () {
        widget.data.categories.add(CategoryItem(
          'C${DateTime.now().millisecondsSinceEpoch}',
          name.text.isEmpty ? 'New Category' : name.text,
          0,
          true,
        ));
        setState(() {});
      },
    );
  }
}

// -----------------------------------------------------------------------------
// 3 ORDERS
// -----------------------------------------------------------------------------

// Orders Module upgrade for K Store Admin.
// Replace the existing OrderModule class block only.
// It uses the existing KStoreAdminData and OrderItem models.

class OrderModule extends StatefulWidget {
  const OrderModule({super.key, required this.data});

  final KStoreAdminData data;

  @override
  State<OrderModule> createState() => _OrderModuleState();
}

class _OrderModuleState extends State<OrderModule> {
  final TextEditingController _searchController = TextEditingController();

  String _statusFilter = 'All';
  String _paymentFilter = 'All';
  String _sortBy = 'Newest';

  final List<String> _statuses = const [
    'Pending',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<OrderItem> get _filteredOrders {
    final query = _searchController.text.trim().toLowerCase();

    final result = widget.data.orders.where((order) {
      final matchesSearch = query.isEmpty ||
          order.id.toLowerCase().contains(query) ||
          order.customer.toLowerCase().contains(query);

      final matchesStatus =
          _statusFilter == 'All' || order.status == _statusFilter;

      final matchesPayment =
          _paymentFilter == 'All' || order.payment == _paymentFilter;

      return matchesSearch && matchesStatus && matchesPayment;
    }).toList();

    if (_sortBy == 'Amount: High') {
      result.sort((a, b) => b.amount.compareTo(a.amount));
    } else if (_sortBy == 'Amount: Low') {
      result.sort((a, b) => a.amount.compareTo(b.amount));
    }

    return result;
  }

  double _totalAmount(List<OrderItem> orders) {
    return orders.fold(0, (sum, order) => sum + order.amount);
  }

  int _countByStatus(String status) {
    return widget.data.orders.where((o) => o.status == status).length;
  }

  @override
  Widget build(BuildContext context) {
    final orders = _filteredOrders;
    final total = _totalAmount(orders);

    return ModuleShell(
      actions: [
        OutlinedButton.icon(
          onPressed: _showFilterDialog,
          icon: const Icon(Icons.filter_alt_outlined),
          label: const Text('Filters'),
        ),
        FilledButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order export is ready for integration.')),
            );
          },
          icon: const Icon(Icons.download_outlined),
          label: const Text('Export'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStats(),
          const SizedBox(height: 14),
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.clear),
                    ),
              hintText: 'Search Order ID or customer',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...['All', ..._statuses].map(
                (status) => ChoiceChip(
                  label: Text(status),
                  selected: _statusFilter == status,
                  onSelected: (_) => setState(() => _statusFilter = status),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '${orders.length} orders • ₹${total.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              DropdownButton<String>(
                value: _sortBy,
                items: const [
                  DropdownMenuItem(value: 'Newest', child: Text('Newest')),
                  DropdownMenuItem(
                    value: 'Amount: High',
                    child: Text('Amount: High'),
                  ),
                  DropdownMenuItem(
                    value: 'Amount: Low',
                    child: Text('Amount: Low'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _sortBy = value);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: orders.isEmpty
                ? const EmptyBox(
                    title: 'No orders found',
                    message: 'Try changing the search or filters.',
                  )
                : ListView.separated(
                    itemCount: orders.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return _orderCard(orders[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    final cards = [
      ('All', widget.data.orders.length, Icons.receipt_long_outlined),
      ('Pending', _countByStatus('Pending'), Icons.schedule_outlined),
      ('Processing', _countByStatus('Processing'), Icons.sync_outlined),
      ('Shipped', _countByStatus('Shipped'), Icons.local_shipping_outlined),
      ('Delivered', _countByStatus('Delivered'), Icons.check_circle_outline),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cards
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SizedBox(
                  width: 150,
                  child: StatCard(
                    title: item.$1,
                    value: '${item.$2}',
                    icon: item.$3,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _orderCard(OrderItem order) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showOrderDetails(order),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.receipt_long_outlined),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      order.id,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _statusChip(order.status),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                order.customer,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(child: Text('Payment: ${order.payment}')),
                  Text(
                    '₹${order.amount.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _showOrderDetails(order),
                    icon: const Icon(Icons.visibility_outlined, size: 18),
                    label: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: order.status,
                      isDense: true,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                      items: _statuses
                          .map(
                            (status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => order.status = value);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${order.id} updated to $value',
                            ),
                          ),
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
    );
  }

  Widget _statusChip(String status) {
    return Chip(
      label: Text(status),
      visualDensity: VisualDensity.compact,
    );
  }

  void _showOrderDetails(OrderItem order) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Order ${order.id}'),
          content: SizedBox(
            width: 520,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detailRow('Customer', order.customer),
                  _detailRow('Order ID', order.id),
                  _detailRow('Amount', '₹${order.amount.toStringAsFixed(2)}'),
                  _detailRow('Payment', order.payment),
                  _detailRow('Status', order.status),
                  const Divider(height: 28),
                  const Text(
                    'Order Timeline',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _timelineItem('Order placed', true),
                  _timelineItem('Processing', order.status != 'Pending'),
                  _timelineItem(
                    'Shipped',
                    order.status == 'Shipped' || order.status == 'Delivered',
                  ),
                  _timelineItem('Delivered', order.status == 'Delivered'),
                  if (order.status == 'Cancelled')
                    _timelineItem('Cancelled', true),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _timelineItem(String title, bool active) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            active ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    String payment = _paymentFilter;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Order Filters'),
              content: DropdownButtonFormField<String>(
                value: payment,
                decoration: const InputDecoration(
                  labelText: 'Payment Status',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'All', child: Text('All')),
                  DropdownMenuItem(value: 'Paid', child: Text('Paid')),
                  DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                  DropdownMenuItem(value: 'COD', child: Text('COD')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setDialogState(() => payment = value);
                  }
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    setState(() {
                      _paymentFilter = 'All';
                      _statusFilter = 'All';
                    });
                  },
                  child: const Text('Clear'),
                ),
                FilledButton(
                  onPressed: () {
                    setState(() => _paymentFilter = payment);
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
// 4 CUSTOMERS
// -----------------------------------------------------------------------------

// Customers Module upgrade for K Store Admin.
// Demo-data driven UI. Keeps the existing CustomerItem model unchanged.

class CustomerModule extends StatefulWidget {
  const CustomerModule({super.key, required this.data});

  final KStoreAdminData data;

  @override
  State<CustomerModule> createState() => _CustomerModuleState();
}

class _CustomerModuleState extends State<CustomerModule> {
  final TextEditingController _searchController = TextEditingController();

  String _statusFilter = 'All';
  String _sortBy = 'Newest';

  final List<String> _statuses = const [
    'Active',
    'New',
    'VIP',
    'Blocked',
  ];

  final List<Map<String, dynamic>> _demoProfiles = [
    {
      'phone': '+91 98765 43210',
      'whatsapp': '+91 98765 43210',
      'gender': 'Male',
      'joined': '12 Sep 2026',
      'lastOrder': '02 Oct 2026',
      'spent': 12850.0,
      'wallet': 650.0,
      'rewards': 1285,
      'address': '12 Civil Lines',
      'city': 'Agra',
      'state': 'Uttar Pradesh',
      'pin': '282002',
      'completed': 5,
      'cancelled': 0,
      'notes': 'Regular customer',
    },
    {
      'phone': '+91 91234 56780',
      'whatsapp': '+91 91234 56780',
      'gender': 'Female',
      'joined': '18 Sep 2026',
      'lastOrder': '30 Sep 2026',
      'spent': 8450.0,
      'wallet': 320.0,
      'rewards': 845,
      'address': 'Taj Nagari Phase 2',
      'city': 'Agra',
      'state': 'Uttar Pradesh',
      'pin': '282001',
      'completed': 3,
      'cancelled': 0,
      'notes': 'Prefers WhatsApp updates',
    },
    {
      'phone': '+91 99887 66554',
      'whatsapp': '+91 99887 66554',
      'gender': 'Male',
      'joined': '22 Sep 2026',
      'lastOrder': '28 Sep 2026',
      'spent': 4620.0,
      'wallet': 100.0,
      'rewards': 462,
      'address': 'Kamla Nagar',
      'city': 'Agra',
      'state': 'Uttar Pradesh',
      'pin': '282005',
      'completed': 1,
      'cancelled': 0,
      'notes': 'New customer',
    },
    {
      'phone': '+91 90000 11223',
      'whatsapp': '+91 90000 11223',
      'gender': 'Female',
      'joined': '02 Aug 2026',
      'lastOrder': '25 Sep 2026',
      'spent': 22600.0,
      'wallet': 1200.0,
      'rewards': 2260,
      'address': 'Sector 15',
      'city': 'Noida',
      'state': 'Uttar Pradesh',
      'pin': '201301',
      'completed': 9,
      'cancelled': 1,
      'notes': 'High-value customer',
    },
    {
      'phone': '+91 91111 22334',
      'whatsapp': '+91 91111 22334',
      'gender': 'Male',
      'joined': '05 Jul 2026',
      'lastOrder': '20 Sep 2026',
      'spent': 31400.0,
      'wallet': 2100.0,
      'rewards': 3140,
      'address': 'Lajpat Nagar',
      'city': 'New Delhi',
      'state': 'Delhi',
      'pin': '110024',
      'completed': 12,
      'cancelled': 0,
      'notes': 'VIP customer',
    },
    {
      'phone': '+91 93333 44556',
      'whatsapp': '+91 93333 44556',
      'gender': 'Female',
      'joined': '29 Sep 2026',
      'lastOrder': '01 Oct 2026',
      'spent': 950.0,
      'wallet': 50.0,
      'rewards': 95,
      'address': 'Shahganj',
      'city': 'Agra',
      'state': 'Uttar Pradesh',
      'pin': '282010',
      'completed': 1,
      'cancelled': 0,
      'notes': 'First purchase completed',
    },
    {
      'phone': '+91 94444 55667',
      'whatsapp': '+91 94444 55667',
      'gender': 'Male',
      'joined': '14 Aug 2026',
      'lastOrder': '18 Sep 2026',
      'spent': 7200.0,
      'wallet': 250.0,
      'rewards': 720,
      'address': 'Vaishali Nagar',
      'city': 'Jaipur',
      'state': 'Rajasthan',
      'pin': '302021',
      'completed': 3,
      'cancelled': 1,
      'notes': 'Order cancellation recorded',
    },
    {
      'phone': '+91 95555 66778',
      'whatsapp': '+91 95555 66778',
      'gender': 'Female',
      'joined': '09 Jun 2026',
      'lastOrder': '10 Sep 2026',
      'spent': 15400.0,
      'wallet': 800.0,
      'rewards': 1540,
      'address': 'Aliganj',
      'city': 'Lucknow',
      'state': 'Uttar Pradesh',
      'pin': '226024',
      'completed': 7,
      'cancelled': 0,
      'notes': 'Repeat customer',
    },
    {
      'phone': '+91 96666 77889',
      'whatsapp': '+91 96666 77889',
      'gender': 'Male',
      'joined': '27 Sep 2026',
      'lastOrder': '27 Sep 2026',
      'spent': 1800.0,
      'wallet': 80.0,
      'rewards': 180,
      'address': 'Transport Nagar',
      'city': 'Kanpur',
      'state': 'Uttar Pradesh',
      'pin': '208021',
      'completed': 1,
      'cancelled': 0,
      'notes': 'New customer',
    },
    {
      'phone': '+91 97777 88990',
      'whatsapp': '+91 97777 88990',
      'gender': 'Male',
      'joined': '11 May 2026',
      'lastOrder': '05 Aug 2026',
      'spent': 5600.0,
      'wallet': 0.0,
      'rewards': 560,
      'address': 'Old City',
      'city': 'Agra',
      'state': 'Uttar Pradesh',
      'pin': '282003',
      'completed': 2,
      'cancelled': 0,
      'notes': 'Account requires review',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _profileFor(int index) {
    return _demoProfiles[index % _demoProfiles.length];
  }

  String _statusFor(int index, CustomerItem customer) {
    if (customer.status == 'Blocked') return 'Blocked';
    if (index == 4 || customer.orders >= 10) return 'VIP';
    if (customer.orders <= 1) return 'New';
    return 'Active';
  }

  List<MapEntry<CustomerItem, int>> get _filteredCustomers {
    final query = _searchController.text.trim().toLowerCase();

    final result = widget.data.customers.asMap().entries.where((entry) {
      final customer = entry.value;
      final status = _statusFor(entry.key, customer);

      final matchesSearch = query.isEmpty ||
          customer.id.toLowerCase().contains(query) ||
          customer.name.toLowerCase().contains(query) ||
          customer.email.toLowerCase().contains(query);

      final matchesStatus =
          _statusFilter == 'All' || status == _statusFilter;

      return matchesSearch && matchesStatus;
    }).toList();

    if (_sortBy == 'Orders: High') {
      result.sort((a, b) => b.value.orders.compareTo(a.value.orders));
    } else if (_sortBy == 'Name') {
      result.sort((a, b) => a.value.name.compareTo(b.value.name));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final customers = _filteredCustomers;

    return ModuleShell(
      actions: [
        OutlinedButton.icon(
          onPressed: _showFilterDialog,
          icon: const Icon(Icons.filter_alt_outlined),
          label: const Text('Filters'),
        ),
        FilledButton.icon(
          onPressed: _addCustomer,
          icon: const Icon(Icons.person_add_alt_1),
          label: const Text('Add Customer'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStats(),
          const SizedBox(height: 14),
          TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.clear),
                    ),
              hintText: 'Search name, email or Customer ID',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '${customers.length} customers',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              DropdownButton<String>(
                value: _sortBy,
                items: const [
                  DropdownMenuItem(value: 'Newest', child: Text('Newest')),
                  DropdownMenuItem(
                    value: 'Orders: High',
                    child: Text('Orders: High'),
                  ),
                  DropdownMenuItem(value: 'Name', child: Text('Name')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _sortBy = value);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: customers.isEmpty
                ? const EmptyBox(
                    title: 'No customers found',
                    message: 'Try another search or filter.',
                  )
                : ListView.separated(
                    itemCount: customers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final entry = customers[index];
                      return _customerCard(entry.value, entry.key);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    final all = widget.data.customers;
    final active = all
        .asMap()
        .entries
        .where((e) => _statusFor(e.key, e.value) == 'Active')
        .length;
    final vip = all
        .asMap()
        .entries
        .where((e) => _statusFor(e.key, e.value) == 'VIP')
        .length;
    final blocked = all.where((c) => c.status == 'Blocked').length;
    final orders = all.fold<int>(0, (sum, c) => sum + c.orders);

    final cards = [
      ('Customers', all.length, Icons.people_alt_outlined),
      ('Active', active, Icons.verified_user_outlined),
      ('VIP', vip, Icons.star_outline),
      ('Blocked', blocked, Icons.block_outlined),
      ('Orders', orders, Icons.shopping_bag_outlined),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cards
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SizedBox(
                  width: 145,
                  child: StatCard(
                    title: item.$1,
                    value: '${item.$2}',
                    icon: item.$3,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _customerCard(CustomerItem customer, int index) {
    final profile = _profileFor(index);
    final status = _statusFor(index, customer);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetails(customer, index),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Text(
                      customer.name.isEmpty
                          ? '?'
                          : customer.name.substring(0, 1).toUpperCase(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${customer.id} • ${customer.email}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  _statusChip(status),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _miniInfo(Icons.phone_outlined, profile['phone']),
                  _miniInfo(
                    Icons.shopping_bag_outlined,
                    '${customer.orders} orders',
                  ),
                  _miniInfo(
                    Icons.currency_rupee,
                    '₹${(profile['spent'] as double).toStringAsFixed(0)}',
                  ),
                  _miniInfo(
                    Icons.stars_outlined,
                    '${profile['rewards']} points',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _showDetails(customer, index),
                    icon: const Icon(Icons.visibility_outlined, size: 18),
                    label: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: () => _editCustomer(customer),
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: const Text('Edit'),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: status == 'Blocked' ? 'Activate' : 'Block',
                    onPressed: () => _toggleStatus(customer),
                    icon: Icon(
                      status == 'Blocked'
                          ? Icons.lock_open_outlined
                          : Icons.block_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniInfo(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 17),
        const SizedBox(width: 4),
        Text(value),
      ],
    );
  }

  Widget _statusChip(String status) {
    return Chip(
      label: Text(status),
      visualDensity: VisualDensity.compact,
    );
  }

  void _showDetails(CustomerItem customer, int index) {
    final profile = _profileFor(index);
    final status = _statusFor(index, customer);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              CircleAvatar(
                child: Text(customer.name.substring(0, 1).toUpperCase()),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(customer.name)),
              _statusChip(status),
            ],
          ),
          content: SizedBox(
            width: 560,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _section('Customer Information', [
                    _detail('Customer ID', customer.id),
                    _detail('Email', customer.email),
                    _detail('Phone', profile['phone']),
                    _detail('WhatsApp', profile['whatsapp']),
                    _detail('Gender', profile['gender']),
                    _detail('Joined', profile['joined']),
                  ]),
                  _section('Business Summary', [
                    _detail('Total Orders', '${customer.orders}'),
                    _detail('Completed Orders', '${profile['completed']}'),
                    _detail('Cancelled Orders', '${profile['cancelled']}'),
                    _detail(
                      'Total Spent',
                      '₹${(profile['spent'] as double).toStringAsFixed(2)}',
                    ),
                    _detail(
                      'Wallet Balance',
                      '₹${(profile['wallet'] as double).toStringAsFixed(2)}',
                    ),
                    _detail('Reward Points', '${profile['rewards']}'),
                    _detail('Last Order', profile['lastOrder']),
                  ]),
                  _section('Address', [
                    _detail(
                      'Address',
                      '${profile['address']}, ${profile['city']}, '
                          '${profile['state']} - ${profile['pin']}',
                    ),
                  ]),
                  _section('Notes', [
                    _detail('Admin Note', profile['notes']),
                  ]),
                  _section('Order History', [
                    _orderHistory(customer.orders),
                  ]),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext);
                _editCustomer(customer);
              },
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  Widget _section(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _detail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _orderHistory(int count) {
    if (count == 0) {
      return const Text('No order history.');
    }

    return Column(
      children: List.generate(
        count > 5 ? 5 : count,
        (index) => ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.receipt_long_outlined),
          title: Text('ORD-DEMO-${1001 + index}'),
          subtitle: Text(index == 0 ? 'Recent order' : 'Completed order'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }

  void _toggleStatus(CustomerItem customer) {
    setState(() {
      customer.status = customer.status == 'Blocked' ? 'Active' : 'Blocked';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          customer.status == 'Blocked'
              ? '${customer.name} blocked'
              : '${customer.name} activated',
        ),
      ),
    );
  }

  void _editCustomer(CustomerItem customer) {
    final name = TextEditingController(text: customer.name);
    final email = TextEditingController(text: customer.email);

    showFormDialog(
      context,
      title: 'Edit Customer',
      fields: [
        TextField(
          controller: name,
          decoration: const InputDecoration(labelText: 'Customer Name'),
        ),
        TextField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
      ],
      onSave: () {
        if (name.text.trim().isEmpty || email.text.trim().isEmpty) return;

        setState(() {
          customer.name = name.text.trim();
          customer.email = email.text.trim();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Customer updated')),
        );
      },
    );
  }

  void _addCustomer() {
    final name = TextEditingController();
    final email = TextEditingController();

    showFormDialog(
      context,
      title: 'Add Customer',
      fields: [
        TextField(
          controller: name,
          decoration: const InputDecoration(labelText: 'Customer Name'),
        ),
        TextField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
      ],
      onSave: () {
        final customerName = name.text.trim();
        final customerEmail = email.text.trim();

        if (customerName.isEmpty || customerEmail.isEmpty) return;

        final id = 'CU${(widget.data.customers.length + 1).toString().padLeft(3, '0')}';

        setState(() {
          widget.data.customers.add(
            CustomerItem(
              id,
              customerName,
              customerEmail,
              'Active',
              0,
            ),
          );
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$id customer added')),
        );
      },
    );
  }

  void _showFilterDialog() {
    String status = _statusFilter;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Customer Filters'),
              content: DropdownButtonFormField<String>(
                value: status,
                decoration: const InputDecoration(
                  labelText: 'Customer Status',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem(
                    value: 'All',
                    child: Text('All'),
                  ),
                  ..._statuses.map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setDialogState(() => status = value);
                  }
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    setState(() => _statusFilter = 'All');
                  },
                  child: const Text('Clear'),
                ),
                FilledButton(
                  onPressed: () {
                    setState(() => _statusFilter = status);
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
// K - Store Admin — Remaining Modules Upgrade
// Replace the existing OfferModule through SecurityModule block with this file.
// This file intentionally uses local demo/in-memory data so the complete UI can
// be tested before backend/API integration.

class OfferModule extends StatefulWidget {
  const OfferModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  State<OfferModule> createState() => _OfferModuleState();
}

class _OfferModuleState extends State<OfferModule> {
  final List<Map<String, dynamic>> coupons = [
    {'code':'WELCOME100','type':'Percentage','value':10.0,'min':499.0,'max':200.0,'uses':84,'limit':500,'status':'Active','expiry':'31 Dec 2026'},
    {'code':'SAVE200','type':'Fixed','value':200.0,'min':999.0,'max':200.0,'uses':46,'limit':200,'status':'Active','expiry':'30 Nov 2026'},
    {'code':'FREESHIP','type':'Fixed','value':49.0,'min':499.0,'max':49.0,'uses':128,'limit':1000,'status':'Active','expiry':'15 Dec 2026'},
    {'code':'VIP15','type':'Percentage','value':15.0,'min':1499.0,'max':500.0,'uses':19,'limit':50,'status':'Disabled','expiry':'31 Oct 2026'},
    {'code':'FESTIVE500','type':'Fixed','value':500.0,'min':2499.0,'max':500.0,'uses':73,'limit':100,'status':'Active','expiry':'05 Jan 2027'},
  ];
  String query = '';
  String filter = 'All';

  List<Map<String, dynamic>> get filtered => coupons.where((c) {
    final q = query.toLowerCase();
    final matchQ = q.isEmpty || c['code'].toString().toLowerCase().contains(q);
    final matchF = filter == 'All' || c['status'] == filter;
    return matchQ && matchF;
  }).toList();

  void addCoupon() {
    final code = TextEditingController();
    final value = TextEditingController();
    final min = TextEditingController(text: '499');
    String type = 'Percentage';
    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (context, setD) {
      return AlertDialog(
        title: const Text('Create Coupon'),
        content: SizedBox(width: 420, child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: code, decoration: const InputDecoration(labelText: 'Coupon Code')),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(value: type, decoration: const InputDecoration(labelText: 'Discount Type'), items: const [
            DropdownMenuItem(value:'Percentage', child: Text('Percentage')),
            DropdownMenuItem(value:'Fixed', child: Text('Fixed')),
          ], onChanged: (v) => setD(() => type = v ?? type)),
          TextField(controller: value, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Discount Value')),
          TextField(controller: min, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Minimum Order')),
        ]))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(onPressed: () {
            if (code.text.trim().isEmpty) return;
            setState(() => coupons.insert(0, {'code':code.text.trim().toUpperCase(),'type':type,'value':double.tryParse(value.text) ?? 0,'min':double.tryParse(min.text) ?? 0,'max':0.0,'uses':0,'limit':100,'status':'Active','expiry':'31 Dec 2026'}));
            Navigator.pop(context);
          }, child: const Text('Create')),
        ],
      );
    }));
  }

  void details(Map<String, dynamic> c) {
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text(c['code']),
      content: SizedBox(width: 420, child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        _InfoLine('Discount', '${c['value']}${c['type'] == 'Percentage' ? '%' : ' fixed'}'),
        _InfoLine('Minimum Order', '₹${c['min']}'),
        _InfoLine('Usage', '${c['uses']} / ${c['limit']}'),
        _InfoLine('Expiry', c['expiry'].toString()),
        _InfoLine('Status', c['status'].toString()),
        const Divider(),
        const Text('Per-customer limit: 1'),
        const Text('Applicable: All customers'),
        const Text('Stacking: Not allowed'),
      ])),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
    ));
  }

  @override
  Widget build(BuildContext context) => ModuleShell(
    child: Column(children: [
      _ModuleHeader(title: 'Offers & Coupons', subtitle: '${coupons.length} coupons • manage discounts and usage', actions: [
        FilledButton.icon(onPressed: addCoupon, icon: const Icon(Icons.add), label: const Text('Add Coupon')),
      ]),
      Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 12), child: Row(children: [
        Expanded(child: TextField(onChanged: (v) => setState(() => query = v), decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search coupon code...', border: OutlineInputBorder()))),
        const SizedBox(width: 10),
        DropdownButton<String>(value: filter, items: const ['All','Active','Disabled'].map((x) => DropdownMenuItem(value:x, child:Text(x))).toList(), onChanged:(v)=>setState(()=>filter=v!)),
      ])),
      Expanded(child: ListView.builder(itemCount: filtered.length, itemBuilder: (_, i) {
        final c = filtered[i];
        final active = c['status'] == 'Active';
        return Card(margin: const EdgeInsets.fromLTRB(16, 4, 16, 6), child: ListTile(
          leading: CircleAvatar(child: Icon(active ? Icons.local_offer : Icons.block)),
          title: Text(c['code'], style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('${c['type']}: ${c['value']}${c['type']=='Percentage'?'%':' • ₹'} • Min ₹${c['min']} • Used ${c['uses']}/${c['limit']}'),
          trailing: Wrap(spacing: 2, children: [
            IconButton(tooltip:'Details', onPressed:()=>details(c), icon:const Icon(Icons.visibility_outlined)),
            IconButton(tooltip:active?'Disable':'Enable', onPressed:()=>setState(()=>c['status']=active?'Disabled':'Active'), icon:Icon(active?Icons.toggle_on:Icons.toggle_off)),
            IconButton(tooltip:'Delete', onPressed:()=>setState(()=>coupons.remove(c)), icon:const Icon(Icons.delete_outline)),
          ]),
        );
      })),
    ]),
  );
}

class PaymentModule extends StatefulWidget {
  const PaymentModule({super.key, required this.data});
  final KStoreAdminData data;
  @override State<PaymentModule> createState()=>_PaymentModuleState();
}
class _PaymentModuleState extends State<PaymentModule> {
  final List<Map<String,dynamic>> tx = [
    {'id':'PAY-10021','order':'KS10021','customer':'Aarav Sharma','amount':1499.0,'method':'UPI','status':'Paid','date':'03 Oct 2026'},
    {'id':'PAY-10020','order':'KS10020','customer':'Sana Khan','amount':899.0,'method':'Razorpay','status':'Paid','date':'03 Oct 2026'},
    {'id':'PAY-10019','order':'KS10019','customer':'Rahul Verma','amount':2199.0,'method':'COD','status':'Pending','date':'02 Oct 2026'},
    {'id':'PAY-10018','order':'KS10018','customer':'Neha Singh','amount':749.0,'method':'UPI','status':'Refunded','date':'02 Oct 2026'},
    {'id':'PAY-10017','order':'KS10017','customer':'Imran Ali','amount':3299.0,'method':'Card','status':'Paid','date':'01 Oct 2026'},
  ];
  String filter='All';
  void refund(Map<String,dynamic> x) { setState(()=>x['status']='Refunded'); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Refund marked for ${x['id']}'))); }
  @override Widget build(BuildContext context)=>ModuleShell(child:Column(children:[
    _ModuleHeader(title:'Payments',subtitle:'Transactions, payment status and refunds',actions:[OutlinedButton.icon(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Payment export prepared'))),icon:const Icon(Icons.download_outlined),label:const Text('Export'))]),
    _StatsRow(items:[['Total','₹${tx.fold<double>(0,(s,x)=>s+(x['amount'] as double)).toStringAsFixed(0)}',Icons.payments],['Paid','${tx.where((x)=>x['status']=='Paid').length}',Icons.check_circle],['Pending','${tx.where((x)=>x['status']=='Pending').length}',Icons.schedule],['Refunded','${tx.where((x)=>x['status']=='Refunded').length}',Icons.undo]]),
    Padding(padding:const EdgeInsets.symmetric(horizontal:16,vertical:8),child:Align(alignment:Alignment.centerRight,child:DropdownButton<String>(value:filter,items:const ['All','Paid','Pending','Refunded'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>setState(()=>filter=v!)))),
    Expanded(child:ListView(children:tx.where((x)=>filter=='All'||x['status']==filter).map<Widget>((x)=>Card(margin:const EdgeInsets.fromLTRB(16,4,16,6),child:ListTile(
      leading:CircleAvatar(child:Icon(x['status']=='Paid'?Icons.check:x['status']=='Refunded'?Icons.undo:Icons.schedule)),
      title:Text('${x['id']} • ${x['order']}',style:const TextStyle(fontWeight:FontWeight.bold)),
      subtitle:Text('${x['customer']} • ${x['method']} • ${x['date']}'),
      trailing:Wrap(children:[Text('₹${x['amount'].toStringAsFixed(0)}',style:const TextStyle(fontWeight:FontWeight.bold)),if(x['status']=='Paid')IconButton(onPressed:()=>refund(x),icon:const Icon(Icons.currency_exchange))]),
    )).toList())),
  ]));
}

class ShippingModule extends StatefulWidget {
  const ShippingModule({super.key, required this.data}); final KStoreAdminData data;
  @override State<ShippingModule> createState()=>_ShippingModuleState();
}
class _ShippingModuleState extends State<ShippingModule>{
  final List<Map<String,dynamic>> shipments=[
    {'awb':'AWB784512','order':'KS10021','courier':'Shiprocket','status':'In Transit','city':'Delhi','charge':49},
    {'awb':'AWB784511','order':'KS10020','courier':'Delhivery','status':'Delivered','city':'Agra','charge':0},
    {'awb':'AWB784510','order':'KS10019','courier':'Blue Dart','status':'Pending','city':'Jaipur','charge':79},
    {'awb':'AWB784509','order':'KS10018','courier':'Shiprocket','status':'Out for Delivery','city':'Lucknow','charge':49},
  ];
  @override Widget build(BuildContext context)=>ModuleShell(child:Column(children:[
    _ModuleHeader(title:'Delivery & Shipping',subtitle:'Courier, charges, tracking and serviceability',actions:[FilledButton.icon(onPressed:()=>showDialog(context:context,builder:(_)=>const _SimpleFormDialog(title:'Add Shipping Zone',fields:['Zone Name','Pincodes','Delivery Charge','Free Delivery Above'])),icon:const Icon(Icons.add),label:const Text('Add Zone'))]),
    _StatsRow(items:[['Shipments','${shipments.length}',Icons.local_shipping],['In Transit','${shipments.where((x)=>x['status']=='In Transit').length}',Icons.route],['Delivered','${shipments.where((x)=>x['status']=='Delivered').length}',Icons.done_all],['COD Charge','₹29',Icons.money]]),
    Expanded(child:ListView(children:shipments.map<Widget>((x)=>Card(margin:const EdgeInsets.fromLTRB(16,4,16,6),child:ListTile(
      leading:const CircleAvatar(child:Icon(Icons.local_shipping_outlined)),title:Text('${x['awb']} • ${x['order']}',style:const TextStyle(fontWeight:FontWeight.bold)),
      subtitle:Text('${x['courier']} • ${x['city']} • ₹${x['charge']} • ${x['status']}'),
      trailing:PopupMenuButton<String>(onSelected:(v){if(v=='Track')ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Tracking ${x['awb']}')));},itemBuilder:(_)=>const[PopupMenuItem(value:'Track',child:Text('Track Shipment')),PopupMenuItem(value:'Label',child:Text('Download Label')),PopupMenuItem(value:'Cancel',child:Text('Cancel Shipment'))]),
    )).toList())),
  ]));
}

class CustomOrderModule extends StatefulWidget {
  const CustomOrderModule({super.key, required this.data}); final KStoreAdminData data;
  @override State<CustomOrderModule> createState()=>_CustomOrderModuleState();
}
class _CustomOrderModuleState extends State<CustomOrderModule>{
  final List<Map<String,dynamic>> requests=[
    {'id':'CO-001','customer':'Aarav Sharma','request':'Custom herbal combo • 20 units','status':'New','value':0},
    {'id':'CO-002','customer':'Sana Khan','request':'Bulk order • 100 units','status':'Quotation Sent','value':18000},
    {'id':'CO-003','customer':'Imran Ali','request':'Private label packaging','status':'Approved','value':42500},
    {'id':'CO-004','customer':'Neha Singh','request':'Wholesale monthly supply','status':'Processing','value':27000},
  ];
  void add(){final c=TextEditingController();final r=TextEditingController();showDialog(context:context,builder:(_)=>AlertDialog(title:const Text('New Custom Order'),content:Column(mainAxisSize:MainAxisSize.min,children:[TextField(controller:c,decoration:const InputDecoration(labelText:'Customer')),TextField(controller:r,decoration:const InputDecoration(labelText:'Requirement'))]),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Cancel')),FilledButton(onPressed:(){setState(()=>requests.insert(0,{'id':'CO-${requests.length+1}'.padLeft(6,'0'),'customer':c.text,'request':r.text,'status':'New','value':0});Navigator.pop(context);},child:const Text('Create'))]));}
  @override Widget build(BuildContext context)=>ModuleShell(child:Column(children:[
    _ModuleHeader(title:'Custom Orders',subtitle:'Manage quotations, approvals and special requirements',actions:[FilledButton.icon(onPressed:add,icon:const Icon(Icons.add),label:const Text('New Request'))]),
    Expanded(child:ListView(children:requests.map<Widget>((x)=>Card(margin:const EdgeInsets.fromLTRB(16,5,16,5),child:ListTile(
      leading:CircleAvatar(child:Text(x['id'].toString().substring(3))),title:Text('${x['id']} • ${x['customer']}',style:const TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${x['request']}\nStatus: ${x['status']} • Value: ₹${x['value']}'),
      isThreeLine:true,trailing:PopupMenuButton<String>(onSelected:(v)=>setState(()=>x['status']=v),itemBuilder:(_)=>const['New','Quotation Sent','Approved','Processing','Completed','Rejected'].map((v)=>PopupMenuItem(value:v,child:Text(v))).toList()),
    )).toList())),
  ]));
}

class VendorModule extends StatefulWidget {
  const VendorModule({super.key, required this.data}); final KStoreAdminData data;
  @override State<VendorModule> createState()=>_VendorModuleState();
}
class _VendorModuleState extends State<VendorModule>{
  final rows=[['V001','Herbal Care India','vendor@herbalcare.in','Verified','₹84,500'],['V002','Ayur Life','sales@ayurlife.in','Pending','₹42,800'],['V003','Nature Labs','hello@naturelabs.in','Verified','₹1,24,300'],['V004','Wellness Hub','hub@example.com','Suspended','₹18,900']];
  String filter='All';
  @override Widget build(BuildContext context){final list=rows.where((r)=>filter=='All'||r[3]==filter).toList();return ModuleShell(child:Column(children:[
    _ModuleHeader(title:'Vendors',subtitle:'Vendor onboarding, verification, products and payouts',actions:[FilledButton.icon(onPressed:()=>showDialog(context:context,builder:(_)=>const _SimpleFormDialog(title:'Add Vendor',fields:['Business Name','Email','Phone','GSTIN','Address'])),icon:const Icon(Icons.add_business),label:const Text('Add Vendor'))]),
    _StatsRow(items:[['Total','${rows.length}',Icons.storefront],['Verified','${rows.where((r)=>r[3]=='Verified').length}',Icons.verified],['Pending','1',Icons.pending],['Payout Due','₹62,400',Icons.account_balance]]),
    Padding(padding:const EdgeInsets.symmetric(horizontal:16),child:Align(alignment:Alignment.centerRight,child:DropdownButton<String>(value:filter,items:const['All','Verified','Pending','Suspended'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),onChanged:(v)=>setState(()=>filter=v!)))),
    Expanded(child:ListView(children:list.map<Widget>((r)=>Card(margin:const EdgeInsets.fromLTRB(16,4,16,6),child:ListTile(leading:const CircleAvatar(child:Icon(Icons.store)),title:Text('${r[0]} • ${r[1]}'),subtitle:Text('${r[2]} • ${r[3]}\nSales: ${r[4]}'),isThreeLine:true,trailing:IconButton(onPressed:()=>showDialog(context:context,builder:(_)=>_VendorDialog(row:r)),icon:const Icon(Icons.more_horiz)))).toList())),
  ]));}
}
class _VendorDialog extends StatelessWidget{const _VendorDialog({required this.row});final List<String> row;@override Widget build(BuildContext c)=>AlertDialog(title:Text(row[1]),content:Column(mainAxisSize:MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Vendor ID: ${row[0]}'),Text('Email: ${row[2]}'),Text('Status: ${row[3]}'),Text('Sales: ${row[4]}'),const Divider(),const Text('Products: 24'),const Text('Orders: 86'),const Text('Commission: 8%')]),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Close'))]);}

class ResellerModule extends StatefulWidget {
  const ResellerModule({super.key, required this.data}); final KStoreAdminData data;
  @override State<ResellerModule> createState()=>_ResellerModuleState();
}
class _ResellerModuleState extends State<ResellerModule>{
  final rows=[['R001','Aman Traders','aman@example.com','Active','₹48,600','12'],['R002','Sana Store','sana@example.com','Active','₹32,400','8'],['R003','Khan Wellness','khan@example.com','Pending','₹0','0'],['R004','Health Point','health@example.com','Blocked','₹18,900','5']];
  @override Widget build(BuildContext context)=>ModuleShell(child:Column(children:[
    _ModuleHeader(title:'Resellers',subtitle:'0-investment reseller network, sales and commissions',actions:[FilledButton.icon(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Reseller invite link copied'))),icon:const Icon(Icons.link),label:const Text('Invite Reseller'))]),
    _StatsRow(items:[['Resellers','${rows.length}',Icons.groups],['Active','${rows.where((r)=>r[3]=='Active').length}',Icons.check_circle],['Sales','₹99,900',Icons.trending_up],['Commission','₹9,990',Icons.percent]]),
    Expanded(child:ListView(children:rows.map<Widget>((r)=>Card(margin:const EdgeInsets.fromLTRB(16,5,16,5),child:ListTile(leading:const CircleAvatar(child:Icon(Icons.person)),title:Text('${r[0]} • ${r[1]}'),subtitle:Text('${r[2]} • ${r[3]}\nSales ${r[4]} • ${r[5]} orders'),isThreeLine:true,trailing:PopupMenuButton<String>(onSelected:(v)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('$v selected for ${r[1]}'))),itemBuilder:(_)=>const[PopupMenuItem(value:'View Profile',child:Text('View Profile')),PopupMenuItem(value:'Approve',child:Text('Approve')),PopupMenuItem(value:'Payout',child:Text('Payout'))]))).toList())),
  ]));
}

class AffiliateModule extends StatefulWidget {
  const AffiliateModule({super.key, required this.data}); final KStoreAdminData data;
  @override State<AffiliateModule> createState()=>_AffiliateModuleState();
}
class _AffiliateModuleState extends State<AffiliateModule>{
  final rows=[['AF001','Dr. Rahul','rahul@example.com','₹12,450','Active','84'],['AF002','Wellness Blogger','blog@example.com','₹8,920','Active','61'],['AF003','Ayesha Khan','ayesha@example.com','₹3,200','Pending','22'],['AF004','Health Channel','channel@example.com','₹18,700','Active','132']];
  @override Widget build(BuildContext context)=>ModuleShell(child:Column(children:[
    _ModuleHeader(title:'Affiliates',subtitle:'Referral links, clicks, conversions and commissions',actions:[FilledButton.icon(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Affiliate link copied'))),icon:const Icon(Icons.share_outlined),label:const Text('Create Link'))]),
    _StatsRow(items:[['Affiliates','${rows.length}',Icons.campaign],['Clicks','${rows.fold<int>(0,(s,r)=>s+int.parse(r[5]))}',Icons.touch_app],['Conversions','73',Icons.shopping_cart],['Commission','₹43,270',Icons.currency_rupee]]),
    Expanded(child:ListView(children:rows.map<Widget>((r)=>Card(margin:const EdgeInsets.fromLTRB(16,5,16,5),child:ListTile(leading:const CircleAvatar(child:Icon(Icons.campaign)),title:Text('${r[0]} • ${r[1]}'),subtitle:Text('${r[2]} • ${r[4]}\nEarnings ${r[3]} • ${r[5]} clicks'),isThreeLine:true,trailing:IconButton(onPressed:()=>showDialog(context:context,builder:(_)=>AlertDialog(title:Text(r[1]),content:Text('Referral conversion rate: 8.7%\\nPending payout: ${r[3]}\\nCommission plan: 10%'),actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Close'))])),icon:const Icon(Icons.analytics_outlined)))).toList())),
  ]));
}

class WalletRewardModule extends StatefulWidget {
  const WalletRewardModule({super.key, required this.data}); final KStoreAdminData data;
  @override State<WalletRewardModule> createState()=>_WalletRewardModuleState();
}
class _WalletRewardModuleState extends State<WalletRewardModule>{
  final List<Map<String,dynamic>> tx=[
    {'id':'WT001','user':'Aarav Sharma','type':'Credit','amount':500.0,'source':'Refund Wallet','date':'03 Oct'},
    {'id':'WT002','user':'Sana Khan','type':'Debit','amount':200.0,'source':'Order Payment','date':'02 Oct'},
    {'id':'WT003','user':'Imran Ali','type':'Credit','amount':150.0,'source':'Reward Points','date':'02 Oct'},
    {'id':'WT004','user':'Neha Singh','type':'Credit','amount':1000.0,'source':'Promotional Credit','date':'01 Oct'},
  ];
  @override Widget build(BuildContext context)=>ModuleShell(child:Column(children:[
    _ModuleHeader(title:'Wallet & Rewards',subtitle:'Wallet balances, reward points and transactions',actions:[FilledButton.icon(onPressed:()=>showDialog(context:context,builder:(_)=>const _SimpleFormDialog(title:'Manual Wallet Adjustment',fields:['Customer ID','Amount','Credit / Debit','Reason'])),icon:const Icon(Icons.add_card),label:const Text('Adjust Wallet'))]),
    _StatsRow(items:[['Wallet Balance','₹2,48,500',Icons.account_balance_wallet],['Rewards','1,84,200 pts',Icons.stars],['Credits Today','₹8,450',Icons.add_circle],['Debits Today','₹3,280',Icons.remove_circle]]),
    Expanded(child:ListView(children:tx.map<Widget>((x)=>Card(margin:const EdgeInsets.fromLTRB(16,4,16,6),child:ListTile(leading:CircleAvatar(child:Icon(x['type']=='Credit'?Icons.add:Icons.remove)),title:Text('${x['id']} • ${x['user']}'),subtitle:Text('${x['source']} • ${x['date']}'),trailing:Text('${x['type']=='Credit'?'+':'-'} ₹${x['amount']}'))).toList())),
  ]));
}

class InventoryModule extends StatefulWidget {
  const InventoryModule({super.key, required this.data}); final KStoreAdminData data;
  @override State<InventoryModule> createState()=>_InventoryModuleState();
}
class _InventoryModuleState extends State<InventoryModule>{
  final rows=[['SKU001','Slim Trimz Powder','Wellness','124','20','₹270'],['SKU002','Soha Hair Oil 100ml','Hair Care','38','50','₹210'],['SKU003','Kirpilez Tab','Unani','8','25','₹270'],['SKU004','Hanicyst Syrup 500ml','Herbal','72','20','₹599'],['SKU005','Majoan Vajikaran Gold','Wellness','14','10','₹3,200']];
  String q='';
  @override Widget build(BuildContext context){final list=rows.where((r)=>r.join(' ').toLowerCase().contains(q.toLowerCase())).toList();return ModuleShell(child:Column(children:[
    _ModuleHeader(title:'Inventory',subtitle:'Stock levels, low-stock alerts and adjustments',actions:[FilledButton.icon(onPressed:()=>showDialog(context:context,builder:(_)=>const _SimpleFormDialog(title:'Stock Adjustment',fields:['SKU / Product','Quantity','Adjustment Type','Reason'])),icon:const Icon(Icons.tune),label:const Text('Adjust Stock'))]),
    _StatsRow(items:[['Products','${rows.length}',Icons.inventory_2],['Low Stock','${rows.where((r)=>int.parse(r[3])<=int.parse(r[4])).length}',Icons.warning],['Stock Units','256',Icons.warehouse],['Stock Value','₹1.82L',Icons.currency_rupee]]),
    Padding(padding:const EdgeInsets.all(16),child:TextField(onChanged:(v)=>setState(()=>q=v),decoration:const InputDecoration(prefixIcon:Icon(Icons.search),hintText:'Search SKU or product...',border:OutlineInputBorder()))),
    Expanded(child:ListView(children:list.map<Widget>((r)=>Card(margin:const EdgeInsets.fromLTRB(16,2,16,6),child:ListTile(leading:CircleAvatar(child:Icon(int.parse(r[3])<=int.parse(r[4])?Icons.warning:Icons.inventory)),title:Text('${r[0]} • ${r[1]}'),subtitle:Text('${r[2]} • Reorder at ${r[4]} units'),trailing:Text('${r[3]}\\n${r[5]}',textAlign:TextAlign.right))).toList())),
  ]));}
}

class ReportModule extends StatelessWidget {
  const ReportModule({super.key, required this.data}); final KStoreAdminData data;
  @override Widget build(BuildContext context)=>ModuleShell(child:ListView(padding:const EdgeInsets.all(16),children:[
    _ModuleHeader(title:'Reports & Analytics',subtitle:'Business performance and downloadable reports',actions:[OutlinedButton.icon(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Report export prepared'))),icon:const Icon(Icons.download),label:const Text('Export'))]),
    _StatsRow(items:[['Revenue','₹4,82,450',Icons.trending_up],['Orders','486',Icons.shopping_bag],['Customers','312',Icons.people],['AOV','₹993',Icons.receipt_long]]),
    const SizedBox(height:8),
    _ReportCard(title:'Sales Report',icon:Icons.bar_chart,items:['Daily sales','Weekly sales','Monthly sales','Top products']),
    _ReportCard(title:'Customer Report',icon:Icons.people_outline,items:['New customers','Repeat customers','Customer lifetime value','Inactive customers']),
    _ReportCard(title:'Product Report',icon:Icons.inventory_2_outlined,items:['Best sellers','Low stock','Zero sales','Category performance']),
    _ReportCard(title:'Finance Report',icon:Icons.account_balance,items:['Payments','Refunds','COD collection','Profit summary']),
  ]));
}

class MarketingModule extends StatefulWidget {
  const MarketingModule({super.key, required this.data}); final KStoreAdminData data;
  @override State<MarketingModule> createState()=>_MarketingModuleState();
}
class _MarketingModuleState extends State<MarketingModule>{
  final campaigns=[['Summer Wellness Sale','Push + Banner','Active','12.4K'],['Repeat Customer Offer','WhatsApp','Scheduled','4.8K'],['VIP Customer Campaign','Email','Completed','1.2K'],['New Product Launch','Push','Draft','0']];
  @override Widget build(BuildContext context)=>ModuleShell(child:Column(children:[
    _ModuleHeader(title:'Marketing',subtitle:'Campaigns, banners, promotions and customer targeting',actions:[FilledButton.icon(onPressed:()=>showDialog(context:context,builder:(_)=>const _SimpleFormDialog(title:'Create Campaign',fields:['Campaign Name','Channel','Audience','Start Date','Message'])),icon:const Icon(Icons.add),label:const Text('Create Campaign'))]),
    _StatsRow(items:[['Campaigns','${campaigns.length}',Icons.campaign],['Active','1',Icons.play_circle],['Reach','18.4K',Icons.visibility],['Conversions','486',Icons.shopping_cart]]),
    Expanded(child:ListView(children:campaigns.map<Widget>((r)=>Card(margin:const EdgeInsets.fromLTRB(16,5,16,5),child:ListTile(leading:const CircleAvatar(child:Icon(Icons.campaign)),title:Text(r[0],style:const TextStyle(fontWeight:FontWeight.bold)),subtitle:Text('${r[1]} • ${r[2]} • Reach ${r[3]}'),trailing:PopupMenuButton<String>(onSelected:(v)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('$v: ${r[0]}'))),itemBuilder:(_)=>const[PopupMenuItem(value:'Edit',child:Text('Edit')),PopupMenuItem(value:'Duplicate',child:Text('Duplicate')),PopupMenuItem(value:'Pause',child:Text('Pause')),PopupMenuItem(value:'View Report',child:Text('View Report'))]))).toList())),
  ]));
}

class NotificationModule extends StatefulWidget {
  const NotificationModule({super.key, required this.data});

  final KStoreAdminData data;

  @override
  State<NotificationModule> createState() => _NotificationModuleState();
}

class _NotificationModuleState extends State<NotificationModule> {
  final List<Map<String, String>> templates = [
    {
      'title': 'Order Confirmed',
      'message': 'Your order #{order_id} has been confirmed.',
      'status': 'Enabled',
    },
    {
      'title': 'Order Shipped',
      'message': 'Your order is on the way.',
      'status': 'Enabled',
    },
    {
      'title': 'Payment Failed',
      'message': 'Payment could not be completed.',
      'status': 'Enabled',
    },
    {
      'title': 'Welcome',
      'message': 'Welcome to K - Store.',
      'status': 'Disabled',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = [];

    for (final template in templates) {
      final bool enabled = template['status'] == 'Enabled';

      cards.add(
        Card(
          margin: const EdgeInsets.fromLTRB(16, 5, 16, 5),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.notifications_none),
            ),
            title: Text(template['title'] ?? ''),
            subtitle: Text(
              '${template['message'] ?? ''}\n${template['status'] ?? ''}',
            ),
            isThreeLine: true,
            trailing: Switch(
              value: enabled,
              onChanged: (value) {
                setState(() {
                  template['status'] = value ? 'Enabled' : 'Disabled';
                });
              },
            ),
          ),
        ),
      );
    }

    return ModuleShell(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'Notifications',
            subtitle:
                'Push, SMS, email and WhatsApp notification templates',
            actions: [
              FilledButton.icon(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (_) => const _SimpleFormDialog(
                      title: 'Send Notification',
                      fields: [
                        'Title',
                        'Message',
                        'Audience',
                        'Channel',
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text('Send Notification'),
              ),
            ],
          ),
          _StatsRow(
            items: [
              ['Templates', '${templates.length}', Icons.description],
              ['Enabled', '${templates.where((x) => x['status'] == 'Enabled').length}', Icons.notifications_active],
              ['Sent Today', '2,840', Icons.send],
              ['Failed', '18', Icons.error_outline],
            ],
          ),
          Expanded(
            child: ListView(children: cards),
          ),
        ],
      ),
    );
  }
}

class ApiModule extends StatefulWidget {
  const ApiModule({super.key, required this.data});

  final KStoreAdminData data;

  @override
  State<ApiModule> createState() => _ApiModuleState();
}

class _ApiModuleState extends State<ApiModule> {
  final List<Map<String, dynamic>> integrations = [
    {
      'name': 'Razorpay',
      'type': 'Payments',
      'status': 'Connected',
      'icon': Icons.payments,
    },
    {
      'name': 'Shiprocket',
      'type': 'Shipping',
      'status': 'Connected',
      'icon': Icons.local_shipping,
    },
    {
      'name': 'WhatsApp API',
      'type': 'Messaging',
      'status': 'Not Connected',
      'icon': Icons.chat,
    },
    {
      'name': 'Firebase',
      'type': 'Notifications',
      'status': 'Connected',
      'icon': Icons.notifications,
    },
    {
      'name': 'Google Login',
      'type': 'Authentication',
      'status': 'Connected',
      'icon': Icons.login,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> integrationCards = [];

    for (final integration in integrations) {
      final bool connected = integration['status'] == 'Connected';

      integrationCards.add(
        Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(integration['icon'] as IconData),
            ),
            title: Text(integration['name'].toString()),
            subtitle: Text(
              '${integration['type']} • ${integration['status']}',
            ),
            trailing: Switch(
              value: connected,
              onChanged: (value) {
                setState(() {
                  integration['status'] =
                      value ? 'Connected' : 'Not Connected';
                });
              },
            ),
          ),
        ),
      );
    }

    return ModuleShell(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ModuleHeader(
            title: 'API & Integrations',
            subtitle:
                'Payment, shipping, messaging and platform integrations',
            actions: [
              FilledButton.icon(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (_) => const _SimpleFormDialog(
                      title: 'Add API Integration',
                      fields: [
                        'Provider',
                        'API Key',
                        'Secret',
                        'Webhook URL',
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.add_link),
                label: const Text('Add Integration'),
              ),
            ],
          ),
          ...integrationCards,
          const SizedBox(height: 12),
          _ReportCard(
            title: 'Webhooks',
            icon: Icons.webhook,
            items: [
              'Order created',
              'Payment captured',
              'Payment failed',
              'Shipment updated',
              'Customer registered',
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
  final List<Map<String, dynamic>> staff = [
    {
      'id': 'ST001',
      'name': 'Amit Kumar',
      'email': 'amit@kstore.in',
      'role': 'Manager',
      'active': true,
    },
    {
      'id': 'ST002',
      'name': 'Sara Khan',
      'email': 'sara@kstore.in',
      'role': 'Order Manager',
      'active': true,
    },
    {
      'id': 'ST003',
      'name': 'Rohit Singh',
      'email': 'rohit@kstore.in',
      'role': 'Inventory',
      'active': true,
    },
    {
      'id': 'ST004',
      'name': 'Neha Ali',
      'email': 'neha@kstore.in',
      'role': 'Support',
      'active': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> staffCards = [];

    for (final member in staff) {
      final String name = member['name'].toString();
      final bool active = member['active'] == true;

      staffCards.add(
        Card(
          margin: const EdgeInsets.fromLTRB(16, 5, 16, 5),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(name.substring(0, 1)),
            ),
            title: Text(name),
            subtitle: Text(
              '${member['email']} • ${member['role']}',
            ),
            trailing: Switch(
              value: active,
              onChanged: (value) {
                setState(() {
                  member['active'] = value;
                });
              },
            ),
          ),
        ),
      );
    }

    final int activeCount =
        staff.where((member) => member['active'] == true).length;

    return ModuleShell(
      child: Column(
        children: [
          _ModuleHeader(
            title: 'Staff & Roles',
            subtitle: 'Team members, roles and permissions',
            actions: [
              FilledButton.icon(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (_) => const _SimpleFormDialog(
                      title: 'Add Staff',
                      fields: [
                        'Name',
                        'Email',
                        'Phone',
                        'Role',
                        'Password',
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.person_add),
                label: const Text('Add Staff'),
              ),
            ],
          ),
          _StatsRow(
            items: [
              ['Staff', '${staff.length}', Icons.people],
              ['Active', '$activeCount', Icons.check_circle],
              ['Roles', '6', Icons.admin_panel_settings],
              ['Admins', '2', Icons.security],
            ],
          ),
          Expanded(
            child: ListView(children: staffCards),
          ),
        ],
      ),
    );
  }
}
class SettingsModule extends StatefulWidget {
  const SettingsModule({super.key, required this.data}); final KStoreAdminData data;
  @override State<SettingsModule> createState()=>_SettingsModuleState();
}
class _SettingsModuleState extends State<SettingsModule>{
  bool cod=true, online=true, autoConfirm=true, reviews=true, lowStock=true;
  @override Widget build(BuildContext context)=>ModuleShell(child:ListView(padding:const EdgeInsets.all(16),children:[
    _ModuleHeader(title:'Settings',subtitle:'Configure store, orders, payments, shipping and notifications'),
    _SettingSection(title:'Store Settings',icon:Icons.store,children:[
      const ListTile(title:Text('Store Name'),subtitle:Text('K - Store'),trailing:Icon(Icons.chevron_right)),
      const ListTile(title:Text('Support Phone'),subtitle:Text('+91 00000 00000'),trailing:Icon(Icons.chevron_right)),
      const ListTile(title:Text('Support Email'),subtitle:Text('support@kstore.in'),trailing:Icon(Icons.chevron_right)),
    ]),
    _SettingSection(title:'Order Settings',icon:Icons.shopping_bag,children:[
      SwitchListTile(title:const Text('Auto Confirm Orders'),value:autoConfirm,onChanged:(v)=>setState(()=>autoConfirm=v)),
      SwitchListTile(title:const Text('Allow Customer Reviews'),value:reviews,onChanged:(v)=>setState(()=>reviews=v)),
    ]),
    _SettingSection(title:'Payment Settings',icon:Icons.payments,children:[
      SwitchListTile(title:const Text('Cash on Delivery'),value:cod,onChanged:(v)=>setState(()=>cod=v)),
      SwitchListTile(title:const Text('Online Payments'),value:online,onChanged:(v)=>setState(()=>online=v)),
    ]),
    _SettingSection(title:'Inventory & Alerts',icon:Icons.inventory_2,children:[
      SwitchListTile(title:const Text('Low Stock Notifications'),value:lowStock,onChanged:(v)=>setState(()=>lowStock=v)),
      const ListTile(title:Text('Low Stock Threshold'),subtitle:Text('20 units'),trailing:Icon(Icons.chevron_right)),
    ]),
  ]));
}

class SecurityModule extends StatefulWidget {
  const SecurityModule({super.key, required this.data}); final KStoreAdminData data;
  @override State<SecurityModule> createState()=>_SecurityModuleState();
}
class _SecurityModuleState extends State<SecurityModule>{
  bool twoFactor=true, loginAlerts=true, biometric=false;
  @override Widget build(BuildContext context)=>ModuleShell(child:ListView(padding:const EdgeInsets.all(16),children:[
    _ModuleHeader(title:'Account & Security',subtitle:'Administrator profile, password and security controls',actions:[OutlinedButton.icon(onPressed:()=>showDialog(context:context,builder:(_)=>const _SimpleFormDialog(title:'Change Password',fields:['Current Password','New Password','Confirm Password'])),icon:const Icon(Icons.lock_reset),label:const Text('Change Password'))]),
    Card(child:ListTile(leading:const CircleAvatar(child:Text('K')),title:const Text('K - Store Admin'),subtitle:const Text('Administrator • admin@kstore.in'),trailing:IconButton(onPressed:()=>showDialog(context:context,builder:(_)=>const _SimpleFormDialog(title:'Edit Profile',fields:['Name','Email','Phone'])),icon:const Icon(Icons.edit_outlined)))),
    const SizedBox(height:12),
    _SettingSection(title:'Security',icon:Icons.security,children:[
      SwitchListTile(title:const Text('Two-Factor Authentication'),subtitle:const Text('Protect administrator login with an extra verification step'),value:twoFactor,onChanged:(v)=>setState(()=>twoFactor=v)),
      SwitchListTile(title:const Text('Login Alerts'),subtitle:const Text('Notify when a new device signs in'),value:loginAlerts,onChanged:(v)=>setState(()=>loginAlerts=v)),
      SwitchListTile(title:const Text('Biometric Unlock'),subtitle:const Text('Use device biometrics when supported'),value:biometric,onChanged:(v)=>setState(()=>biometric=v)),
    ]),
    _SettingSection(title:'Sessions',icon:Icons.devices,children:[
      const ListTile(title:Text('Current Device'),subtitle:Text('Android • Active now'),trailing:Chip(label:Text('Current'))),
      ListTile(title:const Text('Other Sessions'),subtitle:const Text('2 active sessions'),trailing:TextButton(onPressed:(){},child:const Text('Sign out all'))),
    ]),
  ]));
}

// -----------------------------------------------------------------------------
// Shared widgets for the remaining modules
// -----------------------------------------------------------------------------

class _ModuleHeader extends StatelessWidget {
  const _ModuleHeader({required this.title, required this.subtitle, this.actions = const []});
  final String title, subtitle;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ])),
      ...actions,
    ]),
  );
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.items});
  final List<List<dynamic>> items;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 96,
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (_, i) => SizedBox(width: 155, child: Card(
        child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
          CircleAvatar(radius: 18, child: Icon(items[i][2] as IconData, size: 19)),
          const SizedBox(width: 10),
          Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(items[i][0].toString(), style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 2),
            Text(items[i][1].toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          ])),
        ])),
      )),
    ),
  );
}

class _InfoLine extends StatelessWidget {
  const _InfoLine(this.label, this.value);
  final String label, value;
  @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.symmetric(vertical:5),child:Row(children:[Expanded(child:Text(label,style:const TextStyle(fontWeight:FontWeight.w600))),Text(value)]));
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.title, required this.icon, required this.items});
  final String title; final IconData icon; final List<String> items;
  @override Widget build(BuildContext context)=>Card(margin:const EdgeInsets.only(bottom:12),child:ExpansionTile(leading:CircleAvatar(child:Icon(icon)),title:Text(title,style:const TextStyle(fontWeight:FontWeight.bold)),children:items.map<Widget>((x)=>ListTile(title:Text(x),leading:const Icon(Icons.chevron_right),onTap:()=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('$x opened'))))).toList()));
}

class _SettingSection extends StatelessWidget {
  const _SettingSection({required this.title, required this.icon, required this.children});
  final String title; final IconData icon; final List<Widget> children;
  @override Widget build(BuildContext context)=>Card(margin:const EdgeInsets.only(bottom:12),child:Column(children:[
    ListTile(leading:CircleAvatar(child:Icon(icon)),title:Text(title,style:const TextStyle(fontWeight:FontWeight.bold))),
    ...children,
  ]));
}

class _SimpleFormDialog extends StatelessWidget {
  const _SimpleFormDialog({required this.title, required this.fields});
  final String title; final List<String> fields;
  @override Widget build(BuildContext context)=>AlertDialog(
    title:Text(title),
    content:SizedBox(width:420,child:SingleChildScrollView(child:Column(mainAxisSize:MainAxisSize.min,children:fields.map<Widget>((f)=>Padding(padding:const EdgeInsets.only(bottom:10),child:TextField(decoration:InputDecoration(labelText:f,border:const OutlineInputBorder())))).toList()))),
    actions:[TextButton(onPressed:()=>Navigator.pop(context),child:const Text('Cancel')),FilledButton(onPressed:()=>Navigator.pop(context),child:const Text('Save'))],
  );
}
