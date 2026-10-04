import 'package:flutter/material.dart';

/// K - Store Admin Panel
/// Professional Delivery & Shipping module.
///
/// IMPORTANT:
/// - This module is designed to replace the existing DeliveryShippingModule
///   inside k_store_complete_admin_system.dart.
/// - It uses the existing KStoreAdminData and ShippingAdmin classes.
/// - Courier/PIN/rule/label/branding data is currently kept in memory.
/// - Real Shiprocket/Shipmojo API calls and secure logo storage should be
///   connected to a backend before production.
/// - Shipping label branding is automatically selected from Order Source:
///     Direct   -> K - Store branding
///     Reseller -> reseller branding
///     Vendor   -> vendor branding
///     Affiliate -> K - Store branding
///
/// Integration note:
/// When this file is inserted into the main file, keep only the class/module
/// code and do not add a second Flutter import to the middle of the main file.

class DeliveryShippingModule extends StatefulWidget {
  const DeliveryShippingModule({super.key, required this.data});

  final KStoreAdminData data;

  @override
  State<DeliveryShippingModule> createState() =>
      _DeliveryShippingModuleState();
}

class _DeliveryShippingModuleState extends State<DeliveryShippingModule> {
  final Map<String, bool> rules = {
    'Free delivery threshold': true,
    'PIN code validation': true,
    'COD availability': true,
    'PIN-wise delivery charge': true,
    'Weight-wise delivery charge': true,
    'Remote area surcharge': true,
  };

  double freeDeliveryAbove = 999;
  double standardCharge = 49;
  double codCharge = 25;
  double handlingCharge = 0;

  final List<_ShippingPinRule> pinRules = [
    _ShippingPinRule(
      pin: '281001',
      city: 'Mathura',
      charge: 49,
      codCharge: 25,
      days: 3,
      blocked: false,
    ),
    _ShippingPinRule(
      pin: '282001',
      city: 'Agra',
      charge: 59,
      codCharge: 25,
      days: 3,
      blocked: false,
    ),
    _ShippingPinRule(
      pin: '110001',
      city: 'New Delhi',
      charge: 0,
      codCharge: 0,
      days: 2,
      blocked: false,
    ),
    _ShippingPinRule(
      pin: '999999',
      city: 'Blocked Area',
      charge: 0,
      codCharge: 0,
      days: 0,
      blocked: true,
    ),
  ];

  final List<_ShippingLabelBrand> brands = [
    _ShippingLabelBrand(
      source: 'Direct',
      name: 'K - Store',
      businessName: 'K - Store',
      phone: '+91 00000 00000',
      email: 'support@kstore.com',
      address: 'K - Store Warehouse',
      cityStatePin: 'India',
      website: 'www.kirzstore.com',
      logoText: 'K',
      logoUrl: '',
      whiteLabel: false,
      enabled: true,
    ),
    _ShippingLabelBrand(
      source: 'Reseller',
      name: 'Mohit Store',
      businessName: 'Mohit Store',
      phone: '+91 90000 00001',
      email: 'support@mohitstore.example',
      address: 'Main Market',
      cityStatePin: 'Mathura, UP - 281001',
      website: '',
      logoText: 'MS',
      logoUrl: '',
      whiteLabel: true,
      enabled: true,
    ),
    _ShippingLabelBrand(
      source: 'Vendor',
      name: 'KIRZ Wholesale',
      businessName: 'KIRZ Wholesale',
      phone: '+91 90000 00002',
      email: 'vendor@example.com',
      address: 'Industrial Area',
      cityStatePin: 'Mathura, UP - 281001',
      website: '',
      logoText: 'KW',
      logoUrl: '',
      whiteLabel: false,
      enabled: true,
    ),
  ];

