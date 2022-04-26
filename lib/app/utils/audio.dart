import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class Audio {
  static final Soundpool _pool = Soundpool.fromOptions(options: const SoundpoolOptions());
  static final Future<int> _beepId = rootBundle.load('assets/beep.mp3').then((soundData) => _pool.load(soundData));

  static Future<void> beep() async {
    await _pool.play(await _beepId);
  }
}
