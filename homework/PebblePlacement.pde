int[][] board = new int[3][100001];

// canFrom[k]: 현재 열이 패턴 k일 때 이전 열에 올 수 있는 패턴
// 0: 1행, 1: 2행, 2: 3행, 3: 1행+3행
int[][] canFrom = {
  {1, 2},
  {0, 2, 3},
  {0, 1},
  {1}
};

void setup()
{
  int n = readInt();

  for (int r = 0; r < 3; r++)
    for (int c = 0; c < n; c++)
      board[r][c] = readInt();

  printBoard(n);

  int[] prev = new int[4];   // 직전 열까지의 패턴별 최대합
  int[] cur  = new int[4];   // 현재 열까지의 패턴별 최대합

  for (int c = 0; c < n; c++)
  {
    for (int k = 0; k < 4; k++)
    {
      int best = 0;
      if (c > 0)
      {
        best = Integer.MIN_VALUE;
        for (int p : canFrom[k])
          best = max(best, prev[p]);
      }
      cur[k] = best + cellValue(k, c);
    }
    arrayCopy(cur, prev);
  }

  println(max(prev));
}

// 패턴 k로 c열에 놓았을 때 얻는 값
int cellValue(int k, int c)
{
  if (k < 3) return board[k][c];
  return board[0][c] + board[2][c];
}

void printBoard(int n)
{
  for (int r = 0; r < 3; r++)
  {
    String line = "";
    for (int c = 0; c < n; c++)
      line += nfp(board[r][c], 4) + " ";
    println(line);
  }
}

// 입력 (cin 대체)
String input =
  "3\n" +
  "-9 -7 9\n" +
  "3 2 6\n" +
  "2 -9 5\n";

String[] tokens = splitTokens(input, " \n\t\r");
int pos = 0;

int readInt()
{
  return int(tokens[pos++]);
}
