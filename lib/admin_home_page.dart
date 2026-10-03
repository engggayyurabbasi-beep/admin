import 'package:flutter/material.dart';

/// K - Store Admin: single-file complete module dashboard.
/// All screens are self-contained and use local in-memory state.
/// Connect AdminStore methods to Firebase/REST API for permanent multi-device data.

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});
  @override State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final store = AdminStore();
  int index = 0;

  final menus = const [
    ['Dashboard', Icons.dashboard_outlined],
    ['Categories', Icons.category_outlined],
    ['Orders', Icons.shopping_bag_outlined],
    ['Customers', Icons.people_outline],
    ['Offers & Coupons', Icons.local_offer_outlined],
    ['Payments', Icons.payments_outlined],
    ['Delivery & Shipping', Icons.local_shipping_outlined],
    ['Custom Orders', Icons.assignment_outlined],
    ['Vendors', Icons.storefront_outlined],
    ['Resellers', Icons.handshake_outlined],
    ['Affiliates', Icons.share_outlined],
    ['Wallet & Rewards', Icons.account_balance_wallet_outlined],
    ['Inventory', Icons.inventory_2_outlined],
    ['Reports & Analysis', Icons.bar_chart_outlined],
    ['Marketing', Icons.campaign_outlined],
    ['Notifications', Icons.notifications_none_outlined],
    ['API & Integrations', Icons.api_outlined],
    ['Staff & Roles', Icons.admin_panel_settings_outlined],
    ['Settings', Icons.settings_outlined],
    ['Account & Security', Icons.security_outlined],
  ];

  Widget page() {
    switch (index) {
      case 1: return CategoryPage(store);
      case 2: return OrdersPage(store);
      case 3: return CustomersPage(store);
      case 4: return OffersPage(store);
      case 5: return PaymentsPage(store);
      case 6: return ShippingPage(store);
      case 7: return CustomOrdersPage(store);
      case 8: return PartnerPage(store, 'Vendors', 'Vendor', store.vendors);
      case 9: return PartnerPage(store, 'Resellers', 'Reseller', store.resellers);
      case 10: return PartnerPage(store, 'Affiliates', 'Affiliate', store.affiliates);
      case 11: return WalletPage(store);
      case 12: return InventoryPage(store);
      case 13: return ReportsPage(store);
      case 14: return MarketingPage(store);
      case 15: return NotificationsPage(store);
      case 16: return IntegrationsPage(store);
      case 17: return StaffPage(store);
      case 18: return SettingsPage(store);
      case 19: return SecurityPage(store);
      default: return DashboardPage(store, (i) => setState(() => index = i));
    }
  }

  @override Widget build(BuildContext context) => AnimatedBuilder(
    animation: store,
    builder: (_, __) => Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      drawer: Drawer(
        child: SafeArea(child: Column(children: [
          Container(width: double.infinity, padding: const EdgeInsets.all(20),
            color: const Color(0xFF087F5B),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(backgroundColor: Colors.white, child: Text('K',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF087F5B)))),
              SizedBox(height: 10),
              Text('K - Store', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
              Text('Admin Panel', style: TextStyle(color: Colors.white70)),
            ])),
          Expanded(child: ListView.builder(itemCount: menus.length, itemBuilder: (_, i) {
            return ListTile(
              selected: index == i,
              selectedTileColor: const Color(0xFFE8F7F0),
              leading: Icon(menus[i][1] as IconData),
              title: Text(menus[i][0] as String),
              onTap: () { Navigator.pop(context); setState(() => index = i); },
            );
          })),
        ])),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white, foregroundColor: Colors.black87, elevation: 0,
        title: Text(menus[index][0] as String, style: const TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(onPressed: () => setState(() => index = 15),
            icon: Badge(isLabelVisible: store.unread > 0, label: Text('${store.unread}'),
              child: const Icon(Icons.notifications_none))),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            onSelected: (v) => setState(() => index = v == 'security' ? 19 : 18),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'security', child: Text('Account & Security')),
              PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
            child: const Padding(padding: EdgeInsets.all(10), child: CircleAvatar(
              backgroundColor: Color(0xFF16A05D), child: Icon(Icons.person, color: Colors.white))),
          ),
        ],
      ),
      body: page(),
    ),
  );
}

/* ----------------------------- DATA STORE -------------------------------- */

