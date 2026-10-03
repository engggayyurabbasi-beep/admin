import 'package:flutter/material.dart';

/// K Store Admin - Complete Remaining Modules
///
/// This file contains the detailed UI/workflows for the remaining Admin Panel
/// modules. It is intentionally self-contained and uses local in-memory state.
/// The existing app can connect these modules to its real database/API later.
///
/// Modules:
/// Orders, Customers, Offers & Coupons, Payments, Delivery & Shipping,
/// Custom Orders, Vendors, Resellers, Affiliates, Wallet & Rewards,
/// Inventory, Reports & Analytics, Marketing, Notifications,
/// API & Integrations, Staff & Roles, Settings, Account & Security.

class KStoreRemainingModules extends StatelessWidget {
  const KStoreRemainingModules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('K - Store Admin Modules')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _module(context, 'Orders', Icons.shopping_bag_outlined, const OrdersModule()),
          _module(context, 'Customers', Icons.people_outline, const CustomersModule()),
          _module(context, 'Offers & Coupons', Icons.local_offer_outlined, const OffersCouponsModule()),
          _module(context, 'Payments', Icons.payments_outlined, const PaymentsModule()),
          _module(context, 'Delivery & Shipping', Icons.local_shipping_outlined, const DeliveryShippingModule()),
          _module(context, 'Custom Orders', Icons.assignment_outlined, const CustomOrdersModule()),
          _module(context, 'Vendors', Icons.storefront_outlined, const VendorsModule()),
          _module(context, 'Resellers', Icons.handshake_outlined, const ResellersModule()),
          _module(context, 'Affiliates', Icons.share_outlined, const AffiliatesModule()),
          _module(context, 'Wallet & Rewards', Icons.account_balance_wallet_outlined, const WalletRewardsModule()),
          _module(context, 'Inventory', Icons.inventory_2_outlined, const InventoryModule()),
          _module(context, 'Reports & Analytics', Icons.analytics_outlined, const ReportsAnalyticsModule()),
          _module(context, 'Marketing', Icons.campaign_outlined, const MarketingModule()),
          _module(context, 'Notifications', Icons.notifications_outlined, const NotificationsModule()),
          _module(context, 'API & Integrations', Icons.integration_instructions_outlined, const ApiIntegrationsModule()),
          _module(context, 'Staff & Roles', Icons.badge_outlined, const StaffRolesModule()),
          _module(context, 'Settings', Icons.settings_outlined, const SettingsModule()),
          _module(context, 'Account & Security', Icons.security_outlined, const AccountSecurityModule()),
        ],
      ),
    );
  }

  Widget _module(BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }
}

