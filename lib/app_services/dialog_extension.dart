import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension DialogX on BuildContext {
  Future<void> showBlocDialog({
    required Widget dialog,
    required Cubit cubit,
  }) async {
    return showDialog(
      context: this,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: dialog,
      ),
    );
  }
}