class AdminStore extends ChangeNotifier {
  final categories = <Item>[
    Item('1','Ayurvedic','24'), Item('2','Unani','18'),
    Item('3','Herbal','31'), Item('4','Personal Care','16')
  ];
  final orders = <Order>[
    Order('ORD-1001','Rahul Sharma',1299,'Paid','Processing'),
    Order('ORD-1002','Aamir Khan',899,'COD','Shipped'),
    Order('ORD-1003','Priya Singh',2450,'Paid','Delivered'),
  ];
  final customers = <Customer>[
    Customer('C-001','Rahul Sharma','9876543210','rahul@example.com'),
    Customer('C-002','Aamir Khan','9876501234','aamir@example.com'),
    Customer('C-003','Priya Singh','9812345678','priya@example.com'),
  ];
  final products = <Product>[
    Product('P-001','Wheat Atta 10kg','Ayurvedic',499,32),
    Product('P-002','Herbal Hair Oil','Herbal',210,8),
    Product('P-003','Wellness Syrup','Unani',599,44),
    Product('P-004','Natural Face Wash','Personal Care',249,3),
  ];
  final coupons = <Coupon>[
    Coupon('WELCOME100','₹100 first order',100),
    Coupon('SAVE200','₹200 above ₹999',200),
  ];
  final vendors = <Partner>[Partner('V-001','KIRZ Supplies')];
  final resellers = <Partner>[Partner('R-001','Amit Reseller')];
  final affiliates = <Partner>[Partner('A-001','Sara Affiliate')];
  final customOrders = <CustomOrder>[CustomOrder('CO-001','Custom Herbal Combo','Rahul Sharma')];
  final staff = <Staff>[Staff('S-001','Super Admin','super_admin'), Staff('S-002','Store Manager','manager')];
  final notifications = <Notice>[
    Notice('Low stock','Natural Face Wash has only 3 units.'),
    Notice('New order','ORD-1003 has been placed.'),
  ];
  final campaigns = <String>['Welcome Campaign','Festival Offer'];
  double wallet = 12500;
  int points = 2480;
  bool storeOpen = true;
  bool maintenance = false;
  String courier = 'Shiprocket';

  int get unread => notifications.where((n) => !n.read).length;
  double get revenue => orders.fold(0, (a,b) => a + b.amount);

  void addCategory(String n) { categories.add(Item(DateTime.now().toString(),n,'0')); notifyListeners(); }
  void delCategory(Item x) { categories.remove(x); notifyListeners(); }
  void toggleCoupon(Coupon x) { x.active=!x.active; notifyListeners(); }
  void addCoupon(String c,String d,double v) { coupons.add(Coupon(c,d,v)); notifyListeners(); }
  void delCoupon(Coupon x) { coupons.remove(x); notifyListeners(); }
  void status(Order x,String v) { x.status=v; notifyListeners(); }
  void stock(Product x,int v) { x.stock=v; notifyListeners(); }
  void addProduct(String n,double p,int s) { products.add(Product(DateTime.now().toString(),n,'General',p,s)); notifyListeners(); }
  void addPartner(List<Partner> l,String n) { l.add(Partner(DateTime.now().toString(),n)); notifyListeners(); }
  void togglePartner(Partner x) { x.active=!x.active; notifyListeners(); }
  void addCustom(String t,String c) { customOrders.add(CustomOrder(DateTime.now().toString(),t,c)); notifyListeners(); }
  void addStaff(String n,String r) { staff.add(Staff(DateTime.now().toString(),n,r)); notifyListeners(); }
  void markAll() { for(final n in notifications) n.read=true; notifyListeners(); }
}

class Item { Item(this.id,this.name,this.count,[this.active=true]); String id,name,count; bool active; }
class Order { Order(this.id,this.customer,this.amount,this.payment,this.status); final String id,customer,payment; final double amount; String status; }
class Customer { Customer(this.id,this.name,this.phone,this.email); final String id,name,phone,email; }
class Product { Product(this.id,this.name,this.category,this.price,this.stock); final String id,name,category; final double price; int stock; }
class Coupon { Coupon(this.code,this.description,this.value,[this.active=true]); final String code,description; final double value; bool active; }
class Partner { Partner(this.id,this.name,[this.active=true]); final String id,name; bool active; }
class CustomOrder { CustomOrder(this.id,this.title,this.customer,[this.status='Pending']); final String id,title,customer; String status; }
class Staff { Staff(this.id,this.name,this.role,[this.active=true]); final String id,name,role; bool active; }
class Notice { Notice(this.title,this.message,[this.read=false]); final String title,message; bool read; }

/* ----------------------------- DASHBOARD ---------------------------------- */

