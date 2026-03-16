import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InstagramTopBar extends StatelessWidget implements PreferredSizeWidget {
  const InstagramTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [

            Icon(
              Icons.add,
              size: 28.0,
              color: Colors.white,
            ),

            const Spacer(),
            SvgPicture.asset(
              'assets/vectors/insta_top_vector.svg',
              height: 28,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),

            const SizedBox(width: 4.0,),

            const Icon(Icons.keyboard_arrow_down,
                color: Colors.white, size: 22),

            const Spacer(),

            Icon(Icons.favorite_border,
                color: Colors.white, size: 28)
          ],
        ),
      ),
    );
  }
}
