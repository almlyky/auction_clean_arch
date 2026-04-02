import 'package:auction_clean_arch/features/favorite/presentation/pages/favorites.dart';
import 'package:auction_clean_arch/features/home/presentation/cubit/home_cubit/home_state.dart';
import 'package:auction_clean_arch/features/home/presentation/pages/home.dart';
import 'package:auction_clean_arch/features/setting/presentation/pages/settings.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../notifications/presentation/pages/notifications.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int selectIndex = 0;
  void changedSelectIndex(int index) {
    selectIndex = index;
    emit(HomeInitial());
    emit(ChangedSelectIndex());
  }
}
