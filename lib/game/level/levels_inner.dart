import 'level.dart';

class LevelsInner {
  static final levels = {
    'friut': _friutsLevels,
    'emoji': _emojiLevels,
    '985': _985Levels,
    'shandong': _shandongLevels,
  };

  static final _friutsLevels = <Level>[
    Level(2.0, 'friuts/1.png'),
    Level(4.0, 'friuts/2.png'),
    Level(6.0, 'friuts/3.png'),
    Level(8.0, 'friuts/4.png'),
    Level(10.0, 'friuts/5.png'),
    Level(12.0, 'friuts/6.png'),
    Level(14.0, 'friuts/7.png'),
    Level(16.0, 'friuts/8.png'),
    Level(18.0, 'friuts/9.png'),
    Level(20.0, 'friuts/10.png'),
    Level(22.0, 'friuts/11.png'),
  ];

  static final _emojiLevels = <Level>[
    Level(2.0, 'qq/1.png'),
    Level(4.0, 'qq/2.png'),
    Level(6.0, 'qq/3.png'),
    Level(8.0, 'qq/4.png'),
    Level(10.0, 'qq/5.png'),
    Level(12.0, 'qq/6.png'),
    Level(14.0, 'qq/7.png'),
    Level(16.0, 'qq/8.png'),
    Level(18.0, 'qq/9.png'),
    Level(20.0, 'qq/10.png'),
    Level(22.0, 'qq/11.png'),
  ];

  static final _985Levels = <Level>[
    Level(2.0, '985/1.png'),
    Level(4.0, '985/2.png'),
    Level(6.0, '985/3.png'),
    Level(8.0, '985/4.png'),
    Level(10.0, '985/5.png'),
    Level(12.0, '985/6.png'),
    Level(14.0, '985/7.png'),
    Level(16.0, '985/8.png'),
    Level(18.0, '985/9.png'),
    Level(20.0, '985/10.png'),
    Level(22.0, '985/11.png'),
  ];

  static final _shandongLevels = <Level>[
    Level(2.0, 'shandong/1.png'),
    Level(4.0, 'shandong/2.png'),
    Level(6.0, 'shandong/3.png'),
    Level(8.0, 'shandong/4.png'),
    Level(10.0, 'shandong/5.png'),
    Level(12.0, 'shandong/6.png'),
    Level(14.0, 'shandong/7.png'),
    Level(16.0, 'shandong/8.png'),
    Level(18.0, 'shandong/9.png'),
    Level(20.0, 'shandong/10.png'),
    Level(22.0, 'shandong/11.png'),
  ];
}
