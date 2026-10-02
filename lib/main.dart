import 'package:flutter/material.dart';

void main() => runApp(const KStoreAdmin());

const pink = Color(0xFFF20B4F);
const bg = Color(0xFFF7F7F9);

class KStoreAdmin extends StatelessWidget {
  const KStoreAdmin({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
    debugShowCheckedModeBanner:false,
    title:'K - Store Admin',
    theme:ThemeData(useMaterial3:true,scaffoldBackgroundColor:bg,
      colorScheme:ColorScheme.fromSeed(seedColor:pink),
      appBarTheme:const AppBarTheme(backgroundColor:Colors.white,
        surfaceTintColor:Colors.white,elevation:0)),
    home:const AdminHome(),
  );
}

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});
  @override State<AdminHome> createState()=>_AdminHomeState();
}
class _AdminHomeState extends State<AdminHome>{
  int tab=0;
  final names=['Home','Orders','Catalogue','Customers','More'];
  final icons=[Icons.dashboard_rounded,Icons.shopping_bag_rounded,
    Icons.inventory_2_rounded,Icons.people_alt_rounded,Icons.menu_rounded];
  @override Widget build(BuildContext c){
    final pages=[const Dashboard(),const Orders(),const Catalogue(),
      const Customers(),const More()];
    return Scaffold(
      appBar:AppBar(title:Row(children:[
        Container(width:42,height:42,decoration:BoxDecoration(color:pink,
          borderRadius:BorderRadius.circular(12)),
          child:const Center(child:Text('K',style:TextStyle(color:Colors.white,
            fontSize:24,fontWeight:FontWeight.w900)))),
        const SizedBox(width:10),
        const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text('K - Store',style:TextStyle(fontSize:18,fontWeight:FontWeight.w900)),
          Text('Admin Panel',style:TextStyle(fontSize:11,color:Colors.grey))
        ])
      ]),actions:[IconButton(onPressed:()=>go(c,const Notifications()),
        icon:const Icon(Icons.notifications_none_rounded))]),
      body:IndexedStack(index:tab,children:pages),
      bottomNavigationBar:NavigationBar(selectedIndex:tab,
        onDestinationSelected:(i)=>setState(()=>tab=i),
        backgroundColor:Colors.white,indicatorColor:const Color(0xFFFFE2EA),
        destinations:[for(int i=0;i<names.length;i++)
          NavigationDestination(icon:Icon(icons[i]),
            selectedIcon:Icon(icons[i],color:pink),label:names[i])]),
    );
  }
}

// ================= DASHBOARD =================
class Dashboard extends StatelessWidget{
  const Dashboard({super.key});
  @override Widget build(BuildContext c)=>Page('Dashboard','Store overview',[
    const Text('Good Morning 👋',style:TextStyle(color:Colors.grey)),
    const SizedBox(height:14),
    const Stats([['₹1,24,350','Sales'],['1,245','Orders'],
      ['986','Customers'],['1,245','Products Sold']]),
    const SizedBox(height:20), const Head('Quick Actions'),
    GridView.count(crossAxisCount:4,shrinkWrap:true,
      physics:const NeverScrollableScrollPhysics(),mainAxisSpacing:8,
      crossAxisSpacing:8,childAspectRatio:.8,children:[
      Action('Orders',Icons.shopping_bag_rounded,const Orders()),
      Action('Products',Icons.inventory_2_rounded,const Products()),
      Action('Inventory',Icons.warehouse_rounded,const Inventory()),
      Action('Customers',Icons.people_rounded,const Customers()),
      Action('Vendors',Icons.storefront_rounded,const Vendors()),
      Action('Resellers',Icons.handshake_rounded,const Resellers()),
      Action('Affiliates',Icons.link_rounded,const Affiliates()),
      Action('Marketing',Icons.campaign_rounded,const Marketing()),
    ]),
    const SizedBox(height:20),const Head('Recent Orders'),
    const Order('#ORD-10245','Ahmed Traders','₹2,450','Processing',Colors.orange),
    const Order('#ORD-10244','Rahul Sharma','₹1,280','Delivered',Colors.green),
    const Order('#ORD-10243','Mohd. Imran','₹3,650','Pending',pink),
    const SizedBox(height:10),const Head('Sales Channels'),
    const CardBox(child:Column(children:[
      Channel('Online Store','₹82,450','66%'),Channel('Reseller Sales','₹24,800','20%'),
      Channel('Vendor Sales','₹11,600','9%'),Channel('Affiliate Sales','₹5,500','5%')
    ]))
  ]);
}

