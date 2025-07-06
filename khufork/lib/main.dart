import 'package:flutter/cupertino.dart';

void main() {
  runApp(const KhuFork());
}

class KhuFork extends StatelessWidget {
  const KhuFork({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(title: 'KhuFork', home: MainTabScaffold());
  }
}

/// ---------------------- Maintab ----------------------

class MainTabScaffold extends StatelessWidget {
  const MainTabScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.headphones,
            ), // headphone, music_note) // 아이콘은 변경하지 말것
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bell), // 아이콘은 변경하지 말것
            label: 'Actives',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_albums), // 아이콘은 변경하지 말것
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search), // 아이콘은 변경하지 말것
            label: 'Search',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        late final Widget page;

        switch (index) {
          case 0:
            page = const MusicPage();
            break;
          case 1:
            page = const FeedsPage();
            break;
          case 2:
            page = const LibraryPage();
            break;
          case 3:
            page = const SearchPage();
            break;
          default:
            page = const Center(child: Text('Unknown Tab'));
        }

        return CupertinoTabView(
          builder: (BuildContext context) => CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('KhuFork', style: TextStyle(fontSize: 20)),
            ),
            child: SafeArea(child: page),
          ),
        );
      },
    );
  }
}

/// ---------------------- Pages ----------------------

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  Widget _buildLargeTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Text(
        title,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 추천 플레이리스트 행
  Widget _buildRecommendMusicRow(String title) {
    final List<Map<String, dynamic>> cardData = <Map<String, dynamic>>[
      {
        'title': '4~5 star mix',
        'subtitle': 'Charli xcx, Kanye West, Daft Punk',
        'color': const Color(0xFFFFE0DC),
      },
      {
        'title': "Friend's mix",
        'subtitle': 'Shared by noej95, s.ahku, leiple',
        'color': const Color(0xFFDCEEFF),
      },
      {
        'title': 'Hiphop mix',
        'subtitle': 'Drake, Travis Scott',
        'color': const Color(0xFFE5FFDC),
      },
      {
        'title': 'Top 100 songs',
        'subtitle': 'Global trends',
        'color': const Color(0xFFFFF2DC),
      },
      {
        'title': 'Trend mix',
        'subtitle': 'New & viral',
        'color': const Color(0xFFE9DCFF),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 232,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: cardData.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> data = cardData[index];

              return RecommendationCard(
                title: data['title'] as String,
                subtitle: data['subtitle'] as String,
                backgroundColor: data['color'] as Color,
                icon: CupertinoIcons.music_note,
              );
            },
          ),
        ),
      ],
    );
  }

  // 최근 재생 앨범 행
  Widget _buildRecentlyPlayedRow() {
    final List<Map<String, dynamic>> albumList = <Map<String, dynamic>>[
      {
        'albumTitle': 'Brat',
        'artist': 'Charli XCX',
        'color': const Color(0xFFFFDCDC),
      },
      {
        'albumTitle': 'Midnights',
        'artist': 'Taylor Swift',
        'color': const Color(0xFFDCF3FF),
      },
      {
        'albumTitle': 'Utopia',
        'artist': 'Travis Scott',
        'color': const Color(0xFFE6FFD7),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Recently Played',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemRed,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 232,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: albumList.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> album = albumList[index];
              return AlbumInfoCard(
                albumTitle: album['albumTitle'] as String,
                artist: album['artist'] as String,
                backgroundColor: album['color'] as Color,
                icon: CupertinoIcons.music_albums,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            _buildLargeTitle("Today's Music"), // 큰 제목 텍스트
            _buildRecommendMusicRow("Recommend"),
            _buildRecentlyPlayedRow(),
            const SizedBox(height: 24),
            CupertinoButton(
              child: const Text('Go to Player'),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute<void>(builder: (_) => const PlayerPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FeedsPage extends StatelessWidget {
  const FeedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Feeds Page'));
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Library Page'));
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search Page'));
  }
}

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Player')),
      child: Center(child: Text('Player Page')),
    );
  }
}

class AlbumInfoPage extends StatelessWidget {
  const AlbumInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('KhuFork')),
      child: SafeArea(
        child: Column(
          children: [
            // 상단 아이콘 행
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(CupertinoIcons.back, size: 28),
                  ),
                  const Spacer(),
                  const Icon(CupertinoIcons.share, size: 24),
                ],
              ),
            ),

            // 앨범 이미지
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Container(
                  width: 210,
                  height: 210,
                  color: CupertinoColors.activeGreen, // 임시 색상
                  alignment: Alignment.center,
                  child: const Text(
                    'brat',
                    style: TextStyle(
                      fontSize: 32,
                      color: CupertinoColors.black,
                    ),
                  ),
                ),
              ),
            ),

            // 앨범 정보 (제목 + 아티스트)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 52,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'BRAT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Charli XCX',
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 별점 표시
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SizedBox(
                width: 217,
                child: const Center(
                  child: Text(
                    '★★★★★',
                    style: TextStyle(
                      fontSize: 40,
                      color: CupertinoColors.black,
                    ),
                  ),
                ),
              ),
            ),

            // (아래에 다른 내용 추가 가능)
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

/// ---------------------- Items ----------------------

// 재생목록 정보
class RecommendationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final IconData icon;

  const RecommendationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      height: 232,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: CupertinoColors.systemBackground,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 앨범/아이콘 영역
          Container(
            height: 148,
            width: 148,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Icon(icon, size: 64, color: CupertinoColors.black),
            ),
          ),
          // 텍스트 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: CupertinoColors.systemGrey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// 앨범 정보 카드
class AlbumInfoCard extends StatelessWidget {
  final String albumTitle;
  final String artist;
  final Color backgroundColor;
  final IconData icon;

  const AlbumInfoCard({
    super.key,
    required this.albumTitle,
    required this.artist,
    required this.backgroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute<void>(
            builder: (_) => const AlbumInfoPage(),
          ),
        );
      },
      child: Container(
        width: 148,
        height: 232,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CupertinoColors.systemBackground,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 148,
              width: 148,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Icon(icon, size: 64, color: CupertinoColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                albumTitle,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                artist,
                style: const TextStyle(
                  fontSize: 13,
                  color: CupertinoColors.systemGrey,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

