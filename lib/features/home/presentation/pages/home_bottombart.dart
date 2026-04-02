import 'dart:ui';
import 'package:auction_clean_arch/core/routes/app_routes.dart';
import 'package:auction_clean_arch/core/utils/enums.dart';
import 'package:auction_clean_arch/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:auction_clean_arch/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:auction_clean_arch/features/home/presentation/cubit/home_cubit/home_state.dart';
import 'package:auction_clean_arch/features/home/presentation/pages/home.dart';
import 'package:auction_clean_arch/features/post/presentation/cubit/post_cubit.dart';
import 'package:auction_clean_arch/features/setting/presentation/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../favorite/presentation/pages/favorites.dart';
import '../../../notifications/presentation/pages/notifications.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final selectedColor = Theme.of(context).primaryColor;
    final unselectedColor = Colors.grey[600];
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const CustomDrawer(),
          appBar: AppBar(title: Text(titleAppBar[homeCubit.selectIndex])),
          body: screans[homeCubit.selectIndex],
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
              context.push(AppRoutes.addEditPost, extra: PostActionType.create);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const AddEditPost(postAction: PostAction.add,)),
              // );
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: CustomBottomAppBar(
            homeCubit: homeCubit,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
          ),
        );
      },
    );
  }
}

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
    required this.selectedColor,
    required this.unselectedColor,
    required this.homeCubit,
  });

  final Color selectedColor;
  final Color? unselectedColor;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 245, 255, 251),
      height: 65,
      shape: NotchedWithTopBorder(), // لدعم notch للفاب
      notchMargin: 10,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            items.length,
            (index) {
              final isSelected = index == homeCubit.selectIndex;
              // if (index == items.length) {
              //   return SizedBox(width: 45);
              // } else {
              final item = items[index];
              return Expanded(
                child: InkResponse(
                  onTap: () {
                    homeCubit.changedSelectIndex(index);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: const Color.fromARGB(156, 74, 139, 106),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.icon,
                        size: 24,
                        color: isSelected ? selectedColor : unselectedColor,
                      ),
                      // const SizedBox(height: 4),
                      // Text(
                      //   item.label,
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     color: isSelected ? selectedColor : unselectedColor,
                      //     fontWeight:
                      //         isSelected ? FontWeight.w600 : FontWeight.normal,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
            // }
          ),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = Services.user;
    return Align(
      alignment: Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.65, // تصغير العرض أكثر
        child: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(24),
            ), // تغيير الحافة لليسار
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 45,
                  left: 18,
                  right: 18,
                  bottom: 18,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.85),
                    ],
                    begin: Alignment.topRight, // تغيير اتجاه التدرج
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24), // تغيير الحافة العلوية لليسار
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      child: Text(
                        context
                            .read<PostCubit>()
                            .getUserName()
                            .substring(0, 1)
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D6A4F),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.read<PostCubit>().getUserName(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 16,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                context.read<PostCubit>().getUserPhone(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).primaryColor,
                ),
                title: const Text(
                  'الصفحة الرئيسية',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // أضف التنقل المناسب هنا
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).primaryColor,
                ),
                title: const Text(
                  'الإعدادات',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // أضف التنقل المناسب هنا
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.campaign,
                  color: Theme.of(context).primaryColor,
                ),
                title: const Text(
                  'اعلاناتي',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  context.push(AppRoutes.myPosts);
                  // أضف التنقل المناسب هنا
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.brightness_6,
                  color: Theme.of(context).primaryColor,
                ),
                title: const Text(
                  'تغيير الثيم',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text('تسجيل الخروج'),
                  onPressed: () {
                    // context.read<LoginCubit>().logout(context);
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class NotchedWithTopBorder extends CircularNotchedRectangle {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    final path = super.getOuterPath(host, guest);

    // نرسم خط رفيع فوق البار
    final paint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    // نستخدم PathMetrics لعمل خط فوق المسار
    final metrics = path.computeMetrics();
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    canvas.drawPath(path, paint);

    return Path()..addPath(path, Offset.zero);
  }
}

final List<NavItem> items = [
  NavItem(Icons.home, 'الرئيسية'),
  NavItem(Icons.notifications, 'الاشعارات'),
  NavItem(Icons.favorite, 'المفضلة'),
  NavItem(Icons.settings, 'الإعدادات '),
];

class NavItem {
  final IconData icon;
  final String label;
  NavItem(this.icon, this.label);
}

final List<String> titleAppBar = [
  'الصفحة الرئيسية',
  'الاشعارات',
  'المفضلة',
  'الإعدادات',
];
List screans = [Home(), Notifications(), Favorites(), Settings()];