class _ModuleScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;

  const _ModuleScaffold({
    required this.title,
    required this.body,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: body,
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _EmptyState({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(subtitle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.hint, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int maxLines;

  const _FormField({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard(this.label, this.value, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(child: Icon(icon)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: Theme.of(context).textTheme.titleLarge),
                  Text(label),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const _DataCard({
    required this.title,
    required this.subtitle,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        isThreeLine: true,
        trailing: actions.isEmpty
            ? const Icon(Icons.chevron_right)
            : Row(mainAxisSize: MainAxisSize.min, children: actions),
      ),
    );
  }
}

Future<void> _showEditor(
  BuildContext context, {
  required String title,
  required List<_FieldDef> fields,
  required VoidCallback onSave,
}) async {
  final controllers = fields.map((e) => TextEditingController()).toList();

  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var i = 0; i < fields.length; i++)
                  _FormField(
                    label: fields[i].label,
                    controller: controllers[i],
                    keyboardType: fields[i].keyboardType,
                    maxLines: fields[i].maxLines,
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              onSave();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );

  for (final controller in controllers) {
    controller.dispose();
  }
}

class _FieldDef {
  final String label;
  final TextInputType? keyboardType;
  final int maxLines;

  const _FieldDef(this.label, {this.keyboardType, this.maxLines = 1});
}

/* -------------------------------------------------------------------------- */
/* ORDERS                                                                     */
/* -------------------------------------------------------------------------- */

class OrdersModule extends StatefulWidget {
  const OrdersModule({super.key});

  @override
  State<OrdersModule> createState() => _OrdersModuleState();
}

class _OrdersModuleState extends State<OrdersModule> {
  final orders = <Map<String, String>>[
    {'id': '#KS1001', 'customer': 'Rahul Sharma', 'amount': '₹1,299', 'status': 'Pending', 'payment': 'COD'},
    {'id': '#KS1002', 'customer': 'Amit Khan', 'amount': '₹2,450', 'status': 'Processing', 'payment': 'Paid'},
    {'id': '#KS1003', 'customer': 'Neha Singh', 'amount': '₹899', 'status': 'Shipped', 'payment': 'Paid'},
  ];
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = orders.where((o) {
      final q = query.toLowerCase();
      return o.values.any((v) => v.toLowerCase().contains(q));
    }).toList();

    return _ModuleScaffold(
      title: 'Orders',
      actions: [
        IconButton(
          tooltip: 'Export',
          onPressed: () => _message(context, 'Order export prepared'),
          icon: const Icon(Icons.download_outlined),
        ),
      ],
      body: Column(
        children: [
          Wrap(
            spacing: 8,
            children: [
              _StatCard('Total Orders', '${orders.length}', Icons.shopping_bag),
              _StatCard('Pending', '${orders.where((o) => o['status'] == 'Pending').length}', Icons.pending_actions),
              _StatCard('Processing', '${orders.where((o) => o['status'] == 'Processing').length}', Icons.sync),
            ],
          ),
          _SearchBar(hint: 'Search order ID, customer, status...', onChanged: (v) => setState(() => query = v)),
          Expanded(
            child: filtered.isEmpty
                ? const _EmptyState(title: 'No orders found', subtitle: 'Try another search.', icon: Icons.shopping_bag_outlined)
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (_, i) {
                      final o = filtered[i];
                      return _DataCard(
                        title: '${o['id']} • ${o['customer']}',
                        subtitle: '${o['amount']} • ${o['payment']}\nStatus: ${o['status']}',
                        actions: [
                          PopupMenuButton<String>(
                            onSelected: (status) => setState(() => o['status'] = status),
                            itemBuilder: (_) => const [
                              PopupMenuItem(value: 'Pending', child: Text('Pending')),
                              PopupMenuItem(value: 'Confirmed', child: Text('Confirmed')),
                              PopupMenuItem(value: 'Processing', child: Text('Processing')),
                              PopupMenuItem(value: 'Packed', child: Text('Packed')),
                              PopupMenuItem(value: 'Shipped', child: Text('Shipped')),
                              PopupMenuItem(value: 'Delivered', child: Text('Delivered')),
                              PopupMenuItem(value: 'Cancelled', child: Text('Cancelled')),
                              PopupMenuItem(value: 'Returned', child: Text('Returned')),
                            ],
                            icon: const Icon(Icons.more_vert),
                          ),
                          IconButton(
                            onPressed: () => _message(context, 'Order details: ${o['id']}'),
                            icon: const Icon(Icons.visibility_outlined),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* CUSTOMERS                                                                  */
/* -------------------------------------------------------------------------- */

class CustomersModule extends StatefulWidget {
  const CustomersModule({super.key});

  @override
  State<CustomersModule> createState() => _CustomersModuleState();
}

class _CustomersModuleState extends State<CustomersModule> {
  final customers = <Map<String, String>>[
    {'name': 'Rahul Sharma', 'phone': '+91 98XXXXXX01', 'orders': '12', 'wallet': '₹450', 'status': 'Active'},
    {'name': 'Amit Khan', 'phone': '+91 98XXXXXX02', 'orders': '8', 'wallet': '₹210', 'status': 'Active'},
    {'name': 'Neha Singh', 'phone': '+91 98XXXXXX03', 'orders': '4', 'wallet': '₹90', 'status': 'Blocked'},
  ];
  String query = '';

  @override
  Widget build(BuildContext context) {
    final list = customers.where((c) => c.values.any((v) => v.toLowerCase().contains(query.toLowerCase()))).toList();
    return _ModuleScaffold(
      title: 'Customers',
      actions: [
        IconButton(onPressed: () => _message(context, 'Customer export prepared'), icon: const Icon(Icons.download_outlined)),
        IconButton(
          onPressed: () => _showEditor(
            context,
            title: 'Add Customer',
            fields: const [
              _FieldDef('Full Name'),
              _FieldDef('Mobile Number', keyboardType: TextInputType.phone),
              _FieldDef('Email'),
              _FieldDef('Address', maxLines: 3),
            ],
            onSave: () => _message(context, 'Customer added'),
          ),
          icon: const Icon(Icons.person_add_alt_1),
        ),
      ],
      body: Column(
        children: [
          _SearchBar(hint: 'Search customer, phone, email...', onChanged: (v) => setState(() => query = v)),
          Expanded(
            child: ListView(
              children: list.map((c) => _DataCard(
                title: c['name']!,
                subtitle: '${c['phone']} • ${c['orders']} orders\nWallet: ${c['wallet']} • ${c['status']}',
                actions: [
                  IconButton(onPressed: () => _message(context, 'Customer profile opened'), icon: const Icon(Icons.person_outline)),
                  IconButton(
                    onPressed: () => setState(() => c['status'] = c['status'] == 'Active' ? 'Blocked' : 'Active'),
                    icon: Icon(c['status'] == 'Active' ? Icons.block_outlined : Icons.check_circle_outline),
                  ),
                ],
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* OFFERS & COUPONS                                                           */
/* -------------------------------------------------------------------------- */

class OffersCouponsModule extends StatefulWidget {
  const OffersCouponsModule({super.key});

  @override
  State<OffersCouponsModule> createState() => _OffersCouponsModuleState();
}

class _OffersCouponsModuleState extends State<OffersCouponsModule> {
  final coupons = <Map<String, dynamic>>[
    {'code': 'WELCOME100', 'type': 'Flat', 'value': '₹100', 'min': '₹499', 'uses': '18/100', 'active': true},
    {'code': 'SAVE20', 'type': 'Percent', 'value': '20%', 'min': '₹999', 'uses': '42/500', 'active': true},
  ];

  void addCoupon() {
    _showEditor(
      context,
      title: 'Create Coupon',
      fields: const [
        _FieldDef('Coupon Code'),
        _FieldDef('Offer Type (Flat / Percent)'),
        _FieldDef('Discount Value'),
        _FieldDef('Minimum Order Value', keyboardType: TextInputType.number),
        _FieldDef('Maximum Discount', keyboardType: TextInputType.number),
        _FieldDef('Usage Limit', keyboardType: TextInputType.number),
        _FieldDef('Start Date'),
        _FieldDef('End Date'),
        _FieldDef('Applicable Categories'),
        _FieldDef('Applicable Products'),
      ],
      onSave: () => setState(() => coupons.add({
        'code': 'NEWCOUPON',
        'type': 'Percent',
        'value': '10%',
        'min': '₹499',
        'uses': '0/100',
        'active': true,
      })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Offers & Coupons',
      actions: [IconButton(onPressed: addCoupon, icon: const Icon(Icons.add))],
      body: ListView(
        children: [
          const _SectionTitle('Offer Tools'),
          _ActionTile('Coupons', 'Create, edit, expiry, usage limits and restrictions', Icons.local_offer, addCoupon),
          _ActionTile('Flash Sales', 'Schedule start/end time, products and sale price', Icons.flash_on, () => _message(context, 'Flash Sale manager opened')),
          _ActionTile('Free Gifts', 'Set qualifying products, quantity and gift SKU', Icons.card_giftcard, () => _message(context, 'Free Gift manager opened')),
          _ActionTile('Free Delivery', 'Minimum cart value, pin codes and exclusions', Icons.local_shipping, () => _message(context, 'Free Delivery rules opened')),
          const _SectionTitle('Coupons'),
          ...coupons.map((c) => _DataCard(
            title: c['code'] as String,
            subtitle: '${c['type']} • ${c['value']} • Min ${c['min']}\nUsage: ${c['uses']}',
            actions: [
              Switch(value: c['active'] as bool, onChanged: (v) => setState(() => c['active'] = v)),
              IconButton(onPressed: () => setState(() => coupons.remove(c)), icon: const Icon(Icons.delete_outline)),
            ],
          )),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* PAYMENTS                                                                   */
/* -------------------------------------------------------------------------- */

class PaymentsModule extends StatefulWidget {
  const PaymentsModule({super.key});

  @override
  State<PaymentsModule> createState() => _PaymentsModuleState();
}

class _PaymentsModuleState extends State<PaymentsModule> {
  bool razorpay = true;
  bool cod = true;
  bool upi = true;
  bool cards = true;
  bool netbanking = false;
  bool wallets = false;
  bool autoRefund = true;

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Payments',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionTitle('Payment Methods'),
          _SwitchTile(title: 'Razorpay', subtitle: 'Online payment gateway', value: razorpay, onChanged: (v) => setState(() => razorpay = v)),
          _SwitchTile(title: 'UPI', subtitle: 'UPI / Google Pay / PhonePe / Paytm', value: upi, onChanged: (v) => setState(() => upi = v)),
          _SwitchTile(title: 'Credit / Debit Cards', subtitle: 'Card payments', value: cards, onChanged: (v) => setState(() => cards = v)),
          _SwitchTile(title: 'Net Banking', subtitle: 'Bank payment option', value: netbanking, onChanged: (v) => setState(() => netbanking = v)),
          _SwitchTile(title: 'Wallets', subtitle: 'Supported payment wallets', value: wallets, onChanged: (v) => setState(() => wallets = v)),
          _SwitchTile(title: 'Cash on Delivery', subtitle: 'COD availability', value: cod, onChanged: (v) => setState(() => cod = v)),
          const _SectionTitle('Refund & Settlement'),
          _SwitchTile(title: 'Auto Refund', subtitle: 'Process eligible refunds automatically', value: autoRefund, onChanged: (v) => setState(() => autoRefund = v)),
          _ActionTile('Transaction History', 'View payment ID, order, gateway, amount, status and refund', Icons.receipt_long, () => _message(context, 'Transaction history opened')),
          _ActionTile('Settlement Reports', 'Gateway settlement and reconciliation', Icons.account_balance, () => _message(context, 'Settlement report opened')),
          _ActionTile('Payment Failure Logs', 'Failed, abandoned and retry payments', Icons.error_outline, () => _message(context, 'Failure logs opened')),
          FilledButton.icon(
            onPressed: () => _message(context, 'Payment settings saved'),
            icon: const Icon(Icons.save),
            label: const Text('Save Payment Settings'),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* DELIVERY & SHIPPING                                                        */
/* -------------------------------------------------------------------------- */

class DeliveryShippingModule extends StatefulWidget {
  const DeliveryShippingModule({super.key});

  @override
  State<DeliveryShippingModule> createState() => _DeliveryShippingModuleState();
}

class _DeliveryShippingModuleState extends State<DeliveryShippingModule> {
  bool freeDelivery = false;
  bool blockUnavailablePins = true;

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Delivery & Shipping',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionTitle('Courier Integrations'),
          _ActionTile('Shiprocket', 'API key, token, warehouses, courier selection and sync', Icons.local_shipping, () => _message(context, 'Shiprocket settings opened')),
          _ActionTile('Shipmojo', 'API credentials, serviceability and courier sync', Icons.local_shipping_outlined, () => _message(context, 'Shipmojo settings opened')),
          _ActionTile('Other Couriers', 'Add custom courier/API integration', Icons.add_business, () => _message(context, 'Custom courier setup opened')),
          const _SectionTitle('Delivery Rules'),
          _SwitchTile(title: 'Free Delivery', subtitle: 'Enable free delivery rules', value: freeDelivery, onChanged: (v) => setState(() => freeDelivery = v)),
          _SwitchTile(title: 'Block Unserviceable PIN Codes', subtitle: 'Prevent checkout for blocked areas', value: blockUnavailablePins, onChanged: (v) => setState(() => blockUnavailablePins = v)),
          _ActionTile('Delivery Charges by PIN Code', 'Set different delivery charges for pin-code ranges', Icons.pin_drop_outlined, () => _showEditor(context, title: 'PIN Code Rule', fields: const [
            _FieldDef('PIN Code / Range'),
            _FieldDef('Delivery Charge', keyboardType: TextInputType.number),
            _FieldDef('COD Charge', keyboardType: TextInputType.number),
            _FieldDef('Estimated Days'),
          ], onSave: () => _message(context, 'PIN rule saved'))),
          _ActionTile('Blocked PIN Codes', 'Manage non-delivery locations', Icons.location_off_outlined, () => _message(context, 'Blocked PIN codes opened')),
          _ActionTile('Shipping Zones', 'Create local, regional, national and special zones', Icons.map_outlined, () => _message(context, 'Shipping zones opened')),
          _ActionTile('Warehouses', 'Warehouse address, stock source and pickup settings', Icons.warehouse_outlined, () => _message(context, 'Warehouse manager opened')),
          _ActionTile('Tracking', 'AWB, courier, tracking URL and delivery events', Icons.track_changes, () => _message(context, 'Tracking manager opened')),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* CUSTOM ORDERS                                                              */
/* -------------------------------------------------------------------------- */

class CustomOrdersModule extends StatefulWidget {
  const CustomOrdersModule({super.key});

  @override
  State<CustomOrdersModule> createState() => _CustomOrdersModuleState();
}

class _CustomOrdersModuleState extends State<CustomOrdersModule> {
  final requests = <Map<String, String>>[
    {'id': 'CO-001', 'customer': 'Amit Khan', 'request': 'Bulk Herbal Combo', 'status': 'New'},
    {'id': 'CO-002', 'customer': 'Neha Singh', 'request': 'Custom Gift Pack', 'status': 'Quoted'},
  ];

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Custom Orders',
      actions: [
        IconButton(
          onPressed: () => _showEditor(context, title: 'New Custom Order', fields: const [
            _FieldDef('Customer Name'),
            _FieldDef('Phone'),
            _FieldDef('Product / Requirement', maxLines: 3),
            _FieldDef('Quantity'),
            _FieldDef('Target Budget'),
            _FieldDef('Delivery Requirement', maxLines: 3),
          ], onSave: () => _message(context, 'Custom order created')),
          icon: const Icon(Icons.add),
        ),
      ],
      body: ListView(
        children: [
          const _SectionTitle('Custom Order Workflow'),
          _ActionTile('New Requests', 'Capture customer requirements and attachments', Icons.inbox_outlined, () {}),
          _ActionTile('Quotation', 'Create quote, discount, tax and validity', Icons.request_quote_outlined, () {}),
          _ActionTile('Approval', 'Record customer approval/rejection', Icons.fact_check_outlined, () {}),
          _ActionTile('Convert to Order', 'Convert approved quote into normal order', Icons.transform, () {}),
          _ActionTile('Production / Packing', 'Track custom preparation stages', Icons.inventory_2_outlined, () {}),
          const _SectionTitle('Requests'),
          ...requests.map((r) => _DataCard(
            title: '${r['id']} • ${r['customer']}',
            subtitle: '${r['request']}\nStatus: ${r['status']}',
            actions: [
              PopupMenuButton<String>(
                onSelected: (v) => setState(() => r['status'] = v),
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'New', child: Text('New')),
                  PopupMenuItem(value: 'Contacted', child: Text('Contacted')),
                  PopupMenuItem(value: 'Quoted', child: Text('Quoted')),
                  PopupMenuItem(value: 'Approved', child: Text('Approved')),
                  PopupMenuItem(value: 'Rejected', child: Text('Rejected')),
                  PopupMenuItem(value: 'Converted', child: Text('Converted')),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* VENDORS                                                                    */
/* -------------------------------------------------------------------------- */

class VendorsModule extends StatefulWidget {
  const VendorsModule({super.key});

  @override
  State<VendorsModule> createState() => _VendorsModuleState();
}

class _VendorsModuleState extends State<VendorsModule> {
  final vendors = <Map<String, String>>[
    {'name': 'ABC Herbs Pvt Ltd', 'id': 'V-001', 'status': 'Active', 'products': '32'},
    {'name': 'Natural Wellness', 'id': 'V-002', 'status': 'Pending', 'products': '18'},
  ];

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Vendors',
      actions: [
        IconButton(
          onPressed: () => _showEditor(context, title: 'Add Vendor', fields: const [
            _FieldDef('Business Name'),
            _FieldDef('Owner Name'),
            _FieldDef('Mobile'),
            _FieldDef('Email'),
            _FieldDef('GSTIN'),
            _FieldDef('PAN'),
            _FieldDef('Address', maxLines: 3),
            _FieldDef('Bank Account'),
            _FieldDef('IFSC'),
          ], onSave: () => _message(context, 'Vendor added')),
          icon: const Icon(Icons.add_business),
        ),
      ],
      body: ListView(
        children: [
          const _SectionTitle('Vendor Management'),
          _ActionTile('Vendor Applications', 'Approve, reject and request documents', Icons.how_to_reg, () {}),
          _ActionTile('Vendor Products', 'Approve product listings and pricing', Icons.inventory_2_outlined, () {}),
          _ActionTile('Vendor Orders', 'Vendor-wise order assignment and fulfilment', Icons.shopping_bag_outlined, () {}),
          _ActionTile('Vendor Commission', 'Commission percentage, slabs and settlement', Icons.percent, () {}),
          _ActionTile('Vendor Payouts', 'Pending, processing, paid and failed withdrawals', Icons.payments_outlined, () {}),
          _ActionTile('Vendor Documents', 'KYC, GST, PAN, bank verification', Icons.folder_shared_outlined, () {}),
          const _SectionTitle('Vendors'),
          ...vendors.map((v) => _DataCard(
            title: '${v['name']} • ${v['id']}',
            subtitle: '${v['products']} products\nStatus: ${v['status']}',
            actions: [
              Switch(
                value: v['status'] == 'Active',
                onChanged: (value) => setState(() => v['status'] = value ? 'Active' : 'Inactive'),
              ),
              IconButton(onPressed: () => _message(context, 'Vendor details opened'), icon: const Icon(Icons.visibility_outlined)),
            ],
          )),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* RESELLERS                                                                  */
/* -------------------------------------------------------------------------- */

class ResellersModule extends StatefulWidget {
  const ResellersModule({super.key});

  @override
  State<ResellersModule> createState() => _ResellersModuleState();
}

class _ResellersModuleState extends State<ResellersModule> {
  final resellers = <Map<String, String>>[
    {'name': 'Amit Reseller', 'id': 'R-001', 'sales': '₹24,500', 'commission': '₹3,200', 'status': 'Active'},
    {'name': 'Sana Reseller', 'id': 'R-002', 'sales': '₹12,800', 'commission': '₹1,750', 'status': 'Active'},
  ];

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Resellers',
      actions: [
        IconButton(
          onPressed: () => _showEditor(context, title: 'Add Reseller', fields: const [
            _FieldDef('Name'),
            _FieldDef('Mobile'),
            _FieldDef('Email'),
            _FieldDef('Referral / Reseller Code'),
            _FieldDef('Commission %'),
            _FieldDef('Bank / UPI Details', maxLines: 2),
          ], onSave: () => _message(context, 'Reseller added')),
        ),
      ],
      body: ListView(
        children: [
          const _SectionTitle('Reseller Tools'),
          _ActionTile('Reseller Applications', 'Approve and onboard resellers', Icons.person_add_alt_1, () {}),
          _ActionTile('Pricing / Discount Slabs', 'Define reseller purchase prices', Icons.price_change_outlined, () {}),
          _ActionTile('Commission Rules', 'Set product/category/order commission', Icons.percent, () {}),
          _ActionTile('Reseller Orders', 'Track orders generated by each reseller', Icons.shopping_cart_outlined, () {}),
          _ActionTile('Withdrawals', 'Approve and process reseller payouts', Icons.account_balance_wallet_outlined, () {}),
          _ActionTile('Reseller Dashboard Settings', 'White-label dashboard permissions and branding', Icons.dashboard_customize_outlined, () {}),
          const _SectionTitle('Reseller List'),
          ...resellers.map((r) => _DataCard(
            title: '${r['name']} • ${r['id']}',
            subtitle: 'Sales: ${r['sales']} • Commission: ${r['commission']}\n${r['status']}',
            actions: [
              Switch(value: r['status'] == 'Active', onChanged: (v) => setState(() => r['status'] = v ? 'Active' : 'Inactive')),
              IconButton(onPressed: () => _message(context, 'Reseller details opened'), icon: const Icon(Icons.visibility_outlined)),
            ],
          )),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* AFFILIATES                                                                 */
/* -------------------------------------------------------------------------- */

class AffiliatesModule extends StatefulWidget {
  const AffiliatesModule({super.key});

  @override
  State<AffiliatesModule> createState() => _AffiliatesModuleState();
}

class _AffiliatesModuleState extends State<AffiliatesModule> {
  final affiliates = <Map<String, String>>[
    {'name': 'Health Creator', 'code': 'AFF1001', 'clicks': '1,250', 'orders': '86', 'earnings': '₹7,420'},
    {'name': 'Wellness Partner', 'code': 'AFF1002', 'clicks': '840', 'orders': '43', 'earnings': '₹3,180'},
  ];

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Affiliates',
      actions: [
        IconButton(
          onPressed: () => _showEditor(context, title: 'Add Affiliate', fields: const [
            _FieldDef('Name'),
            _FieldDef('Email'),
            _FieldDef('Mobile'),
            _FieldDef('Affiliate Code'),
            _FieldDef('Commission %'),
            _FieldDef('Landing Page / Tracking URL'),
          ], onSave: () => _message(context, 'Affiliate added')),
        ),
      ],
      body: ListView(
        children: [
          const _SectionTitle('Affiliate Program'),
          _ActionTile('Commission Rules', 'Product/category/order commission rules', Icons.percent, () {}),
          _ActionTile('Tracking Links', 'Create and manage campaign links', Icons.link, () {}),
          _ActionTile('Clicks & Conversions', 'Track clicks, carts, orders and conversion rate', Icons.insights, () {}),
          _ActionTile('Affiliate Payouts', 'Minimum payout, approval and payout history', Icons.payments, () {}),
          _ActionTile('Fraud Checks', 'Duplicate orders, self-referral and suspicious activity', Icons.gpp_maybe_outlined, () {}),
          const _SectionTitle('Affiliates'),
          ...affiliates.map((a) => _DataCard(
            title: '${a['name']} • ${a['code']}',
            subtitle: 'Clicks: ${a['clicks']} • Orders: ${a['orders']}\nEarnings: ${a['earnings']}',
            actions: [IconButton(onPressed: () => _message(context, 'Affiliate report opened'), icon: const Icon(Icons.analytics_outlined))],
          )),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* WALLET & REWARDS                                                           */
/* -------------------------------------------------------------------------- */

class WalletRewardsModule extends StatefulWidget {
  const WalletRewardsModule({super.key});

  @override
  State<WalletRewardsModule> createState() => _WalletRewardsModuleState();
}

class _WalletRewardsModuleState extends State<WalletRewardsModule> {
  bool wallet = true;
  bool points = true;
  bool referral = true;

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Wallet & Rewards',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SwitchTile(title: 'Customer Wallet', subtitle: 'Enable wallet balance and credits', value: wallet, onChanged: (v) => setState(() => wallet = v)),
          _SwitchTile(title: 'Reward Points', subtitle: 'Earn and redeem points', value: points, onChanged: (v) => setState(() => points = v)),
          _SwitchTile(title: 'Referral Rewards', subtitle: 'Reward successful referrals', value: referral, onChanged: (v) => setState(() => referral = v)),
          _ActionTile('Wallet Transactions', 'Credit, debit, refund, expiry and adjustment history', Icons.receipt_long, () {}),
          _ActionTile('Manual Wallet Adjustment', 'Admin credit/debit with reason and audit log', Icons.edit_note, () {}),
          _ActionTile('Points Rules', 'Order amount, category, product and bonus rules', Icons.stars_outlined, () {}),
          _ActionTile('Points Expiry', 'Set validity and expiry notifications', Icons.timer_outlined, () {}),
          _ActionTile('Referral Rules', 'Referrer reward, referee reward and limits', Icons.people_alt_outlined, () {}),
          _ActionTile('Withdrawal Rules', 'Minimum amount, verification and payout methods', Icons.account_balance_outlined, () {}),
          FilledButton(onPressed: () => _message(context, 'Wallet & reward settings saved'), child: const Text('Save Settings')),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* INVENTORY                                                                  */
/* -------------------------------------------------------------------------- */

class InventoryModule extends StatefulWidget {
  const InventoryModule({super.key});

  @override
  State<InventoryModule> createState() => _InventoryModuleState();
}

class _InventoryModuleState extends State<InventoryModule> {
  final stock = <Map<String, dynamic>>[
    {'name': 'Herbal Product A', 'sku': 'P001', 'stock': 50, 'reorder': 10},
    {'name': 'Unani Product B', 'sku': 'P002', 'stock': 7, 'reorder': 15},
    {'name': 'Hair Oil 200ml', 'sku': 'P003', 'stock': 0, 'reorder': 10},
  ];

  @override
  Widget build(BuildContext context) {
    final low = stock.where((p) => p['stock'] <= p['reorder']).length;
    return _ModuleScaffold(
      title: 'Inventory',
      actions: [
        IconButton(onPressed: () => _showEditor(context, title: 'Stock Adjustment', fields: const [
          _FieldDef('SKU'),
          _FieldDef('Quantity (+/-)', keyboardType: TextInputType.number),
          _FieldDef('Reason', maxLines: 2),
          _FieldDef('Warehouse'),
        ], onSave: () => _message(context, 'Stock adjustment saved')), icon: const Icon(Icons.add_box_outlined)),
      ],
      body: ListView(
        children: [
          Wrap(
            spacing: 8,
            children: [
              _StatCard('SKUs', '${stock.length}', Icons.inventory_2),
              _StatCard('Low Stock', '$low', Icons.warning_amber),
              _StatCard('Out of Stock', '${stock.where((p) => p['stock'] == 0).length}', Icons.remove_shopping_cart_outlined),
            ],
          ),
          const _SectionTitle('Inventory Tools'),
          _ActionTile('Stock Adjustment', 'Increase/decrease stock with reason and audit trail', Icons.edit_note, () {}),
          _ActionTile('Stock Transfer', 'Move stock between warehouses', Icons.swap_horiz, () {}),
          _ActionTile('Purchase Orders', 'Create purchase orders and receive stock', Icons.receipt_long, () {}),
          _ActionTile('Suppliers', 'Supplier master, contacts, products and payments', Icons.business, () {}),
          _ActionTile('Stock History', 'Every stock movement and adjustment', Icons.history, () {}),
          _ActionTile('Low Stock Alerts', 'Thresholds and notifications', Icons.notifications_active_outlined, () {}),
          _ActionTile('Inventory Valuation', 'Cost-based stock valuation', Icons.calculate_outlined, () {}),
          const _SectionTitle('Stock'),
          ...stock.map((p) => _DataCard(
            title: '${p['name']} • ${p['sku']}',
            subtitle: 'Stock: ${p['stock']} • Reorder level: ${p['reorder']}\n${p['stock'] == 0 ? 'OUT OF STOCK' : p['stock'] <= p['reorder'] ? 'LOW STOCK' : 'Healthy'}',
            actions: [
              IconButton(onPressed: () => _showEditor(context, title: 'Adjust ${p['sku']}', fields: const [
                _FieldDef('Quantity (+/-)', keyboardType: TextInputType.number),
                _FieldDef('Reason'),
              ], onSave: () => _message(context, 'Adjustment recorded')), icon: const Icon(Icons.edit_outlined)),
            ],
          )),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* REPORTS & ANALYTICS                                                        */
/* -------------------------------------------------------------------------- */

class ReportsAnalyticsModule extends StatelessWidget {
  const ReportsAnalyticsModule({super.key});

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Reports & Analytics',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Wrap(
            spacing: 8,
            children: const [
              _StatCard('Sales', '₹4.82L', Icons.currency_rupee),
              _StatCard('Orders', '1,248', Icons.shopping_bag),
              _StatCard('Customers', '842', Icons.people),
              _StatCard('AOV', '₹1,120', Icons.trending_up),
            ],
          ),
          const _SectionTitle('Sales Reports'),
          _ActionTile('Daily / Weekly / Monthly Sales', 'Revenue, orders, tax, discount and net sales', Icons.bar_chart, () {}),
          _ActionTile('Product Sales', 'Top products, quantity and revenue', Icons.inventory_2_outlined, () {}),
          _ActionTile('Category Sales', 'Category-wise revenue and units', Icons.category_outlined, () {}),
          _ActionTile('Customer Sales', 'Customer purchase and lifetime value', Icons.people_outline, () {}),
          _ActionTile('Coupon Report', 'Coupon usage, discount and ROI', Icons.local_offer_outlined, () {}),
          _ActionTile('Payment Report', 'Gateway-wise collections and failures', Icons.payments_outlined, () {}),
          _ActionTile('Shipping Report', 'Courier cost, delivery time and returns', Icons.local_shipping_outlined, () {}),
          _ActionTile('Profit / Margin', 'Sales, product cost, shipping and discounts', Icons.account_balance_outlined, () {}),
          _ActionTile('Inventory Report', 'Stock value, low stock and movement', Icons.inventory_outlined, () {}),
          _ActionTile('Affiliate / Reseller Report', 'Orders, commission and payouts', Icons.handshake_outlined, () {}),
          const _SectionTitle('Export'),
          _ActionTile('CSV / Excel Export', 'Export filtered reports', Icons.table_view, () {}),
          _ActionTile('PDF Report', 'Generate printable report', Icons.picture_as_pdf_outlined, () {}),
          _ActionTile('Scheduled Reports', 'Email selected reports on a schedule', Icons.schedule, () {}),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* MARKETING                                                                  */
/* -------------------------------------------------------------------------- */

class MarketingModule extends StatefulWidget {
  const MarketingModule({super.key});

  @override
  State<MarketingModule> createState() => _MarketingModuleState();
}

class _MarketingModuleState extends State<MarketingModule> {
  bool push = true;
  bool whatsapp = false;
  bool email = false;
  bool sms = false;

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Marketing',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionTitle('Campaign Channels'),
          _SwitchTile(title: 'Push Notifications', subtitle: 'App campaigns and alerts', value: push, onChanged: (v) => setState(() => push = v)),
          _SwitchTile(title: 'WhatsApp', subtitle: 'WhatsApp API campaigns', value: whatsapp, onChanged: (v) => setState(() => whatsapp = v)),
          _SwitchTile(title: 'Email', subtitle: 'Email campaigns and newsletters', value: email, onChanged: (v) => setState(() => email = v)),
          _SwitchTile(title: 'SMS', subtitle: 'SMS promotional campaigns', value: sms, onChanged: (v) => setState(() => sms = v)),
          const _SectionTitle('Campaign Management'),
          _ActionTile('Banners', 'Homepage banners, schedule, links and priority', Icons.photo_library_outlined, () {}),
          _ActionTile('Flash Sale', 'Sale products, price, stock and schedule', Icons.flash_on, () {}),
          _ActionTile('Free Gift', 'Gift rules and qualifying carts', Icons.card_giftcard, () {}),
          _ActionTile('Free Delivery', 'Minimum cart, zones and products', Icons.local_shipping, () {}),
          _ActionTile('Customer Segments', 'New, active, inactive, high-value and custom segments', Icons.groups_outlined, () {}),
          _ActionTile('Campaigns', 'Create, schedule, pause and measure campaigns', Icons.campaign_outlined, () {}),
          _ActionTile('Referral Program', 'Referral links and rewards', Icons.share_outlined, () {}),
          _ActionTile('Abandoned Cart', 'Reminder schedule and coupon incentives', Icons.shopping_cart_checkout, () {}),
          _ActionTile('UTM / Tracking', 'Campaign source, medium and campaign tracking', Icons.track_changes, () {}),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* NOTIFICATIONS                                                              */
/* -------------------------------------------------------------------------- */

class NotificationsModule extends StatefulWidget {
  const NotificationsModule({super.key});

  @override
  State<NotificationsModule> createState() => _NotificationsModuleState();
}

class _NotificationsModuleState extends State<NotificationsModule> {
  final templates = <Map<String, dynamic>>[
    {'name': 'Order Confirmed', 'channel': 'Push', 'active': true},
    {'name': 'Order Shipped', 'channel': 'Push + WhatsApp', 'active': true},
    {'name': 'Welcome', 'channel': 'Push', 'active': true},
  ];

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Notifications',
      actions: [
        IconButton(
          onPressed: () => _showEditor(context, title: 'Create Notification', fields: const [
            _FieldDef('Title'),
            _FieldDef('Message', maxLines: 4),
            _FieldDef('Audience / Segment'),
            _FieldDef('Channel'),
            _FieldDef('Schedule'),
            _FieldDef('Deep Link / Action URL'),
          ], onSave: () => _message(context, 'Notification scheduled')),
          icon: const Icon(Icons.add_alert),
        ),
      ],
      body: ListView(
        children: [
          const _SectionTitle('Notification Center'),
          _ActionTile('Send Notification', 'Send now or schedule for a customer segment', Icons.send_outlined, () {}),
          _ActionTile('Templates', 'Order, payment, shipping, account and promotional templates', Icons.article_outlined, () {}),
          _ActionTile('Automation Rules', 'Trigger notifications from events', Icons.auto_awesome_outlined, () {}),
          _ActionTile('Notification History', 'Delivery, failed, opened and clicked status', Icons.history, () {}),
          _ActionTile('Customer Preferences', 'Respect opt-in and channel preferences', Icons.tune, () {}),
          _ActionTile('Device Tokens', 'FCM token management and cleanup', Icons.devices_outlined, () {}),
          const _SectionTitle('Templates'),
          ...templates.map((t) => _DataCard(
            title: t['name'] as String,
            subtitle: '${t['channel']}\n${t['active'] ? 'Active' : 'Inactive'}',
            actions: [
              Switch(value: t['active'] as bool, onChanged: (v) => setState(() => t['active'] = v)),
            ],
          )),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* API & INTEGRATIONS                                                         */
/* -------------------------------------------------------------------------- */

class ApiIntegrationsModule extends StatefulWidget {
  const ApiIntegrationsModule({super.key});

  @override
  State<ApiIntegrationsModule> createState() => _ApiIntegrationsModuleState();
}

class _ApiIntegrationsModuleState extends State<ApiIntegrationsModule> {
  final integrations = <Map<String, dynamic>>[
    {'name': 'Razorpay', 'category': 'Payments', 'active': true},
    {'name': 'Shiprocket', 'category': 'Shipping', 'active': false},
    {'name': 'Shipmojo', 'category': 'Shipping', 'active': false},
    {'name': 'Firebase', 'category': 'Core', 'active': true},
    {'name': 'WhatsApp API', 'category': 'Communication', 'active': false},
  ];

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'API & Integrations',
      actions: [
        IconButton(onPressed: () => _message(context, 'API documentation opened'), icon: const Icon(Icons.menu_book_outlined)),
      ],
      body: ListView(
        children: [
          const _SectionTitle('Supported Integrations'),
          ...integrations.map((i) => _DataCard(
            title: i['name'] as String,
            subtitle: '${i['category']}\n${i['active'] ? 'Connected / Enabled' : 'Not connected'}',
            actions: [
              Switch(value: i['active'] as bool, onChanged: (v) => setState(() => i['active'] = v)),
              IconButton(onPressed: () => _message(context, '${i['name']} configuration opened'), icon: const Icon(Icons.settings_outlined)),
            ],
          )),
          const _SectionTitle('Developer Tools'),
          _ActionTile('API Keys', 'Create, rotate, revoke and restrict API keys', Icons.key_outlined, () {}),
          _ActionTile('Webhooks', 'Create endpoint, events, secret and retry policy', Icons.webhook_outlined, () {}),
          _ActionTile('API Logs', 'Requests, response code, latency and errors', Icons.receipt_long, () {}),
          _ActionTile('Integration Health', 'Connection test and service status', Icons.health_and_safety_outlined, () {}),
          _ActionTile('OAuth / Callback URLs', 'Configure authorized redirects and callbacks', Icons.link, () {}),
          _ActionTile('Secrets', 'Gateway credentials and encrypted configuration', Icons.lock_outline, () {}),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* STAFF & ROLES                                                              */
/* -------------------------------------------------------------------------- */

class StaffRolesModule extends StatefulWidget {
  const StaffRolesModule({super.key});

  @override
  State<StaffRolesModule> createState() => _StaffRolesModuleState();
}

class _StaffRolesModuleState extends State<StaffRolesModule> {
  final staff = <Map<String, String>>[
    {'name': 'Admin', 'email': 'admin@kstore.com', 'role': 'Super Admin', 'status': 'Active'},
    {'name': 'Order Manager', 'email': 'orders@kstore.com', 'role': 'Order Staff', 'status': 'Active'},
    {'name': 'Inventory Staff', 'email': 'inventory@kstore.com', 'role': 'Inventory', 'status': 'Active'},
  ];

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Staff & Roles',
      actions: [
        IconButton(
          onPressed: () => _showEditor(context, title: 'Add Staff', fields: const [
            _FieldDef('Name'),
            _FieldDef('Email'),
            _FieldDef('Mobile'),
            _FieldDef('Role'),
            _FieldDef('Login ID'),
          ], onSave: () => _message(context, 'Staff member added')),
        ),
      ],
      body: ListView(
        children: [
          const _SectionTitle('Access Control'),
          _ActionTile('Roles & Permissions', 'Granular permissions for every Admin module', Icons.admin_panel_settings_outlined, () {}),
          _ActionTile('Role Templates', 'Super Admin, Manager, Order, Inventory, Marketing, Support', Icons.badge_outlined, () {}),
          _ActionTile('Login IDs', 'Create, disable and reset staff accounts', Icons.login_outlined, () {}),
          _ActionTile('Session Control', 'Active sessions, logout all and device management', Icons.devices_outlined, () {}),
          _ActionTile('Audit Logs', 'Record important admin actions', Icons.history, () {}),
          const _SectionTitle('Staff'),
          ...staff.map((s) => _DataCard(
            title: s['name']!,
            subtitle: '${s['email']}\nRole: ${s['role']} • ${s['status']}',
            actions: [
              IconButton(onPressed: () => _message(context, 'Edit staff opened'), icon: const Icon(Icons.edit_outlined)),
              Switch(value: s['status'] == 'Active', onChanged: (v) => setState(() => s['status'] = v ? 'Active' : 'Inactive')),
            ],
          )),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* SETTINGS                                                                   */
/* -------------------------------------------------------------------------- */

class SettingsModule extends StatefulWidget {
  const SettingsModule({super.key});

  @override
  State<SettingsModule> createState() => _SettingsModuleState();
}

class _SettingsModuleState extends State<SettingsModule> {
  bool maintenance = false;
  bool guestCheckout = true;
  bool inventoryTracking = true;
  bool reviews = true;
  bool wishlist = true;
  bool reseller = true;
  bool vendor = true;

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Settings',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ActionTile('Store Information', 'Store name, logo, phone, email, address and legal details', Icons.store_outlined, () {}),
          _ActionTile('Branding', 'Logo, colors, favicon, tagline and app identity', Icons.palette_outlined, () {}),
          _ActionTile('Business Details', 'GST, PAN, invoice prefix, currency and tax defaults', Icons.business_outlined, () {}),
          _ActionTile('Order Settings', 'Order numbering, cancellation, return and confirmation rules', Icons.shopping_bag_outlined, () {}),
          _ActionTile('Checkout Settings', 'Guest checkout, address fields and checkout controls', Icons.shopping_cart_checkout, () {}),
          _ActionTile('Tax Settings', 'GST slabs, inclusive/exclusive pricing and tax rules', Icons.receipt_long, () {}),
          _ActionTile('Invoice Settings', 'Invoice template, prefix, terms and footer', Icons.description_outlined, () {}),
          _ActionTile('Email / SMS Settings', 'Sender identity and transactional communication', Icons.email_outlined, () {}),
          _ActionTile('Legal Pages', 'Privacy Policy, Terms, Refund, Shipping and About Us', Icons.gavel_outlined, () {}),
          _ActionTile('Backup & Data', 'Backup, restore, export and data retention', Icons.backup_outlined, () {}),
          const _SectionTitle('Feature Controls'),
          _SwitchTile(title: 'Maintenance Mode', subtitle: 'Temporarily disable customer checkout', value: maintenance, onChanged: (v) => setState(() => maintenance = v)),
          _SwitchTile(title: 'Guest Checkout', subtitle: 'Allow checkout without account', value: guestCheckout, onChanged: (v) => setState(() => guestCheckout = v)),
          _SwitchTile(title: 'Inventory Tracking', subtitle: 'Track stock against orders', value: inventoryTracking, onChanged: (v) => setState(() => inventoryTracking = v)),
          _SwitchTile(title: 'Product Reviews', subtitle: 'Allow customer reviews and ratings', value: reviews, onChanged: (v) => setState(() => reviews = v)),
          _SwitchTile(title: 'Wishlist', subtitle: 'Enable wishlist', value: wishlist, onChanged: (v) => setState(() => wishlist = v)),
          _SwitchTile(title: 'Vendor System', subtitle: 'Enable multi-vendor features', value: vendor, onChanged: (v) => setState(() => vendor = v)),
          _SwitchTile(title: 'Reseller System', subtitle: 'Enable reseller program', value: reseller, onChanged: (v) => setState(() => reseller = v)),
          FilledButton.icon(onPressed: () => _message(context, 'Settings saved'), icon: const Icon(Icons.save), label: const Text('Save Settings')),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* ACCOUNT & SECURITY                                                         */
/* -------------------------------------------------------------------------- */

class AccountSecurityModule extends StatefulWidget {
  const AccountSecurityModule({super.key});

  @override
  State<AccountSecurityModule> createState() => _AccountSecurityModuleState();
}

class _AccountSecurityModuleState extends State<AccountSecurityModule> {
  bool twoFactor = false;
  bool loginAlerts = true;
  bool sessionAlerts = true;

  @override
  Widget build(BuildContext context) {
    return _ModuleScaffold(
      title: 'Account & Security',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ActionTile('Profile', 'Name, email, mobile, photo and support details', Icons.person_outline, () {}),
          _ActionTile('Change Password', 'Change admin password and enforce policy', Icons.lock_outline, () {}),
          _SwitchTile(title: 'Two-Factor Authentication', subtitle: 'Require an additional verification step', value: twoFactor, onChanged: (v) => setState(() => twoFactor = v)),
          _SwitchTile(title: 'Login Alerts', subtitle: 'Alert on new admin login', value: loginAlerts, onChanged: (v) => setState(() => loginAlerts = v)),
          _SwitchTile(title: 'Session Alerts', subtitle: 'Alert on session/device changes', value: sessionAlerts, onChanged: (v) => setState(() => sessionAlerts = v)),
          _ActionTile('Active Sessions', 'View devices, IP/time information and logout sessions', Icons.devices_outlined, () {}),
          _ActionTile('Login Activity', 'Successful and failed login history', Icons.login_outlined, () {}),
          _ActionTile('Security Audit', 'Important account and permission changes', Icons.security_outlined, () {}),
          _ActionTile('Trusted Devices', 'Manage remembered devices', Icons.verified_user_outlined, () {}),
          _ActionTile('Recovery Options', 'Recovery email, phone and backup codes', Icons.restore_outlined, () {}),
          _ActionTile('Admin Logout', 'Sign out from this device', Icons.logout, () {}),
          FilledButton.icon(
            onPressed: () => _message(context, 'Security settings saved'),
            icon: const Icon(Icons.save),
            label: const Text('Save Security Settings'),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* SHARED SMALL WIDGETS                                                       */
/* -------------------------------------------------------------------------- */

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionTile(this.title, this.subtitle, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
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

void _message(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
