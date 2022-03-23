import 'package:stack_trace/stack_trace.dart';

class Misc {
  static Map<String, String> stackFrame(int frame) {
    String? member = Trace.current().frames[frame + 1].member;

    if (member != null) {
      List<String> frameData = member.split('.');

      return {
        'className': frameData[0],
        'methodName': frameData[1],
      };
    }

    return {
      'className': '',
      'methodName': '',
    };
  }
}
