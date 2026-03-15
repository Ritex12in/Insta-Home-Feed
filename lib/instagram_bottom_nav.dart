import 'package:flutter/material.dart';

class InstagramBottomNav extends StatefulWidget {
  const InstagramBottomNav({super.key});

  @override
  State<InstagramBottomNav> createState() => _InstagramBottomNavState();
}

class _InstagramBottomNavState extends State<InstagramBottomNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52 + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Color(0xFF262626), width: 0.5),
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home,
              isSelected: _selectedIndex == 0,
              onTap: () => setState(() => _selectedIndex = 0),
            ),
            _NavItem(
              icon: Icons.play_circle_outline,
              isSelected: _selectedIndex == 1,
              onTap: () => setState(() => _selectedIndex = 1),
            ),
            _NavItem(
              icon: Icons.send_outlined,
              isSelected: _selectedIndex == 2,
              onTap: () => setState(() => _selectedIndex = 2),
            ),
            _NavItem(
              icon: Icons.search,
              isSelected: _selectedIndex == 3,
              onTap: () => setState(() => _selectedIndex = 3),
            ),
            // Profile icon (custom avatar)
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 4),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _selectedIndex == 4
                        ? Colors.white
                        : Colors.transparent,
                    width: 2,
                  ),
                  color: const Color(0xFF262626),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://yavuzceliker.github.io/sample-images/image-1.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
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
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          color: Colors.white,
          size: 28,
          // Filled style when selected
        ),
      ),
    );
  }
}
