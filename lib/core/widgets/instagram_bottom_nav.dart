import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InstagramBottomNav extends StatefulWidget {
  const InstagramBottomNav({super.key});

  @override
  State<InstagramBottomNav> createState() => _InstagramBottomNavState();
}

class _InstagramBottomNavState extends State<InstagramBottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52 + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Color(0xFF262626), width: 0.5)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(icon: 'assets/vectors/home.svg'),
            _NavItem(icon: 'assets/vectors/play_alt.svg'),
            _NavItem(icon: 'assets/vectors/share.svg'),
            _NavItem(icon: 'assets/vectors/search.svg'),
            // Profile icon (custom avatar)
            SizedBox(
              width: 28,
              height: 28,
              child: ClipOval(
                child: Image.network(
                  'https://yavuzceliker.github.io/sample-images/image-1.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      const Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;

  const _NavItem({required this.icon});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      width: 22,
      height: 22,
      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
  }
}
