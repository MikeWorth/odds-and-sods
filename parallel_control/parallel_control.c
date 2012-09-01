#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/io.h>

main(int argc, char **argv){

  if(argc!=3 && argc!=4){
    printf("Incorrect usage, correct usage is %s <device> <value> [port address]\nWhere port address defaults to 0x378\n",argv[0]);
    return 1;
  }

  //default port to 0x378 if not specified
  int port = 0x378;
  if(argc==4){
    port = strtol(argv[3],NULL,0);
  }

  //Must open port access before we can use it
  if (ioperm(port,1,1))
    fprintf(stderr, "Port %x could not be acessed\n", port), exit(2);

  int device=strtol(argv[1],NULL,0);
  int value=strtol(argv[2],NULL,0);
  int onmask = 1<< device;
  int offmask = ~onmask;

  if(value==1)
    outb(inb(port)|onmask,port);
  
  if(value==0)
    outb(inb(port)&offmask,port);
}