class DashboardPage extends StatelessWidget {
  const DashboardPage(this.store,this.open,{super.key});
  final AdminStore store; final ValueChanged<int> open;
  @override Widget build(BuildContext context) {
    final buttons = const [
      ['Categories',Icons.category_outlined],['Orders',Icons.shopping_bag_outlined],
      ['Customers',Icons.people_outline],['Offers & Coupons',Icons.local_offer_outlined],
      ['Payments',Icons.payments_outlined],['Delivery & Shipping',Icons.local_shipping_outlined],
      ['Custom Orders',Icons.assignment_outlined],['Vendors',Icons.storefront_outlined],
      ['Resellers',Icons.handshake_outlined],['Affiliates',Icons.share_outlined],
      ['Wallet & Rewards',Icons.account_balance_wallet_outlined],['Inventory',Icons.inventory_2_outlined],
      ['Reports & Analysis',Icons.bar_chart_outlined],['Marketing',Icons.campaign_outlined],
      ['Notifications',Icons.notifications_none_outlined],['API & Integrations',Icons.api_outlined],
      ['Staff & Roles',Icons.admin_panel_settings_outlined],['Settings',Icons.settings_outlined],
      ['Account & Security',Icons.security_outlined],
    ];
    return PageFrame(title:'K - Store Dashboard', action:null, children:[
      Container(width:double.infinity,padding:const EdgeInsets.all(22),
        decoration:BoxDecoration(color:const Color(0xFF087F5B),borderRadius:BorderRadius.circular(18)),
        child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text('Welcome to K - Store',style:TextStyle(color:Colors.white,fontSize:25,fontWeight:FontWeight.w900)),
          SizedBox(height:6),Text('Manage every part of your store from one admin panel.',
            style:TextStyle(color:Colors.white70)),
        ])),
      const SizedBox(height:16),
      Wrap(spacing:12,runSpacing:12,children:[
        Stat('Orders','${store.orders.length}',Icons.shopping_bag_outlined),
        Stat('Customers','${store.customers.length}',Icons.people_outline),
        Stat('Products','${store.products.length}',Icons.inventory_2_outlined),
        Stat('Revenue',money(store.revenue),Icons.currency_rupee),
      ]),
      const SizedBox(height:20),
      const Text('All Store Modules',style:TextStyle(fontSize:19,fontWeight:FontWeight.w800)),
      const SizedBox(height:10),
      GridView.builder(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),
        itemCount:buttons.length,gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent:260,mainAxisExtent:92,crossAxisSpacing:10,mainAxisSpacing:10),
        itemBuilder:(_,i)=>Feature(title:buttons[i][0] as String,icon:buttons[i][1] as IconData,
          onTap:()=>open(i+1))),
    ]);
  }
}

/* ----------------------------- GENERIC PAGES ------------------------------ */

class PageFrame extends StatelessWidget {
  const PageFrame({required this.title,required this.children,this.action,super.key});
  final String title; final List<Widget> children; final Widget? action;
  @override Widget build(BuildContext context)=>SingleChildScrollView(
    padding:const EdgeInsets.all(18),child:Center(child:ConstrainedBox(
      constraints:const BoxConstraints(maxWidth:1200),child:Column(
        crossAxisAlignment:CrossAxisAlignment.start,children:[
          Row(children:[Expanded(child:Text(title,style:const TextStyle(fontSize:24,fontWeight:FontWeight.w900))),if(action!=null) action!]),
          const SizedBox(height:18),...children]))));
}

class Stat extends StatelessWidget {
  const Stat(this.title,this.value,this.icon,{super.key}); final String title,value; final IconData icon;
  @override Widget build(BuildContext c)=>SizedBox(width:210,height:82,child:Card(elevation:0,
    child:ListTile(leading:CircleAvatar(backgroundColor:const Color(0xFFE8F7F0),
      child:Icon(icon,color:const Color(0xFF087F5B))),title:Text(title),
      subtitle:Text(value,style:const TextStyle(fontWeight:FontWeight.w900,fontSize:18)))));
}

class Feature extends StatelessWidget {
  const Feature({required this.title,required this.icon,required this.onTap,super.key});
  final String title; final IconData icon; final VoidCallback onTap;
  @override Widget build(BuildContext c)=>Card(elevation:0,child:InkWell(onTap:onTap,
    borderRadius:BorderRadius.circular(14),child:Padding(padding:const EdgeInsets.all(12),
      child:Row(children:[CircleAvatar(backgroundColor:const Color(0xFFE8F7F0),
        child:Icon(icon,color:const Color(0xFF087F5B))),const SizedBox(width:10),
        Expanded(child:Text(title,style:const TextStyle(fontWeight:FontWeight.w700))),
        const Icon(Icons.chevron_right)]))));
}

class RowCard extends StatelessWidget {
  const RowCard({required this.icon,required this.title,required this.subtitle,required this.trailing,super.key});
  final Widget icon,trailing; final String title,subtitle;
  @override Widget build(BuildContext c)=>Card(elevation:0,margin:const EdgeInsets.only(bottom:9),
    child:ListTile(leading:icon,title:Text(title,style:const TextStyle(fontWeight:FontWeight.w700)),
      subtitle:Text(subtitle),trailing:trailing));
}

class CategoryPage extends StatelessWidget {
  const CategoryPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Categories',
    action:FilledButton.icon(onPressed:()=>textDialog(c,'Add Category','Category name',(v){if(v.isNotEmpty)s.addCategory(v);}),
      icon:const Icon(Icons.add),label:const Text('Add Category')),
    children:s.categories.map((x)=>RowCard(icon:const Icon(Icons.category_outlined),title:x.name,
      subtitle:'${x.count} products',trailing:Row(mainAxisSize:MainAxisSize.min,children:[
        Switch(value:x.active,onChanged:(_){x.active=!x.active;s.notifyListeners();}),
        IconButton(onPressed:()=>s.delCategory(x),icon:const Icon(Icons.delete_outline,color:Colors.red))]))).toList());
}

class OrdersPage extends StatelessWidget {
  const OrdersPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Orders',action:OutlinedButton.icon(
    onPressed:()=>snack(c,'Export orders ready.'),icon:const Icon(Icons.download),label:const Text('Export')),
    children:s.orders.map((x)=>RowCard(icon:const Icon(Icons.shopping_bag_outlined),
      title:'${x.id} • ${money(x.amount)}',subtitle:'${x.customer} • ${x.payment}',
      trailing:DropdownButton<String>(value:x.status,items:const ['Pending','Processing','Shipped','Delivered','Cancelled']
        .map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),
        onChanged:(v){if(v!=null)s.status(x,v);}))).toList());
}

class CustomersPage extends StatelessWidget {
  const CustomersPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Customers',
    action:FilledButton.icon(onPressed:()=>snack(c,'Customer add/import is ready.'),
      icon:const Icon(Icons.person_add),label:const Text('Add / Import')),
    children:s.customers.map((x)=>RowCard(icon:const CircleAvatar(child:Icon(Icons.person)),
      title:x.name,subtitle:'${x.phone} • ${x.email}',
      trailing:const Icon(Icons.chevron_right))).toList());
}

class OffersPage extends StatelessWidget {
  const OffersPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Offers & Coupons',
    action:FilledButton.icon(onPressed:()=>couponDialog(c,s),icon:const Icon(Icons.add),label:const Text('Create Coupon')),
    children:[
      ...s.coupons.map((x)=>RowCard(icon:const Icon(Icons.local_offer_outlined),title:x.code,
        subtitle:'${x.description} • ${money(x.value)}',trailing:Row(mainAxisSize:MainAxisSize.min,children:[
          Switch(value:x.active,onChanged:(_)=>s.toggleCoupon(x)),
          IconButton(onPressed:()=>s.delCoupon(x),icon:const Icon(Icons.delete_outline,color:Colors.red))]))),
      Wrap(spacing:10,runSpacing:10,children:[
        ActionButton('Flash Sale',Icons.flash_on,()=>snack(c,'Flash Sale setup opened.')),
        ActionButton('Free Gift',Icons.card_giftcard,()=>snack(c,'Free Gift setup opened.')),
        ActionButton('Free Delivery',Icons.local_shipping,()=>snack(c,'Free Delivery setup opened.')),
        ActionButton('BOGO',Icons.redeem,()=>snack(c,'Buy 1 Get 1 setup opened.')),
      ])
    ]);
}

class PaymentsPage extends StatelessWidget {
  const PaymentsPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Payments',children:[
    Setting('Razorpay','Configure payment gateway and webhooks',Icons.payments,Switch(value:true,onChanged:(_)=>{}),()=>snack(c,'Razorpay settings opened.')),
    Setting('Cash on Delivery','Enable or disable COD',Icons.money,Switch(value:true,onChanged:(_)=>{}),()=>{}),
    Setting('Refunds','Manage refunds and failed payments',Icons.undo, const Icon(Icons.chevron_right),()=>snack(c,'Refund manager opened.')),
    Setting('Payment Reports','Successful, failed and refunded transactions',Icons.receipt_long,const Icon(Icons.chevron_right),()=>snack(c,'Payment reports opened.')),
  ]);
}

