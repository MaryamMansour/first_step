import 'package:bloc/bloc.dart';

enum HomeTab { home, chats, add, chatbot, account }

class HomeCubit extends Cubit<HomeTab> {
  HomeCubit() : super(HomeTab.home);

  void selectTab(HomeTab tab) => emit(tab);
}
