import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/themes/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isExpanded ? 86 : 60, // width for expanded and collapsed states
      color: AppTheme.sidebarColor,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Section: Menu and Icons
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded; // Toggle expanded state
                  });
                },
              ),
              const SizedBox(height: 35),
              _SidebarIcon(
                svgPath: 'assets/images/footer_icons/search.svg',
                label: 'Пошук',
                isExpanded: isExpanded,
              ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/main_icons/favourite.svg',
                label: 'Обране',
                isExpanded: isExpanded,
              ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/main_icons/cart_icon.svg',
                label: 'Кошик',
                isExpanded: isExpanded,
              ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/footer_icons/message.svg',
                label: 'Чат',
                isExpanded: isExpanded,
              ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/footer_icons/add.svg',
                label: 'Продати',
                isExpanded: isExpanded,
              ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/main_icons/notification.svg',
                label: 'Сповіщення',
                isExpanded: isExpanded,
              ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/main_icons/delivery.svg',
                label: 'Доставка',
                isExpanded: isExpanded,
              ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/main_icons/about_us.svg',
                label: 'Про нас',
                isExpanded: isExpanded,
              ),
            ],
          ),

          // Bottom Section: Login
          Column(
            children: [
              _SidebarIcon(
                icon: Icons.login,
                label: 'Увійти',
                isExpanded: isExpanded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Individual Sidebar Icon Widget
class _SidebarIcon extends StatefulWidget {
  final IconData? icon;
  final String? svgPath;
  final String label;
  final bool isExpanded;

  const _SidebarIcon({
    this.icon,
    this.svgPath,
    required this.label,
    required this.isExpanded,
  });
  @override
  State<_SidebarIcon> createState() => _SidebarIconState();
}

class _SidebarIconState extends State<_SidebarIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: isHovered
                  ? AppTheme.sidebarIconsHover // Hover color
                  : AppTheme.progressIndicatorInactive, // Default color
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: widget.icon != null
                    ? Icon(
                        widget.icon,
                        color: isHovered ? AppTheme.splashColor : Colors.black,
                      )
                    : SvgPicture.asset(
                        widget.svgPath!,
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                          isHovered ? AppTheme.splashColor : Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
              ),
            ),
          ),
        ),
        if (widget.isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
      ],
    );
  }
}
