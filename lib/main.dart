import 'admin_home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const KStoreAdmin());

class KStoreAdmin extends StatelessWidget {
  const KStoreAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'K - Store Admin Panel',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF20B4F)),
        scaffoldBackgroundColor: const Color(0xFFFFF9FC),
      ),
      home: const AdminLoginPage(),
    );
  }
}

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final formKey = GlobalKey<FormState>();
  final user = TextEditingController();
  final pass = TextEditingController();

  bool hidePassword = true;
  bool remember = true;
  bool loading = false;

  static const pink = Color(0xFFF20B4F);
  static const dark = Color(0xFF111318);
  static const grey = Color(0xFF6E7480);
  static const Duration _sessionDuration = Duration(days: 7);
  bool _restoringSession = true;

  @override
  void initState() {
    super.initState();
    user.text = 'admin@kstore.com';
    _restoreLoginSession();
  }

  Future<void> _restoreLoginSession() async {
    final prefs = await SharedPreferences.getInstance();
    final expiry = prefs.getInt('admin_session_expiry') ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    if (expiry > now) {
      if (!mounted) return;
      setState(() => _restoringSession = false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminHomePage()),
        );
      });
      return;
    }

    if (expiry != 0) {
      await prefs.remove('admin_session_expiry');
    }

    if (mounted) {
      setState(() => _restoringSession = false);
    }
  }


  @override
  void dispose() {
    user.dispose();
    pass.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    const String adminLoginId = 'admin@kstore.com';
    const String adminPassword = 'Kstore@admin786';

    final enteredLoginId = user.text.trim();
    final enteredPassword = pass.text;

    if (enteredLoginId != adminLoginId ||
        enteredPassword != adminPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Login ID or Password'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    if (remember) {
      final expiry = DateTime.now().add(_sessionDuration).millisecondsSinceEpoch;
      await prefs.setInt('admin_session_expiry', expiry);
    } else {
      await prefs.remove('admin_session_expiry');
    }

    setState(() => loading = true);

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;

      setState(() => loading = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminHomePage(),
        ),
      );
    });
  }

  void forgotPassword() {
    final email = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (sheet) => Padding(
        padding: EdgeInsets.fromLTRB(
          24, 24, 24, MediaQuery.of(sheet).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Forgot Password?',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text(
              'Enter your registered email to receive reset instructions.',
              style: TextStyle(color: grey),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email address',
                prefixIcon: const Icon(Icons.email_outlined),
                filled: true,
                fillColor: const Color(0xFFF7F7F9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(sheet);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password reset request submitted.'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: pink,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Send Reset Link',
                    style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_restoringSession) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            left: -70,
            right: -70,
            bottom: -55,
            height: 150,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFFFFD6E5),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Column(
                    children: [
                      const _Hero(),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 22),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.07),
                              blurRadius: 26,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Welcome Back!',
                                style: TextStyle(
                                  fontSize: 29,
                                  fontWeight: FontWeight.w900,
                                  color: dark,
                                ),
                              ),
                              const SizedBox(height: 7),
                              const Text(
                                'Login to your K - Store Admin Panel',
                                style: TextStyle(
                                  color: grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 23),
                              _Field(
                                controller: user,
                                hint: 'Email or Username',
                                icon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                validator: (v) => v == null || v.trim().isEmpty
                                    ? 'Please enter email or username'
                                    : null,
                              ),
                              const SizedBox(height: 13),
                              _Field(
                                controller: pass,
                                hint: 'Password',
                                icon: Icons.lock_outline_rounded,
                                obscure: hidePassword,
                                suffix: IconButton(
                                  onPressed: () => setState(
                                      () => hidePassword = !hidePassword),
                                  icon: Icon(
                                    hidePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: grey,
                                  ),
                                ),
                                validator: (v) => v == null || v.isEmpty
                                    ? 'Please enter password'
                                    : null,
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        setState(() => remember = !remember),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 23,
                                          height: 23,
                                          decoration: BoxDecoration(
                                            color: remember
                                                ? pink
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                              color: remember
                                                  ? pink
                                                  : const Color(0xFFD8D9DE),
                                              width: 1.5,
                                            ),
                                          ),
                                          child: remember
                                              ? const Icon(Icons.check,
                                                  size: 17,
                                                  color: Colors.white)
                                              : null,
                                        ),
                                        const SizedBox(width: 9),
                                        const Text(
                                          'Remember me',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: forgotPassword,
                                    style: TextButton.styleFrom(
                                      foregroundColor: pink,
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 17),
                              SizedBox(
                                width: double.infinity,
                                height: 57,
                                child: ElevatedButton(
                                  onPressed: loading ? null : login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: pink,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: loading
                                      ? const SizedBox(
                                          width: 23,
                                          height: 23,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Login',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w900)),
                                            SizedBox(width: 12),
                                            Icon(Icons.arrow_forward_rounded,
                                                size: 25),
                                          ],
                                        ),
                                ),
                              ),
                              const SizedBox(height: 19),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        '© 2026 K - Store. All rights reserved.',
                        style: TextStyle(color: Color(0xFF8A8F99), fontSize: 12),
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 285,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF8FB), Color(0xFFFFEEF4)],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -50,
            bottom: -75,
            child: Container(
              width: 520,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFF20B4F),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            left: -55,
            bottom: -94,
            child: Container(
              width: 520,
              height: 82,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 28,
            child: Row(
              children: [
                Container(
                  width: 67,
                  height: 67,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF496F), Color(0xFFC90055)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text('K',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w900)),
                  ),
                ),
                const SizedBox(width: 14),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('K - Store',
                        style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w900)),
                    Text('Admin Panel',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFF20B4F),
                            fontWeight: FontWeight.w900)),
                  ],
                ),
              ],
            ),
          ),
          const Positioned(
            left: 25,
            top: 117,
            child: Text('Manage Your Business Easily',
                style: TextStyle(
                    color: Color(0xFF5F6570),
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          const Positioned(
            right: 18,
            bottom: 38,
            child: _DashboardArt(),
          ),
          const Positioned(
            right: 132,
            top: 30,
            child: _Bubble(Icons.shopping_cart_outlined, Color(0xFFF20B4F)),
          ),
          const Positioned(
            right: 57,
            top: 68,
            child: _Bubble(Icons.inventory_2_outlined, Color(0xFFFFB22E)),
          ),
          const Positioned(
            right: 13,
            bottom: 96,
            child: _Bubble(Icons.bar_chart_rounded, Color(0xFF12B878)),
          ),
        ],
      ),
    );
  }
}

