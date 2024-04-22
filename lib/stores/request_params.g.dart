// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_params.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaginationStore on _PaginationStoreBase, Store {
  Computed<ApiRequestParams>? _$paramsComputed;

  @override
  ApiRequestParams get params =>
      (_$paramsComputed ??= Computed<ApiRequestParams>(() => super.params,
              name: '_PaginationStoreBase.params'))
          .value;

  late final _$paginationAtom =
      Atom(name: '_PaginationStoreBase.pagination', context: context);

  @override
  ApiPagination get pagination {
    _$paginationAtom.reportRead();
    return super.pagination;
  }

  @override
  set pagination(ApiPagination value) {
    _$paginationAtom.reportWrite(value, super.pagination, () {
      super.pagination = value;
    });
  }

  @override
  String toString() {
    return '''
pagination: ${pagination},
params: ${params}
    ''';
  }
}
