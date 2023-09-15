int test_latch();
void test_memory()
{
  test_latch();
}

int test_latch()
{
  int test = 0;
  int fd_latch;

  mkdir("build/cosim/memory", 0777);
  mkdir("build/cosim/memory/latch", 0777);

  latch_init();
  test = latch_test();
  latch_destruct();
  fd_latch = open("../build/cosim/memory/latch_check",
		  O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

  printf("memory-latch test : %s\n", test ? "FAIL" : "OK");
  dprintf(fd_latch, "memory-latch test : %s\n", test ? "FAIL" : "OK");

  close(fd_latch);
  return (test);
}