// ================= ORDERS =================
class Orders extends StatelessWidget{
  const Orders({super.key});
  @override Widget build(BuildContext c)=>Page('Orders','Manage all orders',[
    const Stats([['1,245','Total'],['86','Pending'],['1,102','Completed'],['57','Cancelled']]),
    const SizedBox(height:14),const Search('Search order ID or customer'),
    const Order('#ORD-10245','Ahmed Traders','₹2,450','Processing',Colors.orange),
    const Order('#ORD-10244','Rahul Sharma','₹1,280','Delivered',Colors.green),
    const Order('#ORD-10243','Mohd. Imran','₹3,650','Pending',pink),
    const Order('#ORD-10242','Priya Store','₹4,890','Cancelled',Colors.red),
  ]);
}

// ================= CATALOGUE =================
class Catalogue extends StatelessWidget{
  const Catalogue({super.key});
  @override Widget build(BuildContext c)=>Page('Catalogue','Products and stock',[
    Tile('Products','Manage products, prices and SKUs',Icons.inventory_2_rounded,const Products()),
    Tile('Categories','Manage product categories',Icons.category_rounded,const Categories()),
    Tile('Inventory','Stock and low-stock management',Icons.warehouse_rounded,const Inventory()),
    Tile('Custom Orders','Customer-specific requests',Icons.assignment_rounded,const CustomOrders()),
    Tile('Bulk Pricing','Wholesale price slabs',Icons.price_change_rounded,const BulkPricing()),
  ]);
}
class Products extends StatelessWidget{
  const Products({super.key});
  @override Widget build(BuildContext c)=>Page('Products','1,245 products',[
    const Search('Search products'),
    const Product('Wheat Atta 10kg','SKU WHEAT-10','₹450','In Stock',Colors.green),
    const Product('Herbal Hair Oil 200ml','SKU SOHA-200','₹380','Low Stock',Colors.orange),
    const Product('Slim Trimz Powder','SKU STP-100','₹270','In Stock',Colors.green),
    const Product('Majoan Vajikaran Gold','SKU MVG-1K','₹3,200','Out of Stock',Colors.red),
  ]);
}
class Categories extends StatelessWidget{
  const Categories({super.key});
  @override Widget build(BuildContext c)=>Page('Categories','Product categories',[
    const Info('Ayurvedic Products','128 products',Icons.spa_rounded),
    const Info('Unani Products','96 products',Icons.local_florist_rounded),
    const Info('Herbal Products','184 products',Icons.eco_rounded),
    const Info('Personal Care','74 products',Icons.face_rounded),
    const Info('Wellness','52 products',Icons.self_improvement_rounded),
  ]);
}
class Inventory extends StatelessWidget{
  const Inventory({super.key});
  @override Widget build(BuildContext c)=>Page('Inventory','Stock management',[
    const Stats([['1,245','Products'],['986','In Stock'],['186','Low Stock'],['73','Out of Stock']]),
    const SizedBox(height:14),const Search('Search inventory'),
    const Product('Wheat Atta 10kg','142 units','₹450','Healthy',Colors.green),
    const Product('Herbal Hair Oil','18 units','₹380','Low Stock',Colors.orange),
    const Product('Majoan Gold','0 units','₹3,200','Out of Stock',Colors.red),
  ]);
}
class CustomOrders extends StatelessWidget{
  const CustomOrders({super.key});
  @override Widget build(BuildContext c)=>Page('Custom Orders','Customer requests',[
    const Stats([['48','Total'],['18','Pending'],['26','Approved'],['4','Cancelled']]),
    const SizedBox(height:14),const Search('Search custom order'),
    const Request('C01001','Ahmed Traders','Bulk herbal order','Pending',Colors.orange),
    const Request('C01002','Rahul Sharma','Private label request','Approved',Colors.green),
    const Request('C01003','Priya Store','Custom quantity','In Progress',Colors.blue),
  ]);
}
class BulkPricing extends StatelessWidget{
  const BulkPricing({super.key});
  @override Widget build(BuildContext c)=>Page('Bulk Pricing','Wholesale slabs',[
    const Price('1 - 10 units','₹90 / unit'),const Price('11 - 40 units','₹80 / unit'),
    const Price('41 - 90 units','₹70 / unit'),const Price('91+ units','Custom price')
  ]);
}