  final List<_ShipmentLabelRecord> labels = [
    _ShipmentLabelRecord(
      orderId: 'ORD-1001',
      awb: 'AWB100001',
      customer: 'Rahul Kumar',
      phone: '+91 90000 10001',
      address: 'Mathura, Uttar Pradesh - 281001',
      payment: 'Prepaid',
      amount: 1299,
      weight: '1.20 kg',
      courier: 'Courier Karo',
      source: 'Direct',
      status: 'Generated',
    ),
    _ShipmentLabelRecord(
      orderId: 'ORD-1002',
      awb: 'AWB100002',
      customer: 'Aman Khan',
      phone: '+91 90000 10002',
      address: 'Agra, Uttar Pradesh - 282001',
      payment: 'COD',
      amount: 799,
      weight: '0.80 kg',
      courier: 'Shiprocket',
      source: 'Reseller',
      status: 'Generated',
    ),
  ];

  String labelSearch = '';
  String labelSourceFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          const SizedBox(height: 14),
          _summary(),
          const SizedBox(height: 14),
          _courierSection(),
          const SizedBox(height: 14),
          _rulesSection(),
          const SizedBox(height: 14),
          _quickActions(),
          const SizedBox(height: 14),
          _labelsSection(),
          const SizedBox(height: 14),
          _brandingSection(),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE91E63), Color(0xFF9C27B0)],
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(
            Icons.local_shipping_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery & Shipping',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Couriers, delivery rules, PIN serviceability and professional branded shipping labels.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        FilledButton.icon(
          onPressed: _showCourierDialog,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add Courier'),
        ),
      ],
    );
  }

  Widget _summary() {
    final activeCouriers =
        widget.data.shipping.where((item) => item.enabled).length;
    final blockedPins = pinRules.where((pin) => pin.blocked).length;
    final generatedLabels = labels.length;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _summaryCard(
          'Active Couriers',
          '$activeCouriers',
          Icons.local_shipping_rounded,
          const Color(0xFFE91E63),
        ),
        _summaryCard(
          'Serviceable PINs',
          '${pinRules.length - blockedPins}',
          Icons.location_on_rounded,
          const Color(0xFF7B1FA2),
        ),
        _summaryCard(
          'Blocked PINs',
          '$blockedPins',
          Icons.block_rounded,
          const Color(0xFFD32F2F),
        ),
        _summaryCard(
          'Labels Generated',
          '$generatedLabels',
          Icons.print_rounded,
          const Color(0xFF00897B),
        ),
      ],
    );
  }

  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return SizedBox(
      width: 205,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: const Color(0xFFE8E8EC)),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color.withOpacity(.10),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
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

  Widget _courierSection() {
    return _section(
      'Courier Management',
      'Manage courier accounts, priority and connection status.',
      Icons.local_shipping_rounded,
      Column(
        children: [
          ...widget.data.shipping.map(_courierCard),
          if (widget.data.shipping.isEmpty)
            const Padding(
              padding: EdgeInsets.all(18),
              child: Text('No courier has been added yet.'),
            ),
        ],
      ),
    );
  }

  Widget _courierCard(ShippingAdmin courier) {
    final connected =
        courier.status.toLowerCase().contains('configured') ||
            courier.status.toLowerCase().contains('connected');

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Color(0xFFE8E8EC)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.local_shipping_rounded,
                    color: Color(0xFFFFA000),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courier.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '${courier.type} • ${connected ? 'Configured' : courier.status}',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: courier.enabled,
                  activeThumbColor: const Color(0xFFE91E63),
                  onChanged: (value) {
                    setState(() => courier.enabled = value);
                  },
                ),
              ],
            ),
            const Divider(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _showCourierDialog(item: courier),
                  icon: const Icon(Icons.settings_outlined),
                  label: const Text('Configure'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _testCourier(courier),
                  icon: const Icon(Icons.bolt_rounded),
                  label: const Text('Test Connection'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _deleteCourier(courier),
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _rulesSection() {
    return _section(
      'Delivery Rules',
      'These rules control how delivery charges and serviceability are calculated.',
      Icons.rule_rounded,
      Column(
        children: [
          _moneyRule(
            'Free delivery above',
            freeDeliveryAbove,
            (value) => setState(() => freeDeliveryAbove = value),
          ),
          _moneyRule(
            'Standard delivery charge',
            standardCharge,
            (value) => setState(() => standardCharge = value),
          ),
          _moneyRule(
            'COD extra charge',
            codCharge,
            (value) => setState(() => codCharge = value),
          ),
          _moneyRule(
            'Handling charge',
            handlingCharge,
            (value) => setState(() => handlingCharge = value),
          ),
          const Divider(),
          ...rules.entries.map(
            (entry) => SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                entry.key,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                entry.value ? 'Enabled' : 'Disabled',
              ),
              value: entry.value,
              activeThumbColor: const Color(0xFFE91E63),
              onChanged: (value) {
                setState(() => rules[entry.key] = value);
              },
            ),
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Delivery charge calculator',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: const Text(
              'Test the same rule set used for checkout calculations.',
            ),
            trailing: FilledButton(
              onPressed: _showCalculator,
              child: const Text('Calculate'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moneyRule(
    String title,
    double value,
    ValueChanged<double> onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(
        Icons.currency_rupee_rounded,
        color: Color(0xFFE91E63),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      trailing: Text(
        '₹${value.toStringAsFixed(0)}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
      onTap: () async {
        final controller = TextEditingController(
          text: value.toStringAsFixed(0),
        );
        final result = await showDialog<double>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixText: '₹ ',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    double.tryParse(controller.text.trim()),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
        controller.dispose();

        if (result != null && result >= 0) {
          onChanged(result);
        }
      },
    );
  }

  Widget _quickActions() {
    return _section(
      'Shipping Operations',
      'Open the operational tools used by the dispatch team.',
      Icons.dashboard_customize_rounded,
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _action(
            'PIN Codes',
            Icons.pin_drop_rounded,
            _showPinManager,
          ),
          _action(
            'Blocked PINs',
            Icons.block_rounded,
            () => _showPinManager(initialBlocked: true),
          ),
          _action(
            'Charges',
            Icons.currency_rupee_rounded,
            _showShippingCharges,
          ),
          _action(
            'Shipping Labels',
            Icons.print_rounded,
            _showCreateLabelDialog,
          ),
          _action(
            'Branding',
            Icons.branding_watermark_rounded,
            _showBrandingManager,
          ),
        ],
      ),
    );
  }

  Widget _action(
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(title),
    );
  }

  Widget _labelsSection() {
    final filtered = labels.where((label) {
      final sourceMatch = labelSourceFilter == 'All' ||
          label.source == labelSourceFilter;
      final query = labelSearch.trim().toLowerCase();
      final queryMatch = query.isEmpty ||
          label.orderId.toLowerCase().contains(query) ||
          label.awb.toLowerCase().contains(query) ||
          label.customer.toLowerCase().contains(query);
      return sourceMatch && queryMatch;
    }).toList();

    return _section(
      'Professional Shipping Labels',
      'Branding changes automatically according to the order source.',
      Icons.print_rounded,
      Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search order, AWB or customer...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() => labelSearch = value);
                  },
                ),
              ),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: labelSourceFilter,
                items: const [
                  DropdownMenuItem(value: 'All', child: Text('All')),
                  DropdownMenuItem(
                    value: 'Direct',
                    child: Text('Direct'),
                  ),
                  DropdownMenuItem(
                    value: 'Reseller',
                    child: Text('Reseller'),
                  ),
                  DropdownMenuItem(
                    value: 'Vendor',
                    child: Text('Vendor'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => labelSourceFilter = value);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...filtered.map(_labelListCard),
          if (filtered.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text('No shipping labels found.'),
            ),
        ],
      ),
    );
  }

  Widget _labelListCard(_ShipmentLabelRecord label) {
    final brand = _brandFor(label.source);

    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE8E8EC)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 7,
        ),
        leading: _brandLogo(brand, 46),
        title: Text(
          '${label.orderId} • ${label.awb}',
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Text(
          '${label.customer} • ${label.source} • ${label.courier}',
        ),
        trailing: Wrap(
          spacing: 5,
          children: [
            IconButton(
              tooltip: 'Preview',
              onPressed: () => _showLabelPreview(label),
              icon: const Icon(Icons.visibility_outlined),
            ),
            IconButton(
              tooltip: 'Edit',
              onPressed: () => _showCreateLabelDialog(item: label),
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _brandingSection() {
    return _section(
      'Label Branding',
      'Configure which business identity appears on each shipment label.',
      Icons.branding_watermark_rounded,
      Column(
        children: brands.map((brand) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: _brandLogo(brand, 46),
            title: Text(
              '${brand.source} • ${brand.name}',
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              brand.whiteLabel
                  ? 'White-label branding enabled'
                  : 'K - Store identity available',
            ),
            trailing: Wrap(
              spacing: 5,
              children: [
                Switch(
                  value: brand.enabled,
                  activeThumbColor: const Color(0xFFE91E63),
                  onChanged: (value) {
                    setState(() => brand.enabled = value);
                  },
                ),
                IconButton(
                  tooltip: 'Edit branding',
                  onPressed: () => _showBrandingDialog(brand),
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _section(
    String title,
    String subtitle,
    IconData icon,
    Widget child,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8E8EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE4EC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFFE91E63),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          child,
        ],
      ),
    );
  }

  Widget _brandLogo(_ShippingLabelBrand brand, double size) {
    if (brand.logoUrl.trim().isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          brand.logoUrl,
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _logoFallback(brand, size),
        ),
      );
    }
    return _logoFallback(brand, size);
  }

  Widget _logoFallback(_ShippingLabelBrand brand, double size) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE91E63), Color(0xFF9C27B0)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        brand.logoText.isEmpty ? brand.name.substring(0, 1) : brand.logoText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  _ShippingLabelBrand _brandFor(String source) {
    final brand = brands.where((item) => item.source == source).firstOrNull;
    if (brand != null && brand.enabled) {
      return brand;
    }

    return brands.first;
  }

  Future<void> _showCourierDialog({
    ShippingAdmin? item,
  }) async {
    final id = TextEditingController(
      text: item?.id ?? 'S${DateTime.now().millisecondsSinceEpoch}',
    );
    final name = TextEditingController(text: item?.name ?? '');
    final type = TextEditingController(text: item?.type ?? 'API');
    String mode = item?.status == 'Connected' ? 'Live' : 'Test';

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            item == null ? 'Add Courier' : 'Configure ${item.name}',
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: id,
                  decoration: const InputDecoration(
                    labelText: 'Courier ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: 'Courier Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: type,
                  decoration: const InputDecoration(
                    labelText: 'Integration Type',
                    hintText: 'API / Manual',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: mode,
                  decoration: const InputDecoration(
                    labelText: 'Environment',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Test',
                      child: Text('Test'),
                    ),
                    DropdownMenuItem(
                      value: 'Live',
                      child: Text('Live'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setDialogState(() => mode = value);
                    }
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'API keys and secrets should be stored on a secure backend.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (name.text.trim().isEmpty) return;

                setState(() {
                  if (item == null) {
                    widget.data.shipping.add(
                      ShippingAdmin(
                        id.text.trim(),
                        name.text.trim(),
                        type.text.trim().isEmpty
                            ? 'API'
                            : type.text.trim(),
                        'Configured',
                        true,
                      ),
                    );
                  } else {
                    item.id = id.text.trim();
                    item.name = name.text.trim();
                    item.type = type.text.trim().isEmpty
                        ? 'API'
                        : type.text.trim();
                    item.status = 'Configured';
                  }
                });

                Navigator.pop(context);
                _snack('${name.text.trim()} saved in $mode mode.');
              },
              child: const Text('Save Courier'),
            ),
          ],
        ),
      ),
    );

    id.dispose();
    name.dispose();
    type.dispose();
  }

  void _testCourier(ShippingAdmin courier) {
    setState(() {
      courier.status = 'Connected';
    });

    _snack(
      '${courier.name}: connection test passed locally. '
      'Real API verification requires backend credentials.',
    );
  }

  Future<void> _deleteCourier(ShippingAdmin courier) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Courier?'),
        content: Text(
          'Remove ${courier.name} from the admin shipping configuration?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (ok == true) {
      setState(() => widget.data.shipping.remove(courier));
    }
  }

  Future<void> _showPinManager({
    bool initialBlocked = false,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('PIN Code Manager'),
            content: SizedBox(
              width: 600,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('All'),
                        selected: !initialBlocked,
                        onSelected: (_) {
                          setDialogState(() => initialBlocked = false);
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Blocked'),
                        selected: initialBlocked,
                        onSelected: (_) {
                          setDialogState(() => initialBlocked = true);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 260,
                    child: ListView(
                      children: pinRules
                          .where(
                            (pin) =>
                                !initialBlocked || pin.blocked,
                          )
                          .map(
                            (pin) => ListTile(
                              leading: Icon(
                                pin.blocked
                                    ? Icons.block
                                    : Icons.location_on,
                                color: pin.blocked
                                    ? Colors.red
                                    : const Color(0xFFE91E63),
                              ),
                              title: Text(
                                '${pin.pin} • ${pin.city}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                pin.blocked
                                    ? 'Delivery blocked'
                                    : '₹${pin.charge.toStringAsFixed(0)} • ${pin.days} days',
                              ),
                              trailing: Switch(
                                value: !pin.blocked,
                                onChanged: (value) {
                                  setState(
                                    () => pin.blocked = !value,
                                  );
                                  setDialogState(() {});
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showAddPinDialog();
                },
                icon: const Icon(Icons.add),
                label: const Text('Add PIN'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showAddPinDialog() async {
    final pin = TextEditingController();
    final city = TextEditingController();
    final charge = TextEditingController(text: standardCharge.toStringAsFixed(0));
    final cod = TextEditingController(text: codCharge.toStringAsFixed(0));
    final days = TextEditingController(text: '3');

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add PIN Code Rule'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _input(pin, 'PIN Code'),
              const SizedBox(height: 8),
              _input(city, 'City'),
              const SizedBox(height: 8),
              _input(charge, 'Delivery Charge'),
              const SizedBox(height: 8),
              _input(cod, 'COD Charge'),
              const SizedBox(height: 8),
              _input(days, 'Estimated Days'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final parsedCharge =
                  double.tryParse(charge.text.trim()) ?? standardCharge;
              final parsedCod =
                  double.tryParse(cod.text.trim()) ?? codCharge;
              final parsedDays =
                  int.tryParse(days.text.trim()) ?? 3;

              if (pin.text.trim().length == 6 &&
                  city.text.trim().isNotEmpty) {
                setState(() {
                  pinRules.add(
                    _ShippingPinRule(
                      pin: pin.text.trim(),
                      city: city.text.trim(),
                      charge: parsedCharge,
                      codCharge: parsedCod,
                      days: parsedDays,
                      blocked: false,
                    ),
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save PIN'),
          ),
        ],
      ),
    );

    pin.dispose();
    city.dispose();
    charge.dispose();
    cod.dispose();
    days.dispose();
  }

  Widget _input(
    TextEditingController controller,
    String label,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Future<void> _showShippingCharges() async {
    final subtotal = TextEditingController(text: '750');
    final pin = TextEditingController(text: '281001');
    bool cod = true;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Shipping Charge Calculator'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: subtotal,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Order subtotal',
                  prefixText: '₹ ',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: pin,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'PIN Code',
                ),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('COD'),
                value: cod,
                onChanged: (value) {
                  setDialogState(() => cod = value);
                },
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
                final amount =
                    double.tryParse(subtotal.text.trim()) ?? 0;
                final rule = pinRules
                    .where((item) => item.pin == pin.text.trim())
                    .firstOrNull;

                if (rule?.blocked == true) {
                  Navigator.pop(context);
                  _snack('This PIN is blocked for delivery.');
                  return;
                }

                var delivery = amount >= freeDeliveryAbove
                    ? 0
                    : rule?.charge ?? standardCharge;

                if (cod && rules['COD availability'] == true) {
                  delivery += rule?.codCharge ?? codCharge;
                }

                delivery += handlingCharge;

                Navigator.pop(context);
                _snack(
                  'Calculated delivery charge: ₹${delivery.toStringAsFixed(0)}',
                );
              },
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );

    subtotal.dispose();
    pin.dispose();
  }

  Future<void> _showCalculator() => _showShippingCharges();

  Future<void> _showCreateLabelDialog({
    _ShipmentLabelRecord? item,
  }) async {
    final order = TextEditingController(
      text: item?.orderId ?? widget.data.orders.firstOrNull?.id ?? '',
    );
    final awb = TextEditingController(
      text: item?.awb ??
          'AWB${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
    );
    final customer = TextEditingController(
      text: item?.customer ?? widget.data.orders.firstOrNull?.customer ?? '',
    );
    final phone = TextEditingController(
      text: item?.phone ?? '',
    );
    final address = TextEditingController(
      text: item?.address ?? '',
    );
    final amount = TextEditingController(
      text: item?.amount.toStringAsFixed(0) ?? '0',
    );
    final weight = TextEditingController(
      text: item?.weight ?? '1.00 kg',
    );

    String source = item?.source ?? 'Direct';
    String payment = item?.payment ?? 'Prepaid';
    String courier = item?.courier ??
        (widget.data.shipping.isNotEmpty
            ? widget.data.shipping.first.name
            : 'Courier Karo');

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            item == null
                ? 'Generate Professional Shipping Label'
                : 'Edit Shipping Label',
          ),
          content: SizedBox(
            width: 620,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _input(order, 'Order ID'),
                  const SizedBox(height: 8),
                  _input(awb, 'AWB Number'),
                  const SizedBox(height: 8),
                  _input(customer, 'Customer Name'),
                  const SizedBox(height: 8),
                  _input(phone, 'Customer Mobile'),
                  const SizedBox(height: 8),
                  _input(address, 'Delivery Address'),
                  const SizedBox(height: 8),
                  _input(amount, 'Order Amount'),
                  const SizedBox(height: 8),
                  _input(weight, 'Package Weight'),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: source,
                    decoration: const InputDecoration(
                      labelText: 'Order Source',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Direct',
                        child: Text('Direct → K - Store branding'),
                      ),
                      DropdownMenuItem(
                        value: 'Reseller',
                        child: Text('Reseller → Reseller branding'),
                      ),
                      DropdownMenuItem(
                        value: 'Vendor',
                        child: Text('Vendor → Vendor branding'),
                      ),
                      DropdownMenuItem(
                        value: 'Affiliate',
                        child: Text('Affiliate → K - Store branding'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() => source = value);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: payment,
                    decoration: const InputDecoration(
                      labelText: 'Payment',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Prepaid',
                        child: Text('Prepaid'),
                      ),
                      DropdownMenuItem(
                        value: 'COD',
                        child: Text('Cash on Delivery'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() => payment = value);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: courier,
                    decoration: const InputDecoration(
                      labelText: 'Courier',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      ...widget.data.shipping.map(
                        (item) => DropdownMenuItem(
                          value: item.name,
                          child: Text(item.name),
                        ),
                      ),
                      if (!widget.data.shipping.any(
                        (item) => item.name == courier,
                      ))
                        DropdownMenuItem(
                          value: courier,
                          child: Text(courier),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() => courier = value);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  _brandingHint(source),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton.icon(
              onPressed: () {
                final parsedAmount =
                    double.tryParse(amount.text.trim()) ?? 0;

                final record = _ShipmentLabelRecord(
                  orderId: order.text.trim(),
                  awb: awb.text.trim(),
                  customer: customer.text.trim(),
                  phone: phone.text.trim(),
                  address: address.text.trim(),
                  payment: payment,
                  amount: parsedAmount,
                  weight: weight.text.trim(),
                  courier: courier,
                  source: source,
                  status: 'Generated',
                );

                setState(() {
                  if (item == null) {
                    labels.insert(0, record);
                  } else {
                    final index = labels.indexOf(item);
                    if (index >= 0) {
                      labels[index] = record;
                    }
                  }
                });

                Navigator.pop(context);
                _showLabelPreview(record);
              },
              icon: const Icon(Icons.print_rounded),
              label: const Text('Generate Label'),
            ),
          ],
        ),
      ),
    );

    order.dispose();
    awb.dispose();
    customer.dispose();
    phone.dispose();
    address.dispose();
    amount.dispose();
    weight.dispose();
  }

  Widget _brandingHint(String source) {
    final brand = _brandFor(source);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _brandLogo(brand, 42),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Label branding: ${brand.name}\n'
              '${brand.whiteLabel ? 'White-label enabled' : 'K - Store identity available'}',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showLabelPreview(_ShipmentLabelRecord label) async {
    final brand = _brandFor(label.source);

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(18),
        child: SizedBox(
          width: 620,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 10, 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Shipping Label Preview',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: _shippingLabel(label, brand),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _snack(
                            'Label ready for printing. Connect the print/PDF service for physical output.',
                          );
                        },
                        icon: const Icon(Icons.print_rounded),
                        label: const Text('Print / Export'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _snack('Shipping label marked as generated.');
                        },
                        icon: const Icon(Icons.check_rounded),
                        label: const Text('Done'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shippingLabel(
    _ShipmentLabelRecord label,
    _ShippingLabelBrand brand,
  ) {
    final isCod = label.payment == 'COD';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black87, width: 1.3),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFCE4EC), Color(0xFFF3E5F5)],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _brandLogo(brand, 62),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brand.businessName,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        brand.address,
                        style: const TextStyle(fontSize: 11),
                      ),
                      Text(
                        '${brand.cityStatePin} • ${brand.phone}',
                        style: const TextStyle(fontSize: 11),
                      ),
                      if (brand.website.isNotEmpty)
                        Text(
                          brand.website,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                _sourceBadge(label.source),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SHIP TO',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        label.customer,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        label.address.isEmpty
                            ? 'Delivery address not entered'
                            : label.address,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        label.phone,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isCod
                          ? const Color(0xFFFFF3E0)
                          : const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCod ? 'COD' : 'PREPAID',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: isCod
                                ? const Color(0xFFE65100)
                                : const Color(0xFF2E7D32),
                          ),
                        ),
                        if (isCod) ...[
                          const SizedBox(height: 5),
                          Text(
                            'Collect ₹${label.amount.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Wrap(
              spacing: 20,
              runSpacing: 10,
              children: [
                _labelInfo('ORDER ID', label.orderId),
                _labelInfo('AWB', label.awb),
                _labelInfo('COURIER', label.courier),
                _labelInfo('WEIGHT', label.weight),
                _labelInfo('SOURCE', label.source),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Container(
                  height: 58,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black54),
                  ),
                  child: Text(
                    _barcodeText(label.awb),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  label.awb,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: Colors.black87,
            child: const Text(
              'Handle with care • Customer delivery package • K - Store Shipping',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sourceBadge(String source) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Text(
        source.toUpperCase(),
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _labelInfo(String title, String value) {
    return SizedBox(
      width: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 9,
              color: Colors.black54,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  String _barcodeText(String awb) {
    final clean = awb.replaceAll(RegExp(r'[^A-Za-z0-9]'), '');
    if (clean.isEmpty) return '||||||||||||||||';
    return '|| $clean |||||| $clean ||';
  }

  Future<void> _showBrandingManager() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Shipping Label Branding'),
        content: SizedBox(
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: brands
                .map(
                  (brand) => ListTile(
                    leading: _brandLogo(brand, 42),
                    title: Text(
                      '${brand.source} • ${brand.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Text(
                      brand.whiteLabel
                          ? 'Reseller white-label'
                          : 'K - Store managed branding',
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showBrandingDialog(brand);
                      },
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _showBrandingDialog(
    _ShippingLabelBrand brand,
  ) async {
    final name = TextEditingController(text: brand.name);
    final business = TextEditingController(text: brand.businessName);
    final phone = TextEditingController(text: brand.phone);
    final email = TextEditingController(text: brand.email);
    final address = TextEditingController(text: brand.address);
    final city = TextEditingController(text: brand.cityStatePin);
    final website = TextEditingController(text: brand.website);
    final logoText = TextEditingController(text: brand.logoText);
    final logoUrl = TextEditingController(text: brand.logoUrl);
    bool whiteLabel = brand.whiteLabel;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('${brand.source} Label Branding'),
          content: SizedBox(
            width: 620,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _input(name, 'Display Name'),
                  const SizedBox(height: 8),
                  _input(business, 'Business Name'),
                  const SizedBox(height: 8),
                  _input(phone, 'Phone'),
                  const SizedBox(height: 8),
                  _input(email, 'Email'),
                  const SizedBox(height: 8),
                  _input(address, 'Address'),
                  const SizedBox(height: 8),
                  _input(city, 'City / State / PIN'),
                  const SizedBox(height: 8),
                  _input(website, 'Website'),
                  const SizedBox(height: 8),
                  _input(logoText, 'Logo Text / Initials'),
                  const SizedBox(height: 8),
                  _input(
                    logoUrl,
                    'Logo URL',
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'White-label branding',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    subtitle: const Text(
                      'Show reseller/vendor identity as the primary label brand.',
                    ),
                    value: whiteLabel,
                    activeThumbColor: const Color(0xFFE91E63),
                    onChanged: (value) {
                      setDialogState(() => whiteLabel = value);
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  brand.name = name.text.trim();
                  brand.businessName = business.text.trim();
                  brand.phone = phone.text.trim();
                  brand.email = email.text.trim();
                  brand.address = address.text.trim();
                  brand.cityStatePin = city.text.trim();
                  brand.website = website.text.trim();
                  brand.logoText = logoText.text.trim();
                  brand.logoUrl = logoUrl.text.trim();
                  brand.whiteLabel = whiteLabel;
                });
                Navigator.pop(context);
              },
              child: const Text('Save Branding'),
            ),
          ],
        ),
      ),
    );

    name.dispose();
    business.dispose();
    phone.dispose();
    email.dispose();
    address.dispose();
    city.dispose();
    website.dispose();
    logoText.dispose();
    logoUrl.dispose();
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _ShippingPinRule {
  _ShippingPinRule({
    required this.pin,
    required this.city,
    required this.charge,
    required this.codCharge,
    required this.days,
    required this.blocked,
  });

  String pin;
  String city;
  double charge;
  double codCharge;
  int days;
  bool blocked;
}

class _ShippingLabelBrand {
  _ShippingLabelBrand({
    required this.source,
    required this.name,
    required this.businessName,
    required this.phone,
    required this.email,
    required this.address,
    required this.cityStatePin,
    required this.website,
    required this.logoText,
    required this.logoUrl,
    required this.whiteLabel,
    required this.enabled,
  });

  final String source;
  String name;
  String businessName;
  String phone;
  String email;
  String address;
  String cityStatePin;
  String website;
  String logoText;
  String logoUrl;
  bool whiteLabel;
  bool enabled;
}

class _ShipmentLabelRecord {
  _ShipmentLabelRecord({
    required this.orderId,
    required this.awb,
    required this.customer,
    required this.phone,
    required this.address,
    required this.payment,
    required this.amount,
    required this.weight,
    required this.courier,
    required this.source,
    required this.status,
  });

  String orderId;
  String awb;
  String customer;
  String phone;
  String address;
  String payment;
  double amount;
  String weight;
  String courier;
  String source;
  String status;
}
