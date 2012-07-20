class one {
  public static void main(String[] args) {
  }
}
class two {
  public int func() {
    System.out.println(this.func());
    System.out.println(this.func2());
    return 0;
  }

  public int[] func2() {
    int[] res;
    return res;
  }
}