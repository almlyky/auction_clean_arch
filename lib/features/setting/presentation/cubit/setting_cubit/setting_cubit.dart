import 'package:auction_clean_arch/features/home/data/repo/setting_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  final SettingRepo _settingRepo;
  SettingCubit(this._settingRepo) : super(SettingInitial()) {
    getCurentTheme();
  }

  void getCurentTheme() {
    bool? isDark = _settingRepo.getTheme();
    ThemeMode themeMode;
    if (isDark == null) {
      themeMode = ThemeMode.system;
    } else {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    }
    emit(ThemeChanged(themeMode));
  }

  void toggleTheme() async {
    ThemeMode newThemeMode;
    bool isDark = (state as ThemeChanged).themeMode == ThemeMode.dark
        ? true
        : false;
    newThemeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    await _settingRepo.saveTheme(isDark);
    emit(ThemeChanged(newThemeMode));
  }
}
