import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../shared_api_clients/sks_api_client.dart";
import "../../../../utils/ref_extensions.dart";
import "../models/sks_user_data.dart";
import "../sks_people_live_consts.dart";

part "latest_sks_user_data_repo.g.dart";

@riverpod
Future<SksUserData> getLatestSksUserData(Ref ref) async {
  final dio = ref.read(sksClientProvider);
  const latestDataEndpoint = "/sks-users/current/";
  final response = await dio.get(latestDataEndpoint);
  final sksData = SksUserData.fromJson(response.data as Map<String, dynamic>);

  final currentTime = DateTime.now();
  final sksRefreshInterval = sksData.isResultRecent
      ? sksData.nextUpdateTimestamp.difference(currentTime)
      : SksPeopleRepositoryConfig.defaultSksRefreshTime;

  ref.setRefresh(sksRefreshInterval);

  return sksData;
}
