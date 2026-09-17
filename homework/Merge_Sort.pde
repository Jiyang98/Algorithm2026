// MergeSort
int[] arr;

void setup() {
  intArr(16);
  printArr();
  mergeSort(0, arr.length-1);
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

void mergeSort(int p, int r) {
  int q;
  if(p<r) {
    q = (p+r)/2;
    mergeSort(p, q);       // 전반부 정렬
    mergeSort(q+1, r);     // 후반부 정렬
    merge(p, q, r);        // 병합
  }
}

void merge(int p, int q, int r) {
  int[] t = new int[r-p+1];
  int i = p, j = q+1, k = 0;

  while(i<=q && j<=r) {
    if(arr[i]<=arr[j]) {
      t[k] = arr[i];
      i++;
    } else {
      t[k] = arr[j];
      j++;
    }
    k++;
  }

  while(i<=q) {
    t[k] = arr[i];
    i++;
    k++;
  }

  while(j<=r) {
    t[k] = arr[j];
    j++;
    k++;
  }

  for(k=0; k<t.length; k++) {
    arr[p+k] = t[k];
  }
}

void draw() {
}