class ShippingPage extends StatefulWidget {
  const ShippingPage(this.s,{super.key}); final AdminStore s;
  @override State<ShippingPage> createState()=>_ShippingPageState();
}
class _ShippingPageState extends State<ShippingPage>{
  bool free=true,block=false;
  @override Widget build(BuildContext c)=>PageFrame(title:'Delivery & Shipping',action:FilledButton(
    onPressed:()=>snack(c,'Shipping settings saved.'),child:const Text('Save')),
    children:[
      DropdownButtonFormField<String>(value:widget.s.courier,decoration:const InputDecoration(labelText:'Courier Provider',border:OutlineInputBorder()),
        items:const ['Shiprocket','Shipmojo','Manual'].map((x)=>DropdownMenuItem(value:x,child:Text(x))).toList(),
        onChanged:(v)=>setState(()=>widget.s.courier=v??widget.s.courier)),
      SwitchListTile(title:const Text('Free Delivery'),subtitle:const Text('Free delivery rules'),value:free,onChanged:(v)=>setState(()=>free=v)),
      SwitchListTile(title:const Text('Block PIN Codes'),subtitle:const Text('Block selected service areas'),value:block,onChanged:(v)=>setState(()=>block=v)),
      Setting('PIN Code Rules','Delivery charges and blocked PIN codes',Icons.pin_drop,const Icon(Icons.chevron_right),()=>snack(c,'PIN code rules opened.')),
      Setting('Shipping Zones','Local, national and special zones',Icons.map,const Icon(Icons.chevron_right),()=>snack(c,'Shipping zones opened.')),
    ]);
}

class CustomOrdersPage extends StatelessWidget {
  const CustomOrdersPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Custom Orders',
    action:FilledButton.icon(onPressed:()=>customDialog(c,s),icon:const Icon(Icons.add),label:const Text('Create')),
    children:s.customOrders.map((x)=>RowCard(icon:const Icon(Icons.assignment_outlined),title:x.title,
      subtitle:'${x.id} • ${x.customer}',trailing:DropdownButton<String>(value:x.status,
        items:const ['Pending','Approved','In Production','Ready','Completed','Cancelled']
          .map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),
        onChanged:(v){if(v!=null){x.status=v;s.notifyListeners();}}))).toList());
}

class PartnerPage extends StatelessWidget {
  const PartnerPage(this.s,this.title,this.type,this.list,{super.key});
  final AdminStore s; final String title,type; final List<Partner> list;
  @override Widget build(BuildContext c)=>PageFrame(title:title,
    action:FilledButton.icon(onPressed:()=>textDialog(c,'Add $type','$type name',(v){if(v.isNotEmpty)s.addPartner(list,v);}),
      icon:const Icon(Icons.add),label:Text('Add $type')),
    children:[
      ...list.map((x)=>RowCard(icon:Icon(type=='Vendor'?Icons.storefront:type=='Reseller'?Icons.handshake:Icons.share),
        title:x.name,subtitle:x.id,trailing:Row(mainAxisSize:MainAxisSize.min,children:[
          Switch(value:x.active,onChanged:(_)=>{x.active=!x.active,s.notifyListeners()}),
          IconButton(onPressed:(){list.remove(x);s.notifyListeners();},icon:const Icon(Icons.delete_outline,color:Colors.red)),
        ]))),
    ]);
}

class WalletPage extends StatelessWidget {
  const WalletPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Wallet & Rewards',children:[
    Wrap(spacing:12,runSpacing:12,children:[
      Stat('Wallet',money(s.wallet),Icons.account_balance_wallet),
      Stat('Reward Points','${s.points}',Icons.stars),
    ]),
    const SizedBox(height:16),
    ActionButton('Add ₹1,000',Icons.add_card,(){s.wallet+=1000;s.notifyListeners();snack(c,'₹1,000 added.');}),
    ActionButton('Add 100 Points',Icons.stars,(){s.points+=100;s.notifyListeners();snack(c,'100 points added.');}),
    ActionButton('Redeem 100 Points',Icons.redeem,(){if(s.points>=100){s.points-=100;s.notifyListeners();snack(c,'100 points redeemed.');}}),
  ]);
}

