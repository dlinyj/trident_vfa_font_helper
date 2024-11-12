#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>
#include <sys/stat.h>

#define NORMALIZE	0
#define MIXING 		1

#define OUTPUT_FILENAME "out.bin"

void help_getopt(void) {
	printf(	"use ncode:\n"\
			"-n <filename> for normalization\n"\
			"-m <filename> for mixing (image for chip)\n"\
			"- o <outputfile> optional, default \"out.bin\""\
			"-h this help\n");
	exit(0);
}

int main(int argc, char *argv[]) {
	int rez = 0;
	int type_oper = 0;
	char * filename = NULL;
	char * output_filename = OUTPUT_FILENAME;
	int in_fd, out_fd;
	
	int filesize = 0;
	
	char * in_file_memory, *out_file_memory;
	
	if (argc <=1) {
		help_getopt();
	}
	while ( (rez = getopt(argc, argv, "n:m:o:h")) != -1){
		switch (rez) {
		case 'n': 
			type_oper = NORMALIZE;
			filename = optarg;
			printf("Normalization file %s\n", filename);
			break;
		case 'm': 
			type_oper = MIXING;
			filename = optarg;
			printf("Mixing file %s\n", filename);
			break;
		case 'o': 
			output_filename = optarg;
			printf("Output filename %s\n", output_filename);
			break;
		default:
			help_getopt();
		} // switch
	} // while
	
	struct stat st;
	stat(filename, &st);
	filesize = st.st_size;
	
	printf("Filesize = %d\n", filesize);
	
	in_fd = open (filename, O_RDWR, S_IRUSR | S_IWUSR);
	out_fd = open (output_filename, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
	lseek (out_fd, filesize-1, SEEK_SET);
	write (out_fd, "\0", 1);
	lseek (out_fd, 0, SEEK_SET);

	in_file_memory = mmap (0, filesize, PROT_READ | PROT_WRITE, MAP_SHARED, in_fd, 0);
	out_file_memory = mmap (0, filesize, PROT_WRITE, MAP_SHARED, out_fd, 0);

	for (int i = 0; i < filesize; i++) {
		if (type_oper == NORMALIZE) {
			if(i%2) {
				out_file_memory[i] = in_file_memory[i/2 + 0x4000];
			} else {
				out_file_memory[i] = in_file_memory[i/2];
			}
		} else {
			if(i%2) {
				out_file_memory[i/2 + 0x4000] = in_file_memory[i];
			} else {
				out_file_memory[i/2] = in_file_memory[i];
			}
		}
		
	}

	munmap (in_file_memory, filesize);
	munmap (out_file_memory, filesize);
	close (in_fd);
	close (out_fd);
	
	exit(0);
} // main
