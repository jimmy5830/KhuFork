# khufork

A new Flutter project.

## Getting Started

KhuFork는 Flutter로 제작된 간단한 음악 스트리밍 앱입니다. 별점 시스템을 포함하며,
Dart 기반 서버와 연동되어 사용자의 평점을 저장하고 조회할 수 있습니다.

## Root

root/
├── server/ # Dart로 작성된 백엔드 서버
└── khufork/ # Flutter 기반 모바일 클라이언트

server 폴더에서 Dart 서버를 실행 후 khufork 폴더에서 Flutter 앱을 실행해야 합니다.

## 서버 API 요약

POST /api/rating
→ 사용자의 앨범 별점을 서버에 저장

GET /api/rating/<albumId>
→ 해당 앨범의 가장 최근 별점 조회

## 의존성

Flutter SDK

Dart SDK

MongoDB (Atlas 또는 로컬)

http, shelf, shelf_router, mongo_dart 등

## 참고

server.dart는 user.json 또는 MongoDB를 통해 데이터를 저장/조회합니다.

클라이언트는 서버 주소를 localhost:8080으로 사용하므로, 실제 배포 시에는 URL을 적절히 수정해야 합니다.
