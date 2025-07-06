import 'package:flutter/cupertino.dart';

void main() {
  runApp(khuFork());
}

class khuFork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(title: 'KhuFork', home: MainTabScaffold());
  }
}

/// ---------------------- Maintab ----------------------

class MainTabScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
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
      tabBuilder: (context, index) {
        late final Widget page;

        switch (index) {
          case 0:
            page = MusicPage();
            break;
          case 1:
            page = FeedsPage();
            break;
          case 2:
            page = LibraryPage();
            break;
          case 3:
            page = SearchPage();
            break;
          default:
            page = Center(child: Text('Unknown Tab'));
        }

        return CupertinoTabView(
          builder: (context) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
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
  Widget _buildLargeTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Text(
        title,
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 추천 플레이리스트 행 
  Widget _buildRecommendMusicRow(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
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
          itemCount: 5,
          itemBuilder: (context, index) {
            final cardData = [
              {
                'title': '4~5 star mix',
                'subtitle': 'Charli xcx, Kanye West, Daft Punk',
                'color': Color(0xFFFFE0DC),
              },
              {
                'title': "Friend's mix",
                'subtitle': 'Shared by noej95, s.ahku, leiple',
                'color': Color(0xFFDCEEFF),
              },
              {
                'title': 'Hiphop mix',
                'subtitle': 'Drake, Travis Scott',
                'color': Color(0xFFE5FFDC),
              },
              {
                'title': 'Top 100 songs',
                'subtitle': 'Global trends',
                'color': Color(0xFFFFF2DC),
              },
              {
                'title': 'Trend mix',
                'subtitle': 'New & viral',
                'color': Color(0xFFE9DCFF),
              },
            ];

            final data = cardData[index];

            return RecommendationCard(
              title: data['title'] as String,
              subtitle: data['subtitle'] as String,
              backgroundColor: data['color'] as Color,
              icon: CupertinoIcons.music_note,
      );
    },
  ),
)

    ],
  );
}
 // 최근 재생 앨범 행
Widget _buildRecentlyPlayedRow() {
  final albumList = [
    {
      'albumTitle': 'Dawn FM',
      'artist': 'The Weeknd',
      'color': Color(0xFFFFDCDC),
    },
    {
      'albumTitle': 'Midnights',
      'artist': 'Taylor Swift',
      'color': Color(0xFFDCF3FF),
    },
    {
      'albumTitle': 'Utopia',
      'artist': 'Travis Scott',
      'color': Color(0xFFE6FFD7),
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recently Played',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'See All',
              style: TextStyle(fontSize: 14, color: CupertinoColors.systemRed),
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
          itemBuilder: (context, index) {
            final album = albumList[index];
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
          children: [
            _buildLargeTitle("Today's Music"), // 큰 제목 텍스트
            _buildRecommendMusicRow("Recommend"),
            _buildRecentlyPlayedRow(),
            SizedBox(height: 24),
            CupertinoButton(
              child: Text('Go to Player'),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => PlayerPage()),
                );
              },
            ),
            CupertinoButton(
              child: Text('Go to Album Info'),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => AlbumInfoPage()),
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
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Feeds Page'));
  }
}

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Library Page'));
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Search Page'));
  }
}

class PlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Player')),
      child: Center(child: Text('Player Page')),
    );
  }
}

class AlbumInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Album Info')),
      child: Center(child: Text('Album Info Page')),
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
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 앨범/아이콘 영역
          Container(
            height: 148,
            width: 148,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 64,
                color: CupertinoColors.black,
              ),
            ),
          ),
          // 텍스트 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              subtitle,
              style: TextStyle(
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
          CupertinoPageRoute(builder: (_) => AlbumInfoPage()),
        );
      },
      child: Container(
        width: 148,
        height: 232,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CupertinoColors.systemBackground,
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 148,
              width: 148,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 64,
                  color: CupertinoColors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                albumTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                artist,
                style: TextStyle(
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