class InventoryPage extends StatelessWidget {
  const InventoryPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Inventory',
    action:FilledButton.icon(onPressed:()=>productDialog(c,s),icon:const Icon(Icons.add),label:const Text('Add Product')),
    children:s.products.map((x)=>RowCard(icon:const Icon(Icons.inventory_2_outlined),title:x.name,
      subtitle:'${x.category} • ${money(x.price)}',trailing:Text('${x.stock} units',
        style:TextStyle(fontWeight:FontWeight.w800,color:x.stock<=5?Colors.red:Colors.green)))).toList());
}

class ReportsPage extends StatelessWidget {
  const ReportsPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Reports & Analysis',children:[
    Wrap(spacing:12,runSpacing:12,children:[
      Stat('Revenue',money(s.revenue),Icons.currency_rupee),
      Stat('Orders','${s.orders.length}',Icons.shopping_bag),
      Stat('Customers','${s.customers.length}',Icons.people),
      Stat('Products','${s.products.length}',Icons.inventory_2),
    ]),
    const SizedBox(height:18),
    ActionButton('Sales Report',Icons.point_of_sale,()=>snack(c,'Sales report opened.')),
    ActionButton('Order Report',Icons.shopping_bag,()=>snack(c,'Order report opened.')),
    ActionButton('Customer Report',Icons.people,()=>snack(c,'Customer report opened.')),
    ActionButton('Inventory Report',Icons.inventory_2,()=>snack(c,'Inventory report opened.')),
    OutlinedButton.icon(onPressed:()=>snack(c,'CSV/PDF export can be connected to backend.'),icon:const Icon(Icons.download),label:const Text('Export')),
  ]);
}

class MarketingPage extends StatelessWidget {
  const MarketingPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Marketing',
    action:FilledButton.icon(onPressed:(){s.campaigns.add('Campaign ${s.campaigns.length+1}');s.notifyListeners();},
      icon:const Icon(Icons.add),label:const Text('Create Campaign')),
    children:[
      ActionButton('WhatsApp',Icons.chat,()=>snack(c,'WhatsApp campaign opened.')),
      ActionButton('Email',Icons.email,()=>snack(c,'Email campaign opened.')),
      ActionButton('Push Notification',Icons.notifications,()=>snack(c,'Push campaign opened.')),
      ActionButton('Referral',Icons.people_alt,()=>snack(c,'Referral campaign opened.')),
      ...s.campaigns.map((x)=>RowCard(icon:const Icon(Icons.campaign),title:x,subtitle:'Campaign ready',
        trailing:FilledButton(onPressed:()=>snack(c,'$x opened.'),child:const Text('Open')))),
    ]);
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Notifications',
    action:TextButton(onPressed:s.markAll,child:const Text('Mark all read')),
    children:[
      ActionButton('New Order',Icons.shopping_bag,()=>snack(c,'Order notification composer opened.')),
      ActionButton('Offer',Icons.local_offer,()=>snack(c,'Offer notification composer opened.')),
      ActionButton('Stock Alert',Icons.warning,()=>snack(c,'Stock alert composer opened.')),
      ...s.notifications.map((n)=>RowCard(icon:Icon(n.read?Icons.notifications_none:Icons.notifications_active),
        title:n.title,subtitle:n.message,trailing:n.read?const Text('Read'):TextButton(
          onPressed:(){n.read=true;s.notifyListeners();},child:const Text('Mark read')))),
    ]);
}

class IntegrationsPage extends StatefulWidget {
  const IntegrationsPage(this.s,{super.key}); final AdminStore s;
  @override State<IntegrationsPage> createState()=>_IntegrationsPageState();
}
class _IntegrationsPageState extends State<IntegrationsPage>{
  final m={'Razorpay':true,'Shiprocket':false,'Shipmojo':false,'WhatsApp API':false,'Firebase':true};
  @override Widget build(BuildContext c)=>PageFrame(title:'API & Integrations',children:[
    ...m.keys.map((x)=>Setting(x,m[x]!?'Connected':'Not connected',Icons.api,Switch(value:m[x]!,onChanged:(v)=>setState(()=>m[x]=v)),
      ()=>snack(c,'$x configuration opened.'))),
    Setting('API Keys','Create/revoke API keys',Icons.key,const Icon(Icons.chevron_right),()=>snack(c,'API keys opened.')),
    Setting('Webhooks','Order/payment/shipping webhooks',Icons.webhook,const Icon(Icons.chevron_right),()=>snack(c,'Webhooks opened.')),
  ]);
}