class _DashboardArt extends StatelessWidget {
  const _DashboardArt();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 150,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            bottom: 10,
            child: Container(
              width: 215,
              height: 125,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: ColoredBox(
                        color: Color(0xFF252A34),
                        child: Column(
                          children: [
                            SizedBox(height: 9),
                            CircleAvatar(
                                radius: 6, backgroundColor: Color(0xFFF20B4F)),
                            SizedBox(height: 10),
                            Icon(Icons.dashboard_rounded,
                                size: 12, color: Colors.white),
                            SizedBox(height: 8),
                            Icon(Icons.shopping_bag_rounded,
                                size: 12, color: Colors.white54),
                            SizedBox(height: 8),
                            Icon(Icons.people_rounded,
                                size: 12, color: Colors.white54),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dashboard',
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(height: 7),
                            Row(children: [
                              Expanded(child: _MiniBox()),
                              SizedBox(width: 5),
                              Expanded(child: _MiniBox()),
                            ]),
                            SizedBox(height: 7),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _Bar(22),
                                  _Bar(37),
                                  _Bar(29),
                                  _Bar(51),
                                  _Bar(42),
                                  _Bar(61),
                                  _Bar(47),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 62,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFF273142),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(22),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBox extends StatelessWidget {
  const _MiniBox();

  @override
  Widget build(BuildContext context) => Container(
        height: 34,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Row(
          children: [
            SizedBox(width: 6),
            Icon(Icons.circle, size: 6, color: Color(0xFFF20B4F)),
            SizedBox(width: 4),
            Icon(Icons.trending_up_rounded,
                size: 10, color: Color(0xFF6D7480)),
          ],
        ),
      );
}

class _Bar extends StatelessWidget {
  final double h;
  const _Bar(this.h);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: h,
            decoration: BoxDecoration(
              color: const Color(0xFFF20B4F),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      );
}

class _Bubble extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _Bubble(this.icon, this.color);

  @override
  Widget build(BuildContext context) => Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(.25),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      );
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final Widget? suffix;
  final bool obscure;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _Field({
    required this.controller,
    required this.hint,
    required this.icon,
    this.suffix,
    this.obscure = false,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF858B96)),
          prefixIcon: Icon(icon, color: const Color(0xFF69717D), size: 27),
          suffixIcon: suffix,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE0E2E7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFF20B4F), width: 1.5),
          ),
        ),
      );
}
