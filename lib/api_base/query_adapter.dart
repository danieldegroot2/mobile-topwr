import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:graphql/client.dart";

import "../config/ttl_config.dart";
import "gql_client_provider.dart";
import "ttl/ttl_service.dart";

class GqlOfflineException implements Exception {
  const GqlOfflineException(this.ttlKey);
  final TtlKey ttlKey;

  static Future<QueryResult<T>> graphqlTryCatch<T>(
    QueryResult<T> event,
    TtlKey ttlKey,
  ) async {
    if (!event.hasException) return event;

    if (event.exception?.linkException != null) {
      // wait, just to show loading on the ui for a little while
      await Future.delayed(const Duration(milliseconds: 300));
      throw GqlOfflineException(ttlKey);
    }

    throw Exception(
      event.exception,
    ); //rethrow GraphQL Errors as not silent ones
  }
}

extension TTLQueryAdapterX on AutoDisposeFutureProviderRef {
  Future<T?> queryGraphql<T>(
    QueryOptions<T> queryOptions,
    TtlKey ttlKey,
  ) async {
    final apiClient = await watch(gqlClientProvider);
    final ttlService = ttlServiceProvider.call(ttlKey);
    final ttlFetchPolicy = await watch(ttlService.future);
    final newOptions = queryOptions.copyWithFetchPolicy(ttlFetchPolicy);

    final rawResults = await apiClient.query(newOptions);
    final safeResults =
        await GqlOfflineException.graphqlTryCatch(rawResults, ttlKey);
    await read(ttlService.notifier).interceptAndSaveTimestamps(safeResults);
    return safeResults.parsedData;
  }
}