// BFS / DFS 시각화 (Processing, Java 모드)
// 키 조작: b = BFS 실행, d = DFS 실행, r = 초기화

import java.util.ArrayDeque;

int N = 8;

// 인접 리스트 (노드 번호 0~7, 화면에는 1~8로 표시)
int[][] adj = {
  {1, 2, 7},   // 1 : 2, 3, 8
  {0, 6},      // 2 : 1, 7
  {0, 3, 4},   // 3 : 1, 4, 5
  {2, 4},      // 4 : 3, 5
  {2, 3},      // 5 : 3, 4
  {6},         // 6 : 7
  {1, 5, 7},   // 7 : 2, 6, 8
  {0, 6}       // 8 : 1, 7
};

// 노드 좌표
float[][] pos = {
  {400, 70},   // 1
  {200, 180},  // 2
  {560, 180},  // 3
  {480, 330},  // 4
  {660, 330},  // 5
  {80, 420},   // 6
  {200, 330},  // 7
  {320, 230}   // 8
};

int[] order = new int[N];     // 방문 순서
int[] parent = new int[N];    // 탐색 트리에서의 부모
boolean[] visited = new boolean[N];
int orderLen = 0;
int shown = 0;                // 화면에 표시된 방문 노드 수
String mode = "";
int R = 50;                   // 노드 지름

void setup() {
  size(760, 500);
  textAlign(CENTER, CENTER);
  textSize(16);
}

void draw() {
  background(255);

  // 일정 프레임마다 방문 노드 하나씩 표시
  if (frameCount % 40 == 0 && shown < orderLen) shown++;

  // 1) 전체 간선
  stroke(200);
  strokeWeight(2);
  for (int i = 0; i < N; i++) {
    for (int j : adj[i]) {
      if (i < j) line(pos[i][0], pos[i][1], pos[j][0], pos[j][1]);
    }
  }

  // 2) 탐색 트리 간선 (부모 -> 자식)
  stroke(255, 120, 0);
  strokeWeight(5);
  for (int k = 1; k < shown; k++) {
    int v = order[k];
    int p = parent[v];
    if (p >= 0) line(pos[p][0], pos[p][1], pos[v][0], pos[v][1]);
  }

  // 3) 노드
  strokeWeight(2);
  for (int i = 0; i < N; i++) {
    int idx = indexInOrder(i);
    stroke(60);
    if (idx >= 0 && idx < shown) {
      if (idx == shown - 1) fill(255, 80, 80);   // 현재 방문 노드
      else fill(120, 180, 255);                  // 이미 방문한 노드
    } else {
      fill(255);                                 // 미방문
    }
    ellipse(pos[i][0], pos[i][1], R, R);

    fill(0);
    text(i + 1, pos[i][0], pos[i][1]);

    // 방문 순번 표시
    if (idx >= 0 && idx < shown) {
      fill(80);
      textSize(12);
      text("#" + (idx + 1), pos[i][0] + 32, pos[i][1] - 26);
      textSize(16);
    }
  }

  // 4) 정보 텍스트
  fill(0);
  textAlign(LEFT, CENTER);
  text("b: BFS   d: DFS   r: reset", 20, 20);
  if (!mode.equals("")) {
    String s = mode + " 방문 순서: ";
    for (int k = 0; k < shown; k++) s += (order[k] + 1) + (k < shown - 1 ? " -> " : "");
    text(s, 20, 475);
  }
  textAlign(CENTER, CENTER);
}

void keyPressed() {
  if (key == 'b' || key == 'B') runBFS(0);
  else if (key == 'd' || key == 'D') runDFS(0);
  else if (key == 'r' || key == 'R') { orderLen = 0; shown = 0; mode = ""; }
}

// ---------------- BFS (큐) ----------------
void runBFS(int start) {
  resetState();
  mode = "BFS";
  ArrayDeque<Integer> queue = new ArrayDeque<Integer>();
  visited[start] = true;
  queue.add(start);

  while (!queue.isEmpty()) {
    int v = queue.poll();          // 먼저 들어온 노드 꺼냄 (FIFO)
    order[orderLen++] = v;
    for (int nxt : adj[v]) {
      if (!visited[nxt]) {
        visited[nxt] = true;       // 큐에 넣을 때 방문 처리
        parent[nxt] = v;
        queue.add(nxt);
      }
    }
  }
  printOrder();
}

// ---------------- DFS (재귀) ----------------
void runDFS(int start) {
  resetState();
  mode = "DFS";
  dfs(start, -1);
  printOrder();
}

void dfs(int v, int p) {
  visited[v] = true;
  parent[v] = p;
  order[orderLen++] = v;
  for (int nxt : adj[v]) {
    if (!visited[nxt]) dfs(nxt, v);   // 한 경로를 끝까지 내려감
  }
}

// ---------------- 보조 함수 ----------------
void resetState() {
  for (int i = 0; i < N; i++) {
    visited[i] = false;
    parent[i] = -1;
  }
  orderLen = 0;
  shown = 0;
}

int indexInOrder(int node) {
  for (int k = 0; k < orderLen; k++) if (order[k] == node) return k;
  return -1;
}

void printOrder() {
  String s = mode + " : ";
  for (int k = 0; k < orderLen; k++) s += (order[k] + 1) + " ";
  println(s);
}
