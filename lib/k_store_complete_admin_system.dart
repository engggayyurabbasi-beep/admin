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
    Icons.marketing_outlined,
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
  ProductItem(this.id, this.name, this.category, this.price, this.mrp, this.stock);
  String id, name, category;
  double price, mrp;
  int stock;
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

  @override
  Widget build(BuildContext context) {
    final products = widget.data.products.where((p) {
      final q = query.toLowerCase();
      final matches = p.name.toLowerCase().contains(q) ||
          p.id.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q);
      final stock = stockFilter == 'All' ||
          (stockFilter == 'In Stock' && p.stock > 10) ||
          (stockFilter == 'Low Stock' && p.stock > 0 && p.stock <= 10) ||
          (stockFilter == 'Out of Stock' && p.stock == 0);
      return matches && stock;
    }).toList();

    return ModuleShell(
      actions: [
        FilledButton.icon(
          onPressed: () => _addProduct(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Product'),
        ),
      ],
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search products, SKU or category',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) => setState(() => query = v),
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: stockFilter,
                items: ['All', 'In Stock', 'Low Stock', 'Out of Stock']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) => setState(() => stockFilter = v!),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (_, i) {
                final p = products[i];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.inventory_2)),
                    title: Text(p.name),
                    subtitle: Text('${p.id} • ${p.category} • Stock: ${p.stock}'),
                    trailing: Wrap(
                      children: [
                        Text('₹${p.price.toStringAsFixed(0)}'),
                        IconButton(onPressed: () => _editProduct(context, p), icon: const Icon(Icons.edit)),
                        IconButton(onPressed: () {
                          widget.data.products.remove(p);
                          widget.data.changed();
                          setState(() {});
                        }, icon: const Icon(Icons.delete_outline)),
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

  void _addProduct(BuildContext context) {
    final name = TextEditingController();
    final price = TextEditingController();
    final stock = TextEditingController();
    showFormDialog(
      context,
      title: 'Add Product',
      fields: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Product Name')),
        TextField(controller: price, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Selling Price')),
        TextField(controller: stock, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Opening Stock')),
      ],
      onSave: () {
        widget.data.products.add(ProductItem(
          'P${DateTime.now().millisecondsSinceEpoch}',
          name.text.isEmpty ? 'New Product' : name.text,
          'General',
          double.tryParse(price.text) ?? 0,
          double.tryParse(price.text) ?? 0,
          int.tryParse(stock.text) ?? 0,
        ));
        widget.data.changed();
        setState(() {});
      },
    );
  }

  void _editProduct(BuildContext context, ProductItem p) {
    final price = TextEditingController(text: p.price.toString());
    final stock = TextEditingController(text: p.stock.toString());
    showFormDialog(
      context,
      title: 'Edit Product',
      fields: [
        Text('Product: ${p.name}'),
        TextField(controller: price, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Selling Price')),
        TextField(controller: stock, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Stock')),
      ],
      onSave: () {
        p.price = double.tryParse(price.text) ?? p.price;
        p.stock = int.tryParse(stock.text) ?? p.stock;
        widget.data.changed();
        setState(() {});
      },
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

class OrderModule extends StatefulWidget {
  const OrderModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<OrderModule> createState() => _OrderModuleState();
}

class _OrderModuleState extends State<OrderModule> {
  String filter = 'All';

  @override
  Widget build(BuildContext context) {
    final list = filter == 'All'
        ? widget.data.orders
        : widget.data.orders.where((o) => o.status == filter).toList();

    return ModuleShell(
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            children: ['All', 'Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled']
                .map((s) => ChoiceChip(label: Text(s), selected: filter == s, onSelected: (_) => setState(() => filter = s)))
                .toList(),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(children: list.map((o) => Card(
              child: ListTile(
                leading: const Icon(Icons.receipt_long),
                title: Text(o.id),
                subtitle: Text('${o.customer} • ${o.payment}'),
                trailing: DropdownButton<String>(
                  value: o.status,
                  items: ['Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled']
                      .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                  onChanged: (v) => setState(() => o.status = v!),
                ),
              ),
            )).toList()),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4 CUSTOMERS
// -----------------------------------------------------------------------------

class CustomerModule extends StatefulWidget {
  const CustomerModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<CustomerModule> createState() => _CustomerModuleState();
}

class _CustomerModuleState extends State<CustomerModule> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final list = widget.data.customers.where((c) =>
        c.name.toLowerCase().contains(query.toLowerCase()) ||
        c.email.toLowerCase().contains(query.toLowerCase())).toList();

    return ModuleShell(
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search customers', border: OutlineInputBorder()),
            onChanged: (v) => setState(() => query = v),
          ),
          const SizedBox(height: 12),
          Expanded(child: ListView(children: list.map((c) => Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(c.name),
              subtitle: Text('${c.email} • Orders: ${c.orders}'),
              trailing: Chip(label: Text(c.status)),
            ),
          )).toList())),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 5 OFFERS & COUPONS
// -----------------------------------------------------------------------------

class OfferModule extends StatefulWidget {
  const OfferModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<OfferModule> createState() => _OfferModuleState();
}

class _OfferModuleState extends State<OfferModule> {
  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [
        FilledButton.icon(onPressed: _add, icon: const Icon(Icons.add), label: const Text('Create Coupon')),
      ],
      child: ListView(children: widget.data.offers.map((o) => Card(
        child: ListTile(
          leading: const Icon(Icons.local_offer),
          title: Text(o.code),
          subtitle: Text('${o.description} • Value ₹${o.value.toStringAsFixed(0)}'),
          trailing: Switch(
            value: o.status == 'Active',
            onChanged: (v) => setState(() => o.status = v ? 'Active' : 'Disabled'),
          ),
        ),
      )).toList()),
    );
  }

  void _add() {
    final code = TextEditingController();
    final value = TextEditingController();
    showFormDialog(
      context,
      title: 'Create Coupon',
      fields: [
        TextField(controller: code, decoration: const InputDecoration(labelText: 'Coupon Code')),
        TextField(controller: value, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Discount Value')),
      ],
      onSave: () {
        widget.data.offers.add(OfferItem(code.text.toUpperCase(), 'New offer', double.tryParse(value.text) ?? 0, 'Active'));
        setState(() {});
      },
    );
  }
}

// -----------------------------------------------------------------------------
// 6 PAYMENTS
// -----------------------------------------------------------------------------

class PaymentModule extends StatelessWidget {
  const PaymentModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: ListView(
        children: [
          SectionCard(
            title: 'Payment Methods',
            child: Column(
              children: [
                _toggle(context, 'Online Payment', 'Accept UPI, cards and net banking', 'Online payment'),
                _toggle(context, 'Cash on Delivery', 'Allow COD at checkout', 'COD enabled'),
              ],
            ),
          ),
          SectionCard(
            title: 'Payment Controls',
            child: const Column(
              children: [
                ListTile(leading: Icon(Icons.currency_rupee), title: Text('Razorpay'), subtitle: Text('Gateway configuration')),
                ListTile(leading: Icon(Icons.account_balance), title: Text('Settlement'), subtitle: Text('Track gateway settlements')),
                ListTile(leading: Icon(Icons.receipt), title: Text('Refunds'), subtitle: Text('Review and process refunds')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggle(BuildContext context, String title, String sub, String key) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(sub),
      value: data.settings[key] ?? false,
      onChanged: (v) { data.settings[key] = v; data.changed(); },
    );
  }
}

// -----------------------------------------------------------------------------
// 7 DELIVERY & SHIPPING
// -----------------------------------------------------------------------------

class ShippingModule extends StatelessWidget {
  const ShippingModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [
        FilledButton.icon(
          onPressed: () => showFormDialog(
            context,
            title: 'Add Pincode Rule',
            fields: const [
              TextField(decoration: InputDecoration(labelText: 'Pincode / Pincode Range')),
              TextField(decoration: InputDecoration(labelText: 'Delivery Charge')),
            ],
            onSave: () {},
          ),
          icon: const Icon(Icons.add_location_alt),
          label: const Text('Add Pincode Rule'),
        ),
      ],
      child: ListView(
        children: [
          SectionCard(
            title: 'Shipping Settings',
            child: Column(
              children: [
                const ListTile(title: Text('Free Delivery Threshold'), trailing: Text('₹999')),
                const ListTile(title: Text('Default Delivery Charge'), trailing: Text('₹49')),
                const ListTile(title: Text('Blocked Pincodes'), trailing: Text('0')),
                const ListTile(title: Text('Courier Integration'), trailing: Text('Shiprocket / Shipmojo')),
              ],
            ),
          ),
          SectionCard(
            title: 'Delivery Rules',
            child: const Column(
              children: [
                ListTile(leading: Icon(Icons.pin_drop), title: Text('Pincode Management'), subtitle: Text('Allow, block or set charges by pincode')),
                ListTile(leading: Icon(Icons.local_shipping), title: Text('Courier Services'), subtitle: Text('Enable and prioritize courier partners')),
                ListTile(leading: Icon(Icons.track_changes), title: Text('AWB Tracking'), subtitle: Text('Track shipment and delivery status')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 8 CUSTOM ORDERS
// -----------------------------------------------------------------------------

class CustomOrderModule extends StatefulWidget {
  const CustomOrderModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<CustomOrderModule> createState() => _CustomOrderModuleState();
}

class _CustomOrderModuleState extends State<CustomOrderModule> {
  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [
        FilledButton.icon(onPressed: _add, icon: const Icon(Icons.add), label: const Text('New Custom Order')),
      ],
      child: ListView(children: widget.data.customOrders.map((o) => Card(
        child: ListTile(
          leading: const Icon(Icons.assignment),
          title: Text(o.id),
          subtitle: Text('${o.customer} • ${o.request}'),
          trailing: DropdownButton<String>(
            value: o.status,
            items: ['New', 'Quoted', 'Approved', 'Processing', 'Completed', 'Rejected']
                .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            onChanged: (v) => setState(() => o.status = v!),
          ),
        ),
      )).toList()),
    );
  }

  void _add() {
    final customer = TextEditingController();
    final request = TextEditingController();
    showFormDialog(
      context,
      title: 'New Custom Order',
      fields: [
        TextField(controller: customer, decoration: const InputDecoration(labelText: 'Customer')),
        TextField(controller: request, decoration: const InputDecoration(labelText: 'Requirement')),
      ],
      onSave: () {
        widget.data.customOrders.add(CustomOrderItem(
          'CO${DateTime.now().millisecondsSinceEpoch}',
          customer.text,
          request.text,
          'New',
        ));
        setState(() {});
      },
    );
  }
}

// -----------------------------------------------------------------------------
// 9 VENDORS
// -----------------------------------------------------------------------------

class VendorModule extends StatefulWidget {
  const VendorModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<VendorModule> createState() => _VendorModuleState();
}

class _VendorModuleState extends State<VendorModule> {
  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [FilledButton.icon(onPressed: _add, icon: const Icon(Icons.person_add), label: const Text('Add Vendor'))],
      child: ListView(children: widget.data.vendors.map((v) => Card(
        child: ListTile(
          leading: const Icon(Icons.storefront),
          title: Text(v.name),
          subtitle: Text('${v.id} • ${v.email}'),
          trailing: DropdownButton<String>(
            value: v.status,
            items: ['Pending', 'Approved', 'Suspended', 'Rejected']
                .map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (s) => setState(() => v.status = s!),
          ),
        ),
      )).toList()),
    );
  }

  void _add() {
    final name = TextEditingController();
    final email = TextEditingController();
    showFormDialog(
      context,
      title: 'Add Vendor',
      fields: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Vendor Name')),
        TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
      ],
      onSave: () {
        widget.data.vendors.add(VendorItem('V${DateTime.now().millisecondsSinceEpoch}', name.text, email.text, 'Pending'));
        setState(() {});
      },
    );
  }
}

// -----------------------------------------------------------------------------
// 10 RESELLERS
// -----------------------------------------------------------------------------

class ResellerModule extends StatefulWidget {
  const ResellerModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<ResellerModule> createState() => _ResellerModuleState();
}

class _ResellerModuleState extends State<ResellerModule> {
  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [FilledButton.icon(onPressed: _add, icon: const Icon(Icons.person_add), label: const Text('Add Reseller'))],
      child: ListView(children: widget.data.resellers.map((r) => Card(
        child: ListTile(
          leading: const Icon(Icons.groups),
          title: Text(r.name),
          subtitle: Text('${r.id} • ${r.email}'),
          trailing: DropdownButton<String>(
            value: r.status,
            items: ['Pending', 'Active', 'Suspended']
                .map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (s) => setState(() => r.status = s!),
          ),
        ),
      )).toList()),
    );
  }

  void _add() {
    final name = TextEditingController();
    final email = TextEditingController();
    showFormDialog(
      context,
      title: 'Add Reseller',
      fields: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
        TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
      ],
      onSave: () {
        widget.data.resellers.add(ResellerItem('R${DateTime.now().millisecondsSinceEpoch}', name.text, email.text, 'Active'));
        setState(() {});
      },
    );
  }
}

// -----------------------------------------------------------------------------
// 11 AFFILIATES
// -----------------------------------------------------------------------------

class AffiliateModule extends StatefulWidget {
  const AffiliateModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<AffiliateModule> createState() => _AffiliateModuleState();
}

class _AffiliateModuleState extends State<AffiliateModule> {
  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [FilledButton.icon(onPressed: _add, icon: const Icon(Icons.add), label: const Text('Add Affiliate'))],
      child: ListView(children: widget.data.affiliates.map((a) => Card(
        child: ListTile(
          leading: const Icon(Icons.campaign),
          title: Text(a.name),
          subtitle: Text('${a.email} • Earnings ₹${a.earnings.toStringAsFixed(0)}'),
          trailing: Chip(label: Text(a.status)),
        ),
      )).toList()),
    );
  }

  void _add() {
    final name = TextEditingController();
    final email = TextEditingController();
    showFormDialog(
      context,
      title: 'Add Affiliate',
      fields: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
        TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
      ],
      onSave: () {
        widget.data.affiliates.add(AffiliateItem('A${DateTime.now().millisecondsSinceEpoch}', name.text, email.text, 0, 'Active'));
        setState(() {});
      },
    );
  }
}

// -----------------------------------------------------------------------------
// 12 WALLET & REWARDS
// -----------------------------------------------------------------------------

class WalletRewardModule extends StatelessWidget {
  const WalletRewardModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: ListView(
        children: [
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(width: 220, child: StatCard('Wallet Balance', '₹0', Icons.account_balance_wallet)),
              SizedBox(width: 220, child: StatCard('Reward Points', '0', Icons.stars)),
              SizedBox(width: 220, child: StatCard('Withdrawals', '0', Icons.payments)),
            ],
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: 'Wallet & Rewards Controls',
            child: Column(
              children: [
                SwitchListTile(value: true, onChanged: (_) {}, title: const Text('Enable Customer Wallet')),
                SwitchListTile(value: true, onChanged: (_) {}, title: const Text('Enable Reward Points')),
                const ListTile(title: Text('Points Conversion'), trailing: Text('100 points = ₹10')),
                const ListTile(title: Text('Minimum Withdrawal'), trailing: Text('₹500')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 13 INVENTORY
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
    return ModuleShell(
      actions: [
        FilledButton.icon(onPressed: _adjustStock, icon: const Icon(Icons.add_box), label: const Text('Stock Adjustment')),
      ],
      child: ListView(
        children: widget.data.products.map((p) => Card(
          child: ListTile(
            leading: const Icon(Icons.warehouse),
            title: Text(p.name),
            subtitle: Text('SKU ${p.id} • Category ${p.category}'),
            trailing: Text(
              '${p.stock}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: p.stock == 0 ? Colors.red : p.stock <= 10 ? Colors.orange : Colors.green,
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  void _adjustStock() {
    final sku = TextEditingController();
    final qty = TextEditingController();
    showFormDialog(
      context,
      title: 'Stock Adjustment',
      fields: [
        TextField(controller: sku, decoration: const InputDecoration(labelText: 'Product SKU')),
        TextField(controller: qty, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Quantity (+/-)')),
      ],
      onSave: () {
        final p = widget.data.products.where((x) => x.id == sku.text).firstOrNull;
        if (p != null) p.stock += int.tryParse(qty.text) ?? 0;
        setState(() {});
      },
    );
  }
}

// -----------------------------------------------------------------------------
// 14 REPORTS & ANALYTICS
// -----------------------------------------------------------------------------

class ReportModule extends StatelessWidget {
  const ReportModule({super.key, required this.data});
  final KStoreAdminData data;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [
        OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: const Text('Export Report')),
      ],
      child: ListView(
        children: [
          const Text('Reports & Analytics', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(width: 220, child: StatCard('Gross Sales', '₹${data.sales.toStringAsFixed(0)}', Icons.trending_up)),
              SizedBox(width: 220, child: StatCard('Orders', '${data.orders.length}', Icons.receipt_long)),
              SizedBox(width: 220, child: StatCard('Customers', '${data.customers.length}', Icons.people)),
              SizedBox(width: 220, child: StatCard('Low Stock', '${data.lowStock}', Icons.warning)),
            ],
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: 'Available Reports',
            child: Column(
              children: const [
                ListTile(leading: Icon(Icons.bar_chart), title: Text('Sales Report'), subtitle: Text('Daily, weekly, monthly and custom range')),
                ListTile(leading: Icon(Icons.shopping_cart), title: Text('Product Performance'), subtitle: Text('Top selling and slow moving products')),
                ListTile(leading: Icon(Icons.people), title: Text('Customer Report'), subtitle: Text('New, active, repeat and inactive customers')),
                ListTile(leading: Icon(Icons.account_balance_wallet), title: Text('Payment Report'), subtitle: Text('Gateway, COD, refund and settlement data')),
                ListTile(leading: Icon(Icons.local_shipping), title: Text('Shipping Report'), subtitle: Text('Courier and delivery performance')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 15 MARKETING
// -----------------------------------------------------------------------------

class MarketingModule extends StatefulWidget {
  const MarketingModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<MarketingModule> createState() => _MarketingModuleState();
}

class _MarketingModuleState extends State<MarketingModule> {
  bool flashSale = true;
  bool freeGift = false;
  bool freeDelivery = true;
  bool whatsapp = false;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [
        FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Create Campaign')),
      ],
      child: ListView(
        children: [
          SectionCard(
            title: 'Promotions',
            child: Column(
              children: [
                SwitchListTile(value: flashSale, onChanged: (v) => setState(() => flashSale = v), title: const Text('Flash Sale')),
                SwitchListTile(value: freeGift, onChanged: (v) => setState(() => freeGift = v), title: const Text('Free Gift')),
                SwitchListTile(value: freeDelivery, onChanged: (v) => setState(() => freeDelivery = v), title: const Text('Free Delivery')),
              ],
            ),
          ),
          SectionCard(
            title: 'Customer Marketing',
            child: Column(
              children: [
                ListTile(leading: const Icon(Icons.notifications), title: const Text('Push Campaigns'), trailing: FilledButton(onPressed: () {}, child: const Text('Create'))),
                ListTile(leading: const Icon(Icons.message), title: const Text('WhatsApp Updates'), trailing: Switch(value: whatsapp, onChanged: (v) => setState(() => whatsapp = v))),
                ListTile(leading: const Icon(Icons.email), title: const Text('Email Campaigns'), trailing: FilledButton(onPressed: () {}, child: const Text('Create'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 16 NOTIFICATIONS
// -----------------------------------------------------------------------------

class NotificationModule extends StatefulWidget {
  const NotificationModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<NotificationModule> createState() => _NotificationModuleState();
}

class _NotificationModuleState extends State<NotificationModule> {
  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [
        FilledButton.icon(onPressed: _add, icon: const Icon(Icons.add_alert), label: const Text('Create Notification')),
      ],
      child: ListView(children: widget.data.notifications.map((n) => Card(
        child: SwitchListTile(
          value: n.enabled,
          onChanged: (v) => setState(() => n.enabled = v),
          title: Text(n.title),
          subtitle: Text(n.message),
        ),
      )).toList()),
    );
  }

  void _add() {
    final title = TextEditingController();
    final message = TextEditingController();
    showFormDialog(
      context,
      title: 'Create Notification',
      fields: [
        TextField(controller: title, decoration: const InputDecoration(labelText: 'Title')),
        TextField(controller: message, decoration: const InputDecoration(labelText: 'Message')),
      ],
      onSave: () {
        widget.data.notifications.add(NotificationItem(title.text, message.text, true));
        setState(() {});
      },
    );
  }
}

// -----------------------------------------------------------------------------
// 17 API & INTEGRATIONS
// -----------------------------------------------------------------------------

class ApiModule extends StatefulWidget {
  const ApiModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<ApiModule> createState() => _ApiModuleState();
}

class _ApiModuleState extends State<ApiModule> {
  final integrations = <String, bool>{
    'Razorpay': true,
    'Shiprocket': false,
    'Shipmojo': false,
    'WhatsApp API': false,
    'Firebase': true,
    'Google Login': false,
  };

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [
        OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.refresh), label: const Text('Test Connections')),
      ],
      child: ListView(
        children: [
          SectionCard(
            title: 'Integrations',
            child: Column(
              children: integrations.keys.map((name) => SwitchListTile(
                value: integrations[name]!,
                onChanged: (v) => setState(() => integrations[name] = v),
                title: Text(name),
                subtitle: Text(integrations[name]! ? 'Connected / Enabled' : 'Not connected'),
              )).toList(),
            ),
          ),
          SectionCard(
            title: 'API Security',
            child: Column(
              children: [
                ListTile(title: const Text('API Base URL'), subtitle: const Text('Configure production API endpoint'), trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit))),
                ListTile(title: const Text('API Secret'), subtitle: const Text('Stored outside the UI in production'), trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.key))),
                ListTile(title: const Text('Webhook Logs'), subtitle: const Text('Review incoming and outgoing webhooks'), trailing: FilledButton(onPressed: () {}, child: const Text('Open'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 18 STAFF & ROLES
// -----------------------------------------------------------------------------

class StaffRoleModule extends StatefulWidget {
  const StaffRoleModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<StaffRoleModule> createState() => _StaffRoleModuleState();
}

class _StaffRoleModuleState extends State<StaffRoleModule> {
  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      actions: [
        FilledButton.icon(onPressed: _add, icon: const Icon(Icons.person_add), label: const Text('Add Staff')),
      ],
      child: ListView(
        children: [
          ...widget.data.staff.map((s) => Card(
            child: SwitchListTile(
              value: s.active,
              onChanged: (v) => setState(() => s.active = v),
              title: Text(s.name),
              subtitle: Text('${s.email} • ${s.role}'),
            ),
          )),
          const SectionCard(
            title: 'Role Permissions',
            child: Column(
              children: [
                ListTile(leading: Icon(Icons.security), title: Text('Super Admin'), subtitle: Text('Full access')),
                ListTile(leading: Icon(Icons.store), title: Text('Store Manager'), subtitle: Text('Products, orders, inventory')),
                ListTile(leading: Icon(Icons.support_agent), title: Text('Support Staff'), subtitle: Text('Customers, orders and support')),
                ListTile(leading: Icon(Icons.campaign), title: Text('Marketing Staff'), subtitle: Text('Offers, coupons and campaigns')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _add() {
    final name = TextEditingController();
    final email = TextEditingController();
    showFormDialog(
      context,
      title: 'Add Staff',
      fields: [
        TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
        TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
      ],
      onSave: () {
        widget.data.staff.add(StaffItem('S${DateTime.now().millisecondsSinceEpoch}', name.text, email.text, 'Staff', true));
        setState(() {});
      },
    );
  }
}

// -----------------------------------------------------------------------------
// 19 SETTINGS
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
    return ModuleShell(
      child: ListView(
        children: [
          SectionCard(
            title: 'Store Settings',
            child: Column(
              children: widget.data.settings.entries.map((e) => SwitchListTile(
                value: e.value,
                onChanged: (v) {
                  setState(() => widget.data.settings[e.key] = v);
                },
                title: Text(e.key),
              )).toList(),
            ),
          ),
          SectionCard(
            title: 'Store Information',
            child: Column(
              children: [
                ListTile(title: const Text('Store Name'), subtitle: const Text('K - Store'), trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit))),
                ListTile(title: const Text('Support Email'), subtitle: const Text('support@example.com'), trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit))),
                ListTile(title: const Text('Support Phone'), subtitle: const Text('+91 00000 00000'), trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit))),
                ListTile(title: const Text('Currency'), subtitle: const Text('INR (₹)'), trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit))),
              ],
            ),
          ),
          SectionCard(
            title: 'Maintenance',
            child: Column(
              children: [
                ListTile(title: const Text('Backup Data'), trailing: FilledButton(onPressed: () {}, child: const Text('Backup'))),
                ListTile(title: const Text('Restore Data'), trailing: OutlinedButton(onPressed: () {}, child: const Text('Restore'))),
                ListTile(title: const Text('Clear Cache'), trailing: OutlinedButton(onPressed: () {}, child: const Text('Clear'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 20 ACCOUNT & SECURITY
// -----------------------------------------------------------------------------

class SecurityModule extends StatefulWidget {
  const SecurityModule({super.key, required this.data});
  final KStoreAdminData data;
  @override
  State<SecurityModule> createState() => _SecurityModuleState();
}

class _SecurityModuleState extends State<SecurityModule> {
  bool twoFactor = false;
  bool loginAlerts = true;

  @override
  Widget build(BuildContext context) {
    return ModuleShell(
      child: ListView(
        children: [
          SectionCard(
            title: 'Account',
            child: Column(
              children: [
                const ListTile(leading: Icon(Icons.person), title: Text('Administrator'), subtitle: Text('admin@kstore.com')),
                ListTile(leading: const Icon(Icons.password), title: const Text('Change Password'), trailing: FilledButton(onPressed: () {}, child: const Text('Change'))),
                ListTile(leading: const Icon(Icons.logout), title: const Text('Logout Other Sessions'), trailing: OutlinedButton(onPressed: () {}, child: const Text('Logout'))),
              ],
            ),
          ),
          SectionCard(
            title: 'Security',
            child: Column(
              children: [
                SwitchListTile(value: twoFactor, onChanged: (v) => setState(() => twoFactor = v), title: const Text('Two-Factor Authentication')),
                SwitchListTile(value: loginAlerts, onChanged: (v) => setState(() => loginAlerts = v), title: const Text('Login Alerts')),
                ListTile(leading: const Icon(Icons.devices), title: const Text('Active Devices'), trailing: FilledButton(onPressed: () {}, child: const Text('View'))),
                ListTile(leading: const Icon(Icons.history), title: const Text('Login Activity'), trailing: FilledButton(onPressed: () {}, child: const Text('View'))),
              ],
            ),
          ),
          const SectionCard(
            title: 'Security Policy',
            child: Text('Use strong passwords, restrict staff permissions, rotate API credentials and review login activity regularly.'),
          ),
        ],
      ),
    );
  }
}
