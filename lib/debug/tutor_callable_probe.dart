import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

Future<void> runTutorCallableProbe() async {
  if (!kDebugMode) {
    return;
  }

  debugPrint('TUTOR_PROBE start');

  try {
    await FirebaseAuth.instance.signOut();

    final credential = await FirebaseAuth.instance.signInAnonymously().timeout(
      const Duration(seconds: 8),
    );

    final user = credential.user;

    if (user == null) {
      debugPrint('TUTOR_PROBE auth=MISSING');
      return;
    }

    debugPrint('TUTOR_PROBE auth=READY');

    final idToken = await user
        .getIdToken(true)
        .timeout(const Duration(seconds: 8));

    debugPrint(
      'TUTOR_PROBE auth_token=${idToken == null || idToken.isEmpty ? "MISSING" : "READY"}',
    );
  } catch (error) {
    debugPrint('TUTOR_PROBE auth_error=$error');
    return;
  }

  try {
    final appCheckToken = await FirebaseAppCheck.instance
        .getToken(true)
        .timeout(const Duration(seconds: 8));

    debugPrint(
      'TUTOR_PROBE appcheck=${appCheckToken == null || appCheckToken.isEmpty ? "MISSING" : "READY"}',
    );
  } catch (error) {
    debugPrint('TUTOR_PROBE appcheck_error=$error');
    return;
  }

  try {
    final callable = FirebaseFunctions.instanceFor(
      region: 'us-central1',
    ).httpsCallable('tutor');

    await callable
        .call(<String, dynamic>{
          'schemaVersion': '1.0',
          'probeExtraField': true,
        })
        .timeout(const Duration(seconds: 10));

    debugPrint('TUTOR_PROBE unexpected_success');
  } on FirebaseFunctionsException catch (error) {
    debugPrint(
      'TUTOR_PROBE functions_error '
      'code=${error.code} message=${error.message}',
    );
  } catch (error) {
    debugPrint('TUTOR_PROBE error=$error');
  }
}
