import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:mongo_dart/mongo_dart.dart';

Future<void> main() async {
  // MongoDB 연결 (Atlas 또는 로컬 주소로 교체)
  final db = await Db.create(
      'mongodb+srv://flutteruser:flutter123@jimmy.a1oa17t.mongodb.net/ratings_db');
  await db.open();
  final ratings = db.collection('ratings');

  final router = Router();

  // POST /api/rating : 별점 저장
  router.post('/api/rating', (Request request) async {
    final body = await request.readAsString();
    final data = jsonDecode(body);
    final albumId = data['albumId'];
    final stars = data['stars'];

    if (albumId == null || stars == null) {
      return Response(400, body: jsonEncode({'error': 'Invalid request'}));
    }

    await ratings.insertOne({
      'albumId': albumId,
      'stars': stars,
      'timestamp': DateTime.now().toIso8601String(),
    });

    return Response.ok(jsonEncode({'status': 'saved'}));
  });

  // GET /api/rating/<albumId> : 가장 최근 별점 조회
  router.get('/api/rating/<albumId>', (Request request, String albumId) async {
    final doc = await ratings.findOne(
      where.eq('albumId', albumId).sortBy('timestamp', descending: true),
    );

    if (doc == null) {
      return Response.ok(jsonEncode({'albumId': albumId, 'stars': null}));
    }

    return Response.ok(jsonEncode({
      'albumId': albumId,
      'stars': doc['stars'],
    }));
  });

  // 서버 실행
  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(router);

  final server = await io.serve(handler, 'localhost', 8080);
  print('🚀 Mongo API server running on http://localhost:8080');
}
