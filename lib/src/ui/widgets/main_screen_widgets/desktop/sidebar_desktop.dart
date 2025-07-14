import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/screens/welcome_page_screens/welcome_screen.dart';
import 'package:flutter_application_1/src/ui/themes/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../services/auth_storage.dart';

class SidebarWidget extends StatefulWidget {
  final Function(String) onMenuItemSelected;

  const SidebarWidget({super.key, required this.onMenuItemSelected});

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  bool isExpanded = false;
  String selectedMenuItem = 'home';

  Future<void> _logout(BuildContext context) async {
    try {
      await AuthStorage.deleteTokens();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  Future<bool> _isUserLoggedIn() async {
    String? token = await AuthStorage.getAccessToken();
    return token != null;
  }

  void _selectMenuItem(String menuItem) {
    setState(() {
      selectedMenuItem = menuItem;
    });
    widget.onMenuItemSelected(menuItem);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isExpanded ? 86 : 60,
      color: AppTheme.sidebarColor,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
              const SizedBox(height: 35),
              // _SidebarIcon(
              //   svgPath: 'assets/images/footer_icons/search.svg',
              //   label: 'Пошук',
              //   isExpanded: isExpanded,
              //   onTap: () => widget.onMenuItemSelected('search'),
              // ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/main_icons/favourite.svg',
                label: 'Обране',
                isExpanded: isExpanded,
                isActive: selectedMenuItem == 'favorites',
                onTap: () => _selectMenuItem('favorites'),
              ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/main_icons/cart_icon.svg',
                label: 'Кошик',
                isExpanded: isExpanded,
                isActive: selectedMenuItem == 'cart',
                onTap: () => _selectMenuItem('cart'),
              ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/footer_icons/message.svg',
                label: 'Чат',
                isExpanded: isExpanded,
                isActive: selectedMenuItem == 'chat',
                onTap: () => _selectMenuItem('chat'),
              ),
              const SizedBox(height: 10),
              // _SidebarIcon(
              //   svgPath: 'assets/images/footer_icons/add.svg',
              //   label: 'Продати',
              //   isExpanded: isExpanded,
              //   isActive: selectedMenuItem == 'sell',
              //   onTap: () => _selectMenuItem('sell'),
              // ),
              FutureBuilder<bool>(
                future: _isUserLoggedIn(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  } else if (snapshot.hasData && snapshot.data == true) {
                    return Column(
                      children: [
                        _SidebarIcon(
                          svgPath: 'assets/images/footer_icons/add.svg',
                          label: 'Продати',
                          isExpanded: isExpanded,
                          isActive: selectedMenuItem == 'sell',
                          onTap: () => _selectMenuItem('sell'),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              _SidebarIcon(
                svgPath: 'assets/images/main_icons/notification.svg',
                label: 'Сповіщення',
                isExpanded: isExpanded,
                isActive: selectedMenuItem == 'notifications',
                onTap: () => _selectMenuItem('notifications'),
              ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/main_icons/delivery.svg',
                label: 'Доставка',
                isExpanded: isExpanded,
                isActive: selectedMenuItem == 'delivery',
                onTap: () => _selectMenuItem('delivery'),
              ),
              const SizedBox(height: 10),
              _SidebarIcon(
                svgPath: 'assets/images/main_icons/about_us.svg',
                label: 'Про нас',
                isExpanded: isExpanded,
                isActive: selectedMenuItem == 'about',
                onTap: () => _selectMenuItem('about'),
              ),
            ],
          ),
          FutureBuilder<bool>(
            future: _isUserLoggedIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data == true) {
                return _SidebarIcon(
                    icon: Icons.login,
                    label: 'Вийти',
                    isExpanded: isExpanded,
                    isActive: false,
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.6),
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: const Center(
                            child: Text(
                              'Вийти з акаунту',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          content: const Text(
                            'Ви впевнені, що хочете вийти?',
                            textAlign: TextAlign.center,
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            SizedBox(
                              width: 150,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      AppTheme.progressIndicatorActive,
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: const Text(
                                  'Назад',
                                  style: TextStyle(color: AppTheme.witeText),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppTheme.textError,
                                  side: const BorderSide(
                                      color: Colors.transparent),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  _logout(context);
                                },
                                child: const Text(
                                  'Вийти',
                                  style: TextStyle(color: AppTheme.witeText),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                      return;
                    });
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _SidebarIcon extends StatefulWidget {
  final IconData? icon;
  final String? svgPath;
  final String label;
  final bool isExpanded;
  final bool isActive;
  final VoidCallback? onTap;

  const _SidebarIcon({
    this.icon,
    this.svgPath,
    required this.label,
    required this.isExpanded,
    this.isActive = false,
    this.onTap,
  });
  @override
  State<_SidebarIcon> createState() => _SidebarIconState();
}

class _SidebarIconState extends State<_SidebarIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Color backgroundColor = widget.isActive
    //     ? const Color(0xFFFFE0AD) // Active color
    //     : isHovered
    //         ? AppTheme.sidebarIconsHover
    //         : AppTheme.progressIndicatorInactive;
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: widget.isActive
                      ? const Color(0xFFFFE0AD)
                      : (isHovered
                          ? AppTheme.sidebarIconsHover
                          : AppTheme.progressIndicatorInactive),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: widget.icon != null
                        ? Icon(
                            widget.icon,
                            color: _getIconColor(),
                          )
                        : SvgPicture.asset(
                            widget.svgPath!,
                            height: 24,
                            width: 24,
                            colorFilter: ColorFilter.mode(
                              _getIconColor(),
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                )),
          ),
        ),
        if (widget.isExpanded)
          Text(
            widget.label,
            style: const TextStyle(fontSize: 12),
          ),
      ],
    );
  }

  Color _getIconColor() {
    return (widget.isActive || isHovered) ? AppTheme.splashColor : Colors.black;
  }
}
