// Quick Sorting
int[] arr;

void setup() {
  intArr(16);
  printArr();
  quickSort(0, arr.length-1);
  printArr();
}

void intArr(int n) {
  int i;
  arr = new int[n];
  for(i=0; i<arr.length; i++) {
    arr[i] = (int) random(100);
  }
}

void printArr() {
  int i;
  for(i=0; i<arr.length; i++) {
    print(arr[i], " ");
  }
  println();
}

void quickSort(int p, int r) {
  int q;
  if(p<r) {
    q = partition(p, r);   // 분할
    quickSort(p, q-1);     // 왼쪽 부분배열 정렬
    quickSort(q+1, r);     // 오른쪽 부분배열 정렬
  }
}

int partition(int p, int r) {
  int pivot = arr[r];   // 마지막 원소를 피벗으로
  int i = p - 1;
  int j, tmp;

  for(j=p; j<r; j++) {
    if(arr[j]<pivot) {
      i++;
      tmp = arr[i];
      arr[i] = arr[j];
      arr[j] = tmp;
    }
  }

  tmp = arr[i+1];
  arr[i+1] = arr[r];
  arr[r] = tmp;

  return i+1;   // 피벗이 자리한 위치 반환
}

void draw() {
}
