int len=16, max = 100;
ArrayList<Array> lists = new ArrayList<Array>();
int[] list = new int[len];
int step = 0;   // 현재 보여주는 단계

void setup() {
  size(800, 600);
  for (int i=0; i<len; i++) {
    list[i] = (int) random(max);
  }
  selectionSort();
  frameRate(4);  // 애니메이션 속도 (숫자가 클수록 빠름)
}

// 셀렉션 정렬: 남은 구간에서 최댓값을 찾아 맨 뒤로 보냄
// 매 비교 단계와 교환 단계를 lists에 기록
void selectionSort() {
  lists.add(new Array(list, -1, -1, false, len));   // 초기 상태

  for (int i=0; i<len-1; i++) {
    int last = len-1-i;   // 이번 회차에 최댓값이 들어갈 자리
    int index = 0;        // 지금까지 찾은 최댓값의 인덱스

    for (int j=1; j<=last; j++) {
      if (list[j] > list[index]) {
        index = j;
      }
      lists.add(new Array(list, j, index, false, last+1));
    }

    int tmp = list[index];
    list[index] = list[last];
    list[last] = tmp;
    lists.add(new Array(list, last, index, true, last));
  }

  lists.add(new Array(list, -1, -1, false, 0));     // 정렬 완료 상태
}

void draw() {
  background(255);
  lists.get(step).display();

  fill(0);
  textAlign(LEFT, TOP);
  textSize(16);
  text("Selection Sort  step " + step + " / " + (lists.size()-1), 20, 15);

  if (step < lists.size()-1) step++;
}

// 클릭하면 처음부터 다시 재생
void mousePressed() {
  step = 0;
}