class StaffPage extends StatelessWidget {
  const StaffPage(this.s,{super.key}); final AdminStore s;
  @override Widget build(BuildContext c)=>PageFrame(title:'Staff & Roles',
    action:FilledButton.icon(onPressed:()=>staffDialog(c,s),icon:const Icon(Icons.person_add),label:const Text('Add Staff')),
    children:[
      ...s.staff.map((x)=>RowCard(icon:const CircleAvatar(child:Icon(Icons.person)),title:x.name,subtitle:'${x.id} • ${x.role}',
        trailing:Switch(value:x.active,onChanged:(_){x.active=!x.active;s.notifyListeners();}))),
      ActionButton('Roles & Permissions',Icons.admin_panel_settings,()=>snack(c,'Permission matrix opened.')),
      ActionButton('Activity Logs',Icons.history,()=>snack(c,'Activity logs opened.')),
    ]);
}

class SettingsPage extends StatefulWidget {
  const SettingsPage(this.s,{super.key}); final AdminStore s;
  @override State<SettingsPage> createState()=>_SettingsPageState();
}
class _SettingsPageState extends State<SettingsPage>{
  @override Widget build(BuildContext c)=>PageFrame(title:'Settings',children:[
    SwitchListTile(title:const Text('Store Open'),subtitle:const Text('Allow new orders'),value:widget.s.storeOpen,
      onChanged:(v)=>setState(()=>widget.s.storeOpen=v)),
    SwitchListTile(title:const Text('Maintenance Mode'),subtitle:const Text('Temporarily disable ordering'),value:widget.s.maintenance,
      onChanged:(v)=>setState(()=>widget.s.maintenance=v)),
    Setting('Store Information','Name, logo, contact and address',Icons.store,const Icon(Icons.chevron_right),()=>snack(c,'Store information opened.')),
    Setting('Order Settings','Minimum order, delivery charge and COD',Icons.receipt_long,const Icon(Icons.chevron_right),()=>snack(c,'Order settings opened.')),
    Setting('Tax & Invoice','GST, invoice numbering and billing',Icons.receipt,const Icon(Icons.chevron_right),()=>snack(c,'Tax settings opened.')),
    Setting('Backup & Restore','Backup and restore data',Icons.backup,const Icon(Icons.chevron_right),()=>snack(c,'Backup settings opened.')),
  ]);
}

class SecurityPage extends StatefulWidget {
  const SecurityPage(this.s,{super.key}); final AdminStore s;
  @override State<SecurityPage> createState()=>_SecurityPageState();
}
class _SecurityPageState extends State<SecurityPage>{
  bool twoFactor=false,alerts=true;
  @override Widget build(BuildContext c)=>PageFrame(title:'Account & Security',children:[
    const RowCard(icon:CircleAvatar(child:Icon(Icons.person)),title:'Super Admin',
      subtitle:'admin account • Administrator',trailing:Icon(Icons.verified_user)),
    SwitchListTile(title:const Text('Two-Factor Authentication'),subtitle:const Text('Extra verification on login'),
      value:twoFactor,onChanged:(v)=>setState(()=>twoFactor=v)),
    SwitchListTile(title:const Text('Login Alerts'),subtitle:const Text('Notify on new login'),
      value:alerts,onChanged:(v)=>setState(()=>alerts=v)),
    Setting('Change Password','Update admin password',Icons.lock,const Icon(Icons.chevron_right),()=>passwordDialog(c)),
    Setting('Active Sessions','View and sign out devices',Icons.devices,const Icon(Icons.chevron_right),()=>snack(c,'Active sessions opened.')),
    Setting('Security Activity','Review security events',Icons.history,const Icon(Icons.chevron_right),()=>snack(c,'Security activity opened.')),
    OutlinedButton.icon(onPressed:()=>snack(c,'Logout confirmation opened.'),icon:const Icon(Icons.logout),label:const Text('Logout')),
  ]);
}

/* ------------------------------ SMALL UI --------------------------------- */

class Setting extends StatelessWidget{
  const Setting(this.title,this.subtitle,this.icon,this.trailing,this.tap,{super.key});
  final String title,subtitle; final IconData icon; final Widget trailing; final VoidCallback tap;
  @override Widget build(BuildContext c)=>RowCard(icon:CircleAvatar(backgroundColor:const Color(0xFFE8F7F0),
    child:Icon(icon,color:const Color(0xFF087F5B))),title:title,subtitle:subtitle,trailing:trailing);
}

class ActionButton extends StatelessWidget{
  const ActionButton(this.title,this.icon,this.tap,{super.key}); final String title; final IconData icon; final VoidCallback tap;
  @override Widget build(BuildContext c)=>Padding(padding:const EdgeInsets.only(right:8,bottom:8),
    child:FilledButton.tonalIcon(onPressed:tap,icon:Icon(icon),label:Text(title)));
}

