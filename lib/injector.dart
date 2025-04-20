import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycling_app/data/data/repositories/firestore_impl_repo.dart';
import 'package:recycling_app/data/domain/repositories/firestore_repo.dart';

import 'data/data/datasources/firestore_services.dart';

class Injector extends StatelessWidget {
  final Widget child;

  const Injector({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        ..._getAuthRepo(),
      ],
      child: child,
    );
  }

  List<RepositoryProvider> _getAuthRepo() => [
        RepositoryProvider<FirestoreServices>(
          create: (context) => FirestoreServices(),
        ),
        RepositoryProvider<FirestoreRepo>(
          create: (context) => FirestoreImplRepo(
            firestoreDataSource: context.read(),
          ),
        ),
      ];
}
