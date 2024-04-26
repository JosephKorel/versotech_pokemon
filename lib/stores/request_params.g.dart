// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_params.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaginationStore on _PaginationStoreBase, Store {
  Computed<ApiPagination>? _$paginationComputed;

  @override
  ApiPagination get pagination =>
      (_$paginationComputed ??= Computed<ApiPagination>(
        () => super.pagination,
        name: '_PaginationStoreBase.pagination',
      ))
          .value;

  late final _$paramsAtom =
      Atom(name: '_PaginationStoreBase.params', context: context);

  @override
  PokemonListRequest get params {
    _$paramsAtom.reportRead();
    return super.params;
  }

  @override
  set params(PokemonListRequest value) {
    _$paramsAtom.reportWrite(value, super.params, () {
      super.params = value;
    });
  }

  late final _$_PaginationStoreBaseActionController =
      ActionController(name: '_PaginationStoreBase', context: context);

  @override
  void nextPage() {
    final _$actionInfo = _$_PaginationStoreBaseActionController.startAction(
      name: '_PaginationStoreBase.nextPage',
    );
    try {
      return super.nextPage();
    } finally {
      _$_PaginationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_PaginationStoreBaseActionController.startAction(
      name: '_PaginationStoreBase.reset',
    );
    try {
      return super.reset();
    } finally {
      _$_PaginationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
params: ${params},
pagination: ${pagination}
    ''';
  }
}
