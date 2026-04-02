import 'package:auction_clean_arch/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: AbsorbPointer(
        absorbing: true, // يمنع أي تفاعل
        child: ColoredBox(
          color: Colors.black54, // خلفية شفافة
          child: Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
