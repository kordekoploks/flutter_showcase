import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/images.dart';
import '../../core/error/failures.dart';
import '../../l10n/gen_l10n/app_localizations.dart';

class ErrorState extends StatelessWidget {
  final Failure failure;
  final VoidCallback onRetry;

  const ErrorState({
    Key? key,
    required this.failure,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final (message, image) = switch (failure) {
      NetworkFailure() => (l10n.networkFailurenTryAgain, kNoConnection),
      ServerFailure() => (l10n.internalServerError, kInternalServerError),
      CacheFailure() => (l10n.noConnection, kNoConnection),
      _ => (l10n.productNotFound, kEmpty),
    };

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
