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
            page = const FeedPage();
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
      {
        'albumTitle': 'Melodrama',
        'artist': 'Lorde',
        'color': const Color(0xFFFFE0DC),
      },
      {
        'albumTitle': 'Graduation',
        'artist': 'Kanye West',
        'color': const Color(0xFFFFE0DF),
      },
      {
        'albumTitle': 'Gnx',
        'artist': 'Kendrick Lamar',
        'color': const Color(0xFFFFE0AC),
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
            const SizedBox(height: 24),
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

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  String selectedTab = 'Friends';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Feeds')),
      child: SafeArea(
        child: Column(
          children: [
            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  _buildTabItem('Friends'),
                  const SizedBox(width: 24),
                  _buildTabItem('Critics'),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(height: 1, color: CupertinoColors.systemGrey4),
            // Feed section
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildFeedCard(userName: 'Jim', albumTitle: 'Get Up'),
                  _buildFeedCard(userName: 'Jim', albumTitle: 'Graduation'),
                  _buildFeedCard(userName: 'Jim', albumTitle: 'Armageddon'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 피드 카드 생성
  Widget _buildFeedCard({
    required String userName,
    required String albumTitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1행: 유저 정보 + ellipsis
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                width: 36,
                height: 36,
                color: const Color(0xFFEDE4F6),
                child: const Icon(
                  CupertinoIcons.person_fill,
                  color: CupertinoColors.systemGrey,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' rated at '),
                    TextSpan(
                      text: albumTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Icon(CupertinoIcons.ellipsis),
          ],
        ),
        const SizedBox(height: 10),

        // 2행: 앨범 이미지 (색상으로 대체)
        Container(
          width: 210,
          height: 210,
          decoration: BoxDecoration(
            color: const Color(0xFFEDE4F6),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 10),

        // 3행: 별점
        const Text('★★★★☆', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 10),

        // 4행: 하트 & 댓글
        Row(
          children: const [
            Text('❤️ 21 likes'),
            SizedBox(width: 16),
            Text('💬 4 comments'),
          ],
        ),
        const SizedBox(height: 20),
        Container(height: 1, color: CupertinoColors.systemGrey4),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTabItem(String tabName) {
    final isSelected = selectedTab == tabName;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = tabName;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tabName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? CupertinoColors.black
                  : CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 2.5,
            width: 60,
            decoration: BoxDecoration(
              color: isSelected
                  ? CupertinoColors.black
                  : CupertinoColors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  Widget _buildLargeTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Text(
        title,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 음악 선택창 (재생목록, 가수, 앨범, 노래)
  Widget _buildLibraryListItem(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CupertinoColors.systemGrey4, width: 0.5),
        ),
      ),
      child: SizedBox(
        height: 50,
        child: Row(
          children: <Widget>[
            Icon(icon, size: 20, color: CupertinoColors.systemGrey),
            const SizedBox(width: 12),
            Text('$label', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            _buildLargeTitle("Library"),
            _buildLibraryListItem(CupertinoIcons.music_note_list, 'Playlists'),
            _buildLibraryListItem(CupertinoIcons.music_mic, 'Artists'),
            _buildLibraryListItem(CupertinoIcons.collections, 'Albums'),
            _buildLibraryListItem(CupertinoIcons.music_note, 'Songs'),
            const SizedBox(height: 24),
            _buildRecentlyPlayedGridRow(),
          ],
        ),
      ),
    );
  }

  // 최근 재생 앨범 그리드 섹션
  Widget _buildRecentlyPlayedGridRow() {
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
      {
        'albumTitle': 'Melodrama',
        'artist': 'Lorde',
        'color': const Color(0xFFFFE0DC),
      },
      {
        'albumTitle': 'Graduation',
        'artist': 'Kanye West',
        'color': const Color(0xFFFFE0DF),
      },
      {
        'albumTitle': 'Gnx',
        'artist': 'Kendrick Lamar',
        'color': const Color(0xFFFFE0AC),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            'Recently Played',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: List.generate((albumList.length / 2).ceil(), (rowIndex) {
              final int startIndex = rowIndex * 2;
              final List<Map<String, dynamic>> rowItems = albumList
                  .skip(startIndex)
                  .take(2)
                  .toList();

              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: rowItems.map((album) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: rowItems.indexOf(album) == 0 ? 8.0 : 0,
                        ),
                        child: AlbumInfoCard(
                          albumTitle: album['albumTitle'] as String,
                          artist: album['artist'] as String,
                          backgroundColor: album['color'] as Color,
                          icon: CupertinoIcons.music_albums,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

// 음악 검색 창
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  Widget _buildLargeTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Text(
        title,
        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: const CupertinoSearchTextField(placeholder: 'Artists, Songs...'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            _buildLargeTitle("Search"),
            _buildSearchField(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// 음악 플레이어 창
class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            // 🔼 상단 아이콘 행
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
                  const SizedBox(width: 12),
                  const Icon(CupertinoIcons.ellipsis, size: 24),
                ],
              ),
            ),

            // 🎵 앨범 아트
            Expanded(
              flex: 4,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/graduation_album.jpg', // 실제 경로로 수정
                    width: 280,
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // 📝 곡 정보 및 컨트롤
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Good Morning',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Kanye West',
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ▶️ 슬라이더 + 시간
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('0:00'),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CupertinoSlider(
                            value: 0.3,
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('3:15'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ⏮ ▶️ ⏭ 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(CupertinoIcons.backward_fill, size: 32),
                        Icon(
                          CupertinoIcons.arrowtriangle_right_fill,
                          size: 56,
                          color: CupertinoColors.activeBlue,
                        ),
                        Icon(CupertinoIcons.forward_fill, size: 32),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 🔉 볼륨 슬라이더
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.volume_mute),
                    Expanded(
                      child: CupertinoSlider(value: 0.6, onChanged: (value) {}),
                    ),
                    const Icon(CupertinoIcons.volume_up),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlbumInfoPage extends StatelessWidget {
  const AlbumInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('KhuFork'),
        automaticallyImplyLeading: false,
      ),
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
                  const SizedBox(width: 12),
                  const Icon(CupertinoIcons.ellipsis, size: 24),
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

            // Critic's review
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 4),
              child: Text(
                "Critic's Review",
                style: TextStyle(
                  color: CupertinoColors.systemRed,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // 평론가 박스
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => const ArticlePage(),
                          ),
                        );
                      },
                      child: const _CriticBox(name: 'PitchFork', stars: 4),
                    ),
                    const SizedBox(width: 12),
                    const _CriticBox(name: 'Rollingstone', stars: 4),
                    const SizedBox(width: 12),
                    const _CriticBox(name: 'Jim', stars: 3),
                    const SizedBox(width: 12),
                    const _CriticBox(name: 'Fantano', stars: 5),
                  ],
                ),
              ),
            ),

            // Play + Shuffle 버튼
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Play 버튼
                  Expanded(
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      color: const Color(0xFFEDE4F6), // 더 연한 보라색
                      borderRadius: BorderRadius.circular(12),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => const PlayerPage(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(CupertinoIcons.play_arrow_solid, size: 18),
                          SizedBox(width: 6),
                          Text('Play', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 16), // 버튼 사이 간격
                  // Shuffle 버튼
                  Expanded(
                    child: CupertinoButton(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      color: const Color(0xFFEDE4F6), // 더 연한 보라색
                      borderRadius: BorderRadius.circular(12),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => const PlayerPage(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(CupertinoIcons.shuffle, size: 18),
                          SizedBox(width: 6),
                          Text('Shuffle', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // (아래에 다른 내용 추가 가능)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  final List<String> tracks = [
                    '360',
                    'Club classics',
                    'Sympathy is a knife',
                    'I might say something stupid',
                    'Talk talk',
                    'Von dutch',
                    'Everything is romantic',
                    'Rewind',
                    'So I',
                    'Girl, so confusing',
                    'Apple',
                    'B2b',
                    'Mean girls',
                    'I think about it all the time',
                    '365',
                  ];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}.',
                          style: const TextStyle(
                            color: CupertinoColors.systemRed,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            tracks[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('KhuFork'),
        automaticallyImplyLeading: false, // 기본 back 제거 (우리가 따로 만들었으므로)
      ),
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
                  const SizedBox(width: 12),
                  const Icon(CupertinoIcons.ellipsis, size: 24),
                ],
              ),
            ),

            // 임시 본문
            const Expanded(
              child: Center(
                child: Text('Article Page', style: TextStyle(fontSize: 20)),
              ),
            ),
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
          CupertinoPageRoute<void>(builder: (_) => const AlbumInfoPage()),
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
                style: const TextStyle(
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

class _CriticBox extends StatelessWidget {
  final String name;
  final int stars;

  const _CriticBox({required this.name, required this.stars});

  @override
  Widget build(BuildContext context) {
    String starString = '★★★★★'.substring(0, stars);

    return Container(
      width: 100,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF4D8E9),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(starString, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