// ================= PEOPLE =================
class Customers extends StatelessWidget{
  const Customers({super.key});
  @override Widget build(BuildContext c)=>Page('Customers','986 customers',[
    const Stats([['986','Total'],['842','Active'],['98','New'],['46','Inactive']]),
    const SizedBox(height:14),const Search('Search customers'),
    const Person('Ahmed Khan','ahmed@example.com','42 Orders'),
    const Person('Rahul Sharma','rahul@example.com','28 Orders'),
    const Person('Mohd. Imran','imran@example.com','17 Orders'),
    const Person('Priya Singh','priya@example.com','11 Orders'),
  ]);
}
class Vendors extends StatelessWidget{
  const Vendors({super.key});
  @override Widget build(BuildContext c)=>Page('Vendors','Vendor management',[
    const Stats([['28','Total'],['18','Active'],['6','Pending'],['4','Inactive']]),
    const SizedBox(height:14),const Search('Search vendors'),
    const Person('Al-Hind Supplier','vendor@example.com','Active'),
    const Person('Herbal World','sales@herbalworld.com','Pending'),
    const Person('Wellness Traders','info@wellness.com','Active'),
  ]);
}
class Resellers extends StatelessWidget{
  const Resellers({super.key});
  @override Widget build(BuildContext c)=>Page('Resellers','Reseller network',[
    const Stats([['128','Total'],['96','Active'],['18','Pending'],['14','Inactive']]),
    const Person('A1 Reseller','Code RES001','₹84,500 Sales'),
    const Person('Health Point','Code RES002','₹61,200 Sales'),
    const Person('Wellness Hub','Code RES003','₹48,900 Sales'),
  ]);
}
class Affiliates extends StatelessWidget{
  const Affiliates({super.key});
  @override Widget build(BuildContext c)=>Page('Affiliates','Referral and commission',[
    const Stats([['256','Total'],['186','Active'],['42','Pending'],['28','Inactive']]),
    const Person('Affiliate One','REF AFF001','₹12,450 Commission'),
    const Person('Growth Partner','REF AFF002','₹8,620 Commission'),
    const Person('Health Promoter','REF AFF003','₹5,480 Commission'),
  ]);
}