void snack(BuildContext c,String x)=>ScaffoldMessenger.of(c).showSnackBar(SnackBar(content:Text(x)));
String money(double x)=>'₹${x.toStringAsFixed(0)}';

void textDialog(BuildContext c,String title,String label,ValueChanged<String> done){
  final t=TextEditingController();
  showDialog(context:c,builder:(_)=>AlertDialog(title:Text(title),content:TextField(controller:t,autofocus:true,
    decoration:InputDecoration(labelText:label,border:const OutlineInputBorder())),actions:[
      TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')),
      FilledButton(onPressed:(){done(t.text.trim());Navigator.pop(c);},child:const Text('Save'))]));
}

void couponDialog(BuildContext c,AdminStore s){
  final a=TextEditingController(),b=TextEditingController(),d=TextEditingController();
  showDialog(context:c,builder:(_)=>AlertDialog(title:const Text('Create Coupon'),content:Column(mainAxisSize:MainAxisSize.min,children:[
    TextField(controller:a,decoration:const InputDecoration(labelText:'Code')),
    TextField(controller:b,decoration:const InputDecoration(labelText:'Description')),
    TextField(controller:d,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Discount value')),
  ]),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')),FilledButton(onPressed:(){
    s.addCoupon(a.text.trim().toUpperCase(),b.text.trim(),double.tryParse(d.text)??0);Navigator.pop(c);
  },child:const Text('Create'))]));
}

void customDialog(BuildContext c,AdminStore s){
  final a=TextEditingController(),b=TextEditingController();
  showDialog(context:c,builder:(_)=>AlertDialog(title:const Text('Custom Order'),content:Column(mainAxisSize:MainAxisSize.min,children:[
    TextField(controller:a,decoration:const InputDecoration(labelText:'Order title')),
    TextField(controller:b,decoration:const InputDecoration(labelText:'Customer')),
  ]),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')),FilledButton(onPressed:(){
    s.addCustom(a.text.trim().isEmpty?'Custom Order':a.text.trim(),b.text.trim().isEmpty?'New Customer':b.text.trim());Navigator.pop(c);
  },child:const Text('Create'))]));
}

void productDialog(BuildContext c,AdminStore s){
  final a=TextEditingController(),b=TextEditingController(),d=TextEditingController();
  showDialog(context:c,builder:(_)=>AlertDialog(title:const Text('Add Product'),content:Column(mainAxisSize:MainAxisSize.min,children:[
    TextField(controller:a,decoration:const InputDecoration(labelText:'Product name')),
    TextField(controller:b,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Selling price')),
    TextField(controller:d,keyboardType:TextInputType.number,decoration:const InputDecoration(labelText:'Opening stock')),
  ]),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')),FilledButton(onPressed:(){
    s.addProduct(a.text.trim().isEmpty?'New Product':a.text.trim(),double.tryParse(b.text)??0,int.tryParse(d.text)??0);Navigator.pop(c);
  },child:const Text('Add'))]));
}

void staffDialog(BuildContext c,AdminStore s){
  final a=TextEditingController(),b=TextEditingController(text:'staff');
  showDialog(context:c,builder:(_)=>AlertDialog(title:const Text('Add Staff'),content:Column(mainAxisSize:MainAxisSize.min,children:[
    TextField(controller:a,decoration:const InputDecoration(labelText:'Name')),
    TextField(controller:b,decoration:const InputDecoration(labelText:'Role')),
  ]),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')),FilledButton(onPressed:(){
    s.addStaff(a.text.trim().isEmpty?'New Staff':a.text.trim(),b.text.trim());Navigator.pop(c);
  },child:const Text('Add'))]));
}

void passwordDialog(BuildContext c){
  final a=TextEditingController(),b=TextEditingController();
  showDialog(context:c,builder:(_)=>AlertDialog(title:const Text('Change Password'),content:Column(mainAxisSize:MainAxisSize.min,children:[
    TextField(controller:a,obscureText:true,decoration:const InputDecoration(labelText:'New password')),
    TextField(controller:b,obscureText:true,decoration:const InputDecoration(labelText:'Confirm password')),
  ]),actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')),FilledButton(onPressed:(){
    if(a.text.length>=6&&a.text==b.text){Navigator.pop(c);snack(c,'Password updated successfully.');}else{snack(c,'Passwords must match and contain 6+ characters.');}
  },child:const Text('Update'))]));
}
