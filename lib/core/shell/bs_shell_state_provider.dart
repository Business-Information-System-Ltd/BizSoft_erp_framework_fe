/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_shell_state_provider.dart
 Purpose      : Riverpod state for the collapsible BizSoft application shell.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter_riverpod/legacy.dart';

class BsShellState {
  const BsShellState({this.isSideMenuExpanded = true});

  final bool isSideMenuExpanded;

  BsShellState copyWith({bool? isSideMenuExpanded}) {
    return BsShellState(isSideMenuExpanded: isSideMenuExpanded ?? this.isSideMenuExpanded);
  }
}

class BsShellStateNotifier extends StateNotifier<BsShellState> {
  BsShellStateNotifier() : super(const BsShellState());

  void toggleSideMenu() {
    state = state.copyWith(isSideMenuExpanded: !state.isSideMenuExpanded);
  }

  void expandSideMenu() {
    state = state.copyWith(isSideMenuExpanded: true);
  }

  void collapseSideMenu() {
    state = state.copyWith(isSideMenuExpanded: false);
  }
}

final bsShellStateProvider = StateNotifierProvider<BsShellStateNotifier, BsShellState>((ref) {
  return BsShellStateNotifier();
});