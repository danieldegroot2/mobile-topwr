import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

import 'config.dart';

final _hiveCacheBoxProvider = Provider((ref) async {
  if (kIsWeb) return GraphQLCache(); // Normal in memory cache
  final box = await HiveStore.open(boxName: ApiBaseConfig.hiveCacheBoxName);
  return GraphQLCache(store: box); // Local persistent on-disk cache with Hive
});

final gqlClientProvider = Provider((ref) async {
  final hiveCache = await ref.watch(_hiveCacheBoxProvider);
  return GraphQLClient(
    cache: hiveCache,
    link: AuthLink(
      getToken: () => ApiBaseConfig.authHeaderPrefix + ApiBaseEnv.apiKey,
    ).concat(
      HttpLink(ApiBaseEnv.apiUrl),
    ),
    defaultPolicies: DefaultPolicies(
      query: Policies(
        fetch: FetchPolicy.networkOnly,
      ),
      watchQuery: Policies(
        fetch: FetchPolicy.cacheAndNetwork,
      ),
    ),
  );
});