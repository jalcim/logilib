int test_parallele_gate()
{
  int test = 0;
  int fd_parallel_gate;

  parallel_gate_init();
  test = parallel_gate_test();
  parallel_gate_destruct();

  fd_parallel_gate = open("../build/cosim/primitive/parallel_gate_check",
		      O_CREAT|O_RDWR, S_IRUSR|S_IWUSR);

  printf("primitive-parallel_gate test : %s\n", test ? "FAIL" : "OK");
  dprintf(fd_parallel_gate, "primitive-parallel_gate test : %s\n", test ? "FAIL" : "OK");


  close(fd_parallel_gate);
  return (test);
}
