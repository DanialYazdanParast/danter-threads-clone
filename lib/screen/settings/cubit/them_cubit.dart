import 'package:bloc/bloc.dart';
import 'package:danter/core/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'them_state.dart';

class ThemCubit extends Cubit<ThemState> {
  ThemCubit() : super(ThemInitial());
  static final SharedPreferences sharedPreferences = locator.get();
  bool _isDark = false;
  bool get isDark => sharedPreferences.getBool("them") ?? false;
  void changeThem() {
    _isDark = !_isDark;
    sharedPreferences.setBool("them", _isDark);
    emit(ThemChanged());
  }
}
