class Interpreter {
  final String code;
  final String input;
  String output = '';

  final Map<int, int> tape = <int, int>{0: 0};

  int cPtr = 0; // Code Pointer
  int tPtr = 0; // Tape Pointer
  int iPtr = 0; // Input Pointer

  final Map<int, int> _bracketLUT = <int, int>{};

  Interpreter(this.code, this.input) {
    final List<int> stack = <int>[];

    for (int i = 0; i < code.length; i++) {
      switch (code[i]) {
        case '[':
          stack.add(i);
          break;
        case ']':
          // TODO: Check stacksize
          final int s = stack.removeLast();
          _bracketLUT[s] = i;
          _bracketLUT[i] = s;
      }
    }

    // TODO: Check if stack is empty
  }

  void step([int size = 1]) {
    for (int i = 0; i < size; i++) {
      switch (code[cPtr]) {
        case '+':
          tape[tPtr] = (tape[tPtr]! + 1) % 256;
          break;
        case '-':
          tape[tPtr] = (tape[tPtr]! - 1) % 256;
          break;
        case '>':
          tPtr++;
          _alloc();
          break;
        case '<':
          tPtr--;
          _alloc();
          break;
        case ',':
          // TODO: Check EOF
          tape[tPtr] = ascii2Byte(input[iPtr++]);
          break;
        case '.':
          output += byte2Ascii(tape[tPtr]!);
          break;
        case '[':
          if (tape[tPtr] == 0) cPtr = _bracketLUT[tPtr]!;
          break;
        case ']':
          if (tape[tPtr] != 0) cPtr = _bracketLUT[tPtr]!;
          break;
        // Otherwise not instr
      }
    }
  }

  void _alloc() {
    for (int i = tape.length; i <= tPtr; i++) {
      tape[i] = 0;
    }
  }

// TODO: ascii2Byte
  int ascii2Byte(String ascii) {
    return 2;
  }

// TODO: byte2Ascii
  String byte2Ascii(int byte) {
    return 'hhh';
  }

  // TODO: Implement tape wrapping
  void validateTape() {}

  // TODO: Implement Runtime bracket matcher
  int _findBracketMatch(int pos) {
    int res = -1;
    return res;
  }
}