// ================= MONEY / BUSINESS =================
class Wallet extends StatelessWidget{
  const Wallet({super.key});
  @override Widget build(BuildContext c)=>Page('Wallet','Credits, debits and payouts',[
    Container(width:double.infinity,padding:const EdgeInsets.all(22),
      decoration:BoxDecoration(color:pink,borderRadius:BorderRadius.circular(20)),
      child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text('Available Balance',style:TextStyle(color:Colors.white70)),
        SizedBox(height:7),Text('₹12,450',style:TextStyle(color:Colors.white,
          fontSize:32,fontWeight:FontWeight.w900)),
        SizedBox(height:8),Text('Credits • Debits • Payouts',
          style:TextStyle(color:Colors.white70))
      ])),
    const SizedBox(height:14),
    const Transaction('Order settlement','+ ₹2,450','Credit',Colors.green),
    const Transaction('Affiliate payout','- ₹1,200','Debit',Colors.red),
    const Transaction('Reseller commission','+ ₹860','Credit',Colors.green),
  ]);
}
class Rewards extends StatelessWidget{
  const Rewards({super.key});
  @override Widget build(BuildContext c)=>Page('Rewards & Loyalty','Points and tiers',[
    const Stats([['48,250','Points'],['8,640','Redeemed'],['986','Members'],['Gold','Top Tier']]),
    const Info('Silver','0 - 999 points',Icons.workspace_premium_rounded),
    const Info('Gold','1,000 - 4,999 points',Icons.workspace_premium_rounded),
    const Info('Platinum','5,000+ points',Icons.workspace_premium_rounded),
  ]);
}
class Reports extends StatelessWidget{
  const Reports({super.key});
  @override Widget build(BuildContext c)=>Page('Reports & Analytics','Business performance',[
    const Stats([['₹1,24,350','Sales'],['1,245','Orders'],['986','Customers'],['1,245','Units Sold']]),
    const SizedBox(height:14),const CardBox(child:Column(
      crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Sales Overview',
      style:TextStyle(fontSize:16,fontWeight:FontWeight.w900)),SizedBox(height:16),
      SizedBox(height:130,child:CustomPaint(painter:ChartPainter()))])),
    const SizedBox(height:14),const Info('Daily Sales','Sales by day',Icons.today_rounded),
    const Info('Product Performance','Top products',Icons.trending_up_rounded),
    const Info('Customer Report','Growth and retention',Icons.people_alt_rounded),
  ]);
}
class Marketing extends StatelessWidget{
  const Marketing({super.key});
  @override Widget build(BuildContext c)=>Page('Marketing','Campaigns and offers',[
    const Stats([['12','Campaigns'],['8','Active'],['24','Coupons'],['4','Referral']]),
    const Info('Campaigns','Create and manage campaigns',Icons.campaign_rounded),
    const Info('Coupons & Offers','Discount codes and offers',Icons.local_offer_rounded),
    const Info('Referral Programme','Referral rewards',Icons.share_rounded),
    const Info('Push Marketing','Customer notifications',Icons.notifications_active_rounded),
  ]);
}
class Notifications extends StatelessWidget{
  const Notifications({super.key});
  @override Widget build(BuildContext c)=>Page('Notifications','12 notifications',[
    const Info('New order received','Order #ORD-10245',Icons.shopping_bag_rounded),
    const Info('Low stock alert','Herbal Hair Oil is running low',Icons.warning_rounded),
    const Info('New vendor request','Vendor waiting for approval',Icons.storefront_rounded),
    const Info('Payout requested','Reseller requested payout',Icons.payments_rounded),
  ]);
}
class ApiIntegrations extends StatelessWidget{
  const ApiIntegrations({super.key});
  @override Widget build(BuildContext c)=>Page('API & Integrations','Connected services',[
    const Integration('Payment Gateway','Razorpay / gateway',Icons.payment_rounded,true),
    const Integration('Shipping','Shiprocket / Shipmojo',Icons.local_shipping_rounded,true),
    const Integration('WhatsApp','Customer communication',Icons.chat_rounded,false),
    const Integration('SMS / Email','Notifications',Icons.email_rounded,true),
  ]);
}
class StaffRoles extends StatelessWidget{
  const StaffRoles({super.key});
  @override Widget build(BuildContext c)=>Page('Staff & Roles','Access and permissions',[
    const Stats([['18','Staff'],['16','Active'],['2','Inactive'],['6','Roles']]),
    const Person('Super Admin','Full access','1 Member'),
    const Person('Store Manager','Orders + Catalogue','3 Members'),
    const Person('Support Staff','Orders + Customers','8 Members'),
    const Person('Marketing','Marketing only','4 Members'),
  ]);
}
class Settings extends StatelessWidget{
  const Settings({super.key});
  @override Widget build(BuildContext c)=>Page('Settings','Store configuration',[
    const Info('General','Store name, logo and contact',Icons.store_rounded),
    const Info('Payment','Payment methods and checkout',Icons.payment_rounded),
    const Info('Shipping','Delivery and pin codes',Icons.local_shipping_rounded),
    const Info('Products','Catalogue settings',Icons.inventory_2_rounded),
    const Info('Customers','Customer settings',Icons.people_alt_rounded),
    const Info('Marketing','Offers and promotions',Icons.campaign_rounded),
    const Info('Security','Authentication and security',Icons.security_rounded),
    const Info('Appearance','Theme and branding',Icons.palette_rounded),
    const Info('Backup','Data backup and restore',Icons.backup_rounded),
    const Info('Legal','Privacy and terms',Icons.gavel_rounded),
  ]);
}
class Security extends StatelessWidget{
  const Security({super.key});
  @override Widget build(BuildContext c)=>Page('Account & Security','Protect admin access',[
    const Info('Admin Profile','Name, email and phone',Icons.person_rounded),
    const Info('Change Password','Update password',Icons.lock_rounded),
    const Info('Two-Factor Authentication','Not enabled',Icons.verified_user_rounded),
    const Info('Login Devices','Signed-in devices',Icons.devices_rounded),
    const Info('Login Activity','Recent activity',Icons.history_rounded),
    const Info('Logout All Devices','End active sessions',Icons.logout_rounded),
  ]);
}

