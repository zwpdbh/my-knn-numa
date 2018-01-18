#include <stdio.h>
#include "csv_parser.h"
#include "main.h"
#include "common.h"

#define PIPE_FILENO 3
inline void RECORD_PMC(){
        if(write(PIPE_FILENO, "PMC_CMD: read_pmc\n", 18)){
        }
}

int main(int argc, char** argv) {
	char* alg = argv[1];
	if(strcmp(alg, "sdc") == 0){
		IMG::ALG = 0;
	}else if(strcmp(alg, "linear") == 0){
		IMG::ALG = 1;
	}else if(strcmp(alg, "kdtree") == 0){
		IMG::ALG = 2;
	}else if(strcmp(alg, "kmeans") == 0){
		IMG::ALG = 3;
	}else if(strcmp(alg, "rbc") == 0){
		IMG::ALG = 4;
	}
	IMG::REP = atoi(argv[2]);
	SDCIndex::DEPTH_ = atoi(argv[3]);
	SDCIndex::BRANCH_ = atoi(argv[4]);
	SDCIndex::scale_d = atof(argv[5]);
	SDCIndex::scale_u = atof(argv[6]);
	char *format = argv[7];
	char *csv_file = argv[8];

	vector<IMG*> imgs;
	TIMER_T runtime[4];

	TIMER_READ(runtime[0]);
	csv_parser csv;
	csv.init(csv_file);
	csv.set_enclosed_char('"', ENCLOSURE_OPTIONAL);
	csv.set_field_term_char(',');
	csv.set_line_term_char('\n');
	csv.get_row();
	while (csv.has_more_rows()) {
		IMG *img = new IMG();
		snprintf(img->name, 50, format, csv.get_row()[1].c_str());
		img->readImg();
		imgs.push_back(img);
	}
	TIMER_READ(runtime[1]);
	printf("Read images: %f\n", TIMER_DIFF_SECONDS(runtime[0], runtime[1]));

	int ni = imgs.size() - 1;
//	#pragma omp parallel for schedule(dynamic)
	for (int i = 0; i < ni; ++i) {
		imgs[i]->buildIndex();
	}

	TIMER_READ(runtime[2]);
	printf("Build indexes: %f\n", TIMER_DIFF_SECONDS(runtime[1], runtime[2]));

	int* index = new int[imgs[ni]->rows * KNN];
	float* dist = new float[imgs[ni]->rows * KNN];
	uint64_t start, end, time = 0;
	for (int k = 0; k < ni; ++k) {
		printf("\nImage %d", k);
		for (int threads = 1; threads <= 64; threads += 8) {
			RECORD_PMC();
			start = tick();
			imgs[k]->march(*imgs[ni], index, dist, KNN, threads);
			end = tick();
			if (threads == 1) {
				time = end - start;
				threads = 0;
			}
			printf("\n%d ", threads);
			printf("%llu ", end - start);
			//printf("%llu %.2f ", end - start, time * 1.0f / (end - start));
			fflush(0);
			RECORD_PMC();
		}
		sleep(2);
		printf("\n");
	}
	delete[] index;
	delete[] dist;

	TIMER_READ(runtime[3]);
	printf("\nKnn searching: %f\n", TIMER_DIFF_SECONDS(runtime[2], runtime[3]));

	return 0;
}
