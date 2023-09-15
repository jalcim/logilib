int test_alu()
{
  int test = 0;
  int fd_arithm;

  mkdir("build/cosim/alu", 0777);
  mkdir("build/cosim/alu/arithm", 0777);

  arithm_init();
  test = arithm_test();
  arithm_destruct();
  fd_arithm = open("../build/cosim/alu/arithm_check",
		   O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

  printf("alu-arithm test : %s\n", test ? "FAIL" : "OK");
  dprintf(fd_arithm, "alu-arithm test : %s\n", test ? "FAIL" : "OK");

  close(fd_arithm);
  return (test);
}