// ================= MORE =================
class More extends StatelessWidget{
  const More({super.key});
  @override Widget build(BuildContext c)=>Page('Admin','All management modules',[
    Tile('Custom Orders','Customer requests',Icons.assignment_rounded,const CustomOrders()),
    Tile('Vendors','Vendor management',Icons.storefront_rounded,const Vendors()),
    Tile('Resellers','Reseller network',Icons.handshake_rounded,const Resellers()),
    Tile('Affiliates','Referral and commission',Icons.link_rounded,const Affiliates()),
    Tile('Wallet','Credits and payouts',Icons.account_balance_wallet_rounded,const Wallet()),
    Tile('Rewards & Loyalty','Points and tiers',Icons.card_giftcard_rounded,const Rewards()),
    Tile('Reports & Analytics','Sales and reports',Icons.analytics_rounded,const Reports()),
    Tile('Marketing','Campaigns and coupons',Icons.campaign_rounded,const Marketing()),
    Tile('Notifications','Alerts and updates',Icons.notifications_rounded,const Notifications()),
    Tile('API & Integrations','Payments and shipping',Icons.api_rounded,const ApiIntegrations()),
    Tile('Staff & Roles','Staff permissions',Icons.admin_panel_settings_rounded,const StaffRoles()),
    Tile('Settings','Store configuration',Icons.settings_rounded,const Settings()),
    Tile('Account & Security','Profile and security',Icons.security_rounded,const Security()),
  ]);
}

// ================= WIDGETS =================
class Page extends StatelessWidget{
  final String title,sub; final List<Widget> children;
  const Page(this.title,this.sub,this.children,{super.key});
  @override Widget build(BuildContext c)=>SafeArea(child:SingleChildScrollView(
    padding:const EdgeInsets.fromLTRB(16,12,16,28),
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(title,style:const TextStyle(fontSize:26,fontWeight:FontWeight.w900)),
      const SizedBox(height:3),Text(sub,style:const TextStyle(color:Colors.grey,fontSize:13)),
      const SizedBox(height:18),...children
    ])));
}
class Head extends StatelessWidget{
  final String t; const Head(this.t,{super.key});
  @override Widget build(BuildContext c)=>Padding(padding:const EdgeInsets.only(bottom:10),
    child:Text(t,style:const TextStyle(fontSize:17,fontWeight:FontWeight.w900)));
}
class Stats extends StatelessWidget{
  final List<List<String>> data; const Stats(this.data,{super.key});
  @override Widget build(BuildContext c)=>GridView.count(crossAxisCount:2,
    shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),
    crossAxisSpacing:8,mainAxisSpacing:8,childAspectRatio:2.2,
    children:[for(final x in data)Mini(x[0],x[1])]);
}
class Mini extends StatelessWidget{
  final String a,b; const Mini(this.a,this.b,{super.key});
  @override Widget build(BuildContext c)=>Card(child:Center(child:Column(
    mainAxisAlignment:MainAxisAlignment.center,children:[
      Text(a,style:const TextStyle(fontSize:19,fontWeight:FontWeight.w900,color:pink)),
      Text(b,style:const TextStyle(fontSize:10,color:Colors.grey))
    ])));
}
class Search extends StatelessWidget{
  final String hint; const Search(this.hint,{super.key});
  @override Widget build(BuildContext c)=>Card(child:TextField(decoration:InputDecoration(
    hintText:hint,prefixIcon:const Icon(Icons.search_rounded),
    suffixIcon:const Icon(Icons.tune_rounded),border:InputBorder.none)));
}
class CardBox extends StatelessWidget{
  final Widget child; const CardBox({required this.child,super.key});
  @override Widget build(BuildContext c)=>Card(child:Padding(padding:const EdgeInsets.all(16),child:child));
}
class Action extends StatelessWidget{
  final String title; final IconData icon; final Widget page;
  const Action(this.title,this.icon,this.page,{super.key});
  @override Widget build(BuildContext c)=>InkWell(onTap:()=>go(c,page),
    child:Card(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
      Icon(icon,color:pink,size:23),const SizedBox(height:6),
      Text(title,textAlign:TextAlign.center,style:const TextStyle(fontSize:10,fontWeight:FontWeight.w700))
    ])));
}
class Tile extends StatelessWidget{
  final String title,sub; final IconData icon; final Widget page;
  const Tile(this.title,this.sub,this.icon,this.page,{super.key});
  @override Widget build(BuildContext c)=>Card(margin:const EdgeInsets.only(bottom:9),
    child:ListTile(contentPadding:const EdgeInsets.symmetric(horizontal:13,vertical:3),
      leading:Box(icon),title:Text(title,style:const TextStyle(fontSize:14,fontWeight:FontWeight.w800)),
      subtitle:Text(sub,style:const TextStyle(fontSize:11,color:Colors.grey)),
      trailing:const Icon(Icons.chevron_right_rounded),onTap:()=>go(c,page)));
}
class Info extends StatelessWidget{
  final String title,sub; final IconData icon;
  const Info(this.title,this.sub,this.icon,{super.key});
  @override Widget build(BuildContext c)=>Card(margin:const EdgeInsets.only(bottom:9),
    child:ListTile(contentPadding:const EdgeInsets.symmetric(horizontal:13,vertical:3),
      leading:Box(icon),title:Text(title,style:const TextStyle(fontSize:14,fontWeight:FontWeight.w800)),
      subtitle:Text(sub,style:const TextStyle(fontSize:11,color:Colors.grey)),
      trailing:const Icon(Icons.chevron_right_rounded)));
}
class Box extends StatelessWidget{
  final IconData icon; const Box(this.icon,{super.key});
  @override Widget build(BuildContext c)=>Container(width:43,height:43,
    decoration:BoxDecoration(color:const Color(0xFFFFE5EC),borderRadius:BorderRadius.circular(12)),
    child:Icon(icon,color:pink,size:21));
}
class Order extends StatelessWidget{
  final String id,name,amount,status; final Color color;
  const Order(this.id,this.name,this.amount,this.status,this.color,{super.key});
  @override Widget build(BuildContext c)=>Card(margin:const EdgeInsets.only(bottom:9),
    child:ListTile(leading:const Box(Icons.shopping_bag_rounded),
      title:Text(id,style:const TextStyle(fontWeight:FontWeight.w900,fontSize:13)),
      subtitle:Text(name,style:const TextStyle(fontSize:11,color:Colors.grey)),
      trailing:Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.end,
        children:[Text(amount,style:const TextStyle(fontWeight:FontWeight.w900)),
          const SizedBox(height:3),Pill(status,color)])));
}
class Product extends StatelessWidget{
  final String name,sub,price,status; final Color color;
  const Product(this.name,this.sub,this.price,this.status,this.color,{super.key});
  @override Widget build(BuildContext c)=>Card(margin:const EdgeInsets.only(bottom:9),
    child:ListTile(leading:const Box(Icons.inventory_2_rounded),
      title:Text(name,style:const TextStyle(fontWeight:FontWeight.w900,fontSize:13)),
      subtitle:Text(sub,style:const TextStyle(fontSize:11,color:Colors.grey)),
      trailing:Column(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.end,
        children:[Text(price,style:const TextStyle(fontWeight:FontWeight.w900)),
          const SizedBox(height:3),Pill(status,color)])));
}
class Person extends StatelessWidget{
  final String name,sub,right; const Person(this.name,this.sub,this.right,{super.key});
  @override Widget build(BuildContext c)=>Card(margin:const EdgeInsets.only(bottom:9),
    child:ListTile(leading:CircleAvatar(backgroundColor:const Color(0xFFFFE5EC),
      child:Text(name[0],style:const TextStyle(color:pink,fontWeight:FontWeight.w900))),
      title:Text(name,style:const TextStyle(fontWeight:FontWeight.w800,fontSize:13)),
      subtitle:Text(sub,style:const TextStyle(fontSize:11,color:Colors.grey)),
      trailing:Text(right,style:const TextStyle(fontSize:10,fontWeight:FontWeight.w800))));
}
class Request extends StatelessWidget{
  final String id,name,detail,status; final Color color;
  const Request(this.id,this.name,this.detail,this.status,this.color,{super.key});
  @override Widget build(BuildContext c)=>Card(margin:const EdgeInsets.only(bottom:9),
    child:ListTile(leading:const Box(Icons.assignment_rounded),
      title:Text('$id • $name',style:const TextStyle(fontSize:12,fontWeight:FontWeight.w900)),
      subtitle:Text(detail,style:const TextStyle(fontSize:11,color:Colors.grey)),
      trailing:Pill(status,color)));
}
class Price extends StatelessWidget{
  final String range,price; const Price(this.range,this.price,{super.key});
  @override Widget build(BuildContext c)=>Card(margin:const EdgeInsets.only(bottom:9),
    child:ListTile(leading:const Box(Icons.price_change_rounded),title:Text(range),
      trailing:Text(price,style:const TextStyle(color:pink,fontWeight:FontWeight.w900))));
}
class Transaction extends StatelessWidget{
  final String title,amount,type; final Color color;
  const Transaction(this.title,this.amount,this.type,this.color,{super.key});
  @override Widget build(BuildContext c)=>Card(margin:const EdgeInsets.only(bottom:9),
    child:ListTile(leading:const Box(Icons.account_balance_wallet_rounded),
      title:Text(title,style:const TextStyle(fontWeight:FontWeight.w800,fontSize:13)),
      subtitle:Text(type,style:const TextStyle(fontSize:11,color:Colors.grey)),
      trailing:Text(amount,style:TextStyle(color:color,fontWeight:FontWeight.w900))));
}
class Integration extends StatelessWidget{
  final String title,sub; final IconData icon; final bool connected;
  const Integration(this.title,this.sub,this.icon,this.connected,{super.key});
  @override Widget build(BuildContext c)=>Card(margin:const EdgeInsets.only(bottom:9),
    child:ListTile(leading:Box(icon),title:Text(title,style:const TextStyle(fontWeight:FontWeight.w800,fontSize:13)),
      subtitle:Text(sub,style:const TextStyle(fontSize:11,color:Colors.grey)),
      trailing:Pill(connected?'Connected':'Setup',connected?Colors.green:Colors.orange)));
}
class Pill extends StatelessWidget{
  final String text; final Color color; const Pill(this.text,this.color,{super.key});
  @override Widget build(BuildContext c)=>Container(padding:const EdgeInsets.symmetric(horizontal:7,vertical:4),
    decoration:BoxDecoration(color:color.withOpacity(.1),borderRadius:BorderRadius.circular(20)),
    child:Text(text,style:TextStyle(color:color,fontSize:9,fontWeight:FontWeight.w800)));
}
class Channel extends StatelessWidget{
  final String a,b,d; const Channel(this.a,this.b,this.d,{super.key});
  @override Widget build(BuildContext c)=>Padding(padding:const EdgeInsets.only(bottom:13),
    child:Row(children:[Expanded(child:Text(a,style:const TextStyle(fontWeight:FontWeight.w600))),
      Text(b,style:const TextStyle(fontWeight:FontWeight.w900)),const SizedBox(width:12),
      Text(d,style:const TextStyle(color:Colors.grey,fontSize:11))]));
}
class ChartPainter extends CustomPainter{
  const ChartPainter();
  @override void paint(Canvas c,Size s){
    final g=Paint()..color=const Color(0xFFE7E7EC)..strokeWidth=1;
    for(int i=1;i<5;i++){final y=s.height*i/5;c.drawLine(Offset(0,y),Offset(s.width,y),g);}
    final p=Paint()..color=pink..strokeWidth=3..style=PaintingStyle.stroke;
    final path=Path()..moveTo(0,s.height*.75)..lineTo(s.width*.15,s.height*.55)
      ..lineTo(s.width*.3,s.height*.65)..lineTo(s.width*.45,s.height*.35)
      ..lineTo(s.width*.6,s.height*.48)..lineTo(s.width*.75,s.height*.2)
      ..lineTo(s.width*.88,s.height*.3)..lineTo(s.width,s.height*.1);
    c.drawPath(path,p);
  }
  @override bool shouldRepaint(covariant CustomPainter old)=>false;
}
void go(BuildContext c,Widget page)=>Navigator.push(c,MaterialPageRoute(builder:(_)=>page));
