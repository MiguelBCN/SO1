#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>

#define STRLEN_COLUMN 10
#define COLUMN8 8
#define COLUMN9 9
#define PIPE_MAX_SIZE 65536


int get_column_fields_airport(int *column8, int *column9, char *line);
void productor(int fd[2], int ppid, char* filename);
void consumidor(int fd[2], int ppid);
void sigusr1(int signo);
void sigusr2(int signo);
struct data;

/*
* TO DO
* 1) Funcion consumidor/productor
* 2) Fork
* 3) Pipe
* 4) Buffer
* 5) Comunicación (SIGNALS)
*/
int main(int argc, char *argv[])
{
    int i, num_values, value, sum, fd[2];
    int ret, parent_pid, child_pid;
    
    if(argc != 2)
    {
        printf("%s <file>\n", argv[0]);
        exit(1);
    }
    
    pipe(fd);

    ret = fork();

    if (ret == 0){
      consumidor(fd, getppid());

    }else{
      productor(fd, ret, argv[1]);
    }
    return 0;
}

/**
 * Esta funcion se utiliza para extraer informacion del fichero CSV que
 * contiene informacion sobre los trayectos. En particular, dada una linea
 * leida de fichero, la funcion extrae las columnas 8 y 9. 
 */

int get_column_fields_airport(int *column8, int *column9, char *line) 
{
  /*Recorre la linea por caracteres*/
  char caracter;
  /* i sirve para recorrer la linea
   * iterator es para copiar el substring de la linea a char
   * coma_count es el contador de comas
   */
  int i, iterator, coma_count;
  /* start indica donde empieza el substring a copiar
   * end indica donde termina el substring a copiar
   * len indica la longitud del substring
   */
  int start, end, len;
  /* invalid nos permite saber si todos los campos son correctos
   * 1 hay error, 0 no hay error 
   */
  int invalid = 0;
  /* found se utiliza para saber si hemos encontrado los dos campos:
   * origen y destino
   */
  int found = 0;
  /*
   * eow es el caracter de fin de palabra
   */
  char eow = '\0';
  /*
   * substring para extraer la columna
   */
  char substring[STRLEN_COLUMN];
  /*
   * Inicializamos los valores de las variables
   */
  start = 0;
  end = -1;
  i = 0;
  coma_count = 0;
  /*
   * Empezamos a contar comas
   */
  do {
    caracter = line[i++];
    if (caracter == ',') {
      coma_count ++;
      /*
       * Cogemos el valor de end
       */
      end = i;
      /*
       * Si es uno de los campos que queremos procedemos a copiar el substring
       */
      if (coma_count == COLUMN8 || coma_count == COLUMN9) {
        /*
         * Calculamos la longitud, si es mayor que 1 es que tenemos 
         * algo que copiar
         */
        len = end - start;

        if (len > 1) {

          if (len > STRLEN_COLUMN) {
            printf("ERROR STRLEN_COLUMN\n");
            exit(1);
          }

          /*
           * Copiamos el substring
           */
          for(iterator = start; iterator < end-1; iterator ++){
            substring[iterator-start] = line[iterator];
          }
          /*
           * Introducimos el caracter de fin de palabra
           */
          substring[iterator-start] = eow;
          /*
           * Comprobamos que el campo no sea NA (Not Available) 
           */

          switch (coma_count) {
            case COLUMN8:
              *column8 = atoi(substring); 
              found++;
              break;
            case COLUMN9:
              *column9 = atoi(substring); 
              found++;
              break;
            default:
              printf("ERROR in coma_count\n");
              exit(1);
          }

        } else {
          /*
           * Si el campo esta vacio invalidamos la linea entera 
           */

          invalid = 1;
        }
      }
      start = end;
    }
  } while (caracter && invalid==0);

  if (found != 2)
    invalid = 1;

  return invalid;
}

void sigusr1(int signo){
}

void sigusr2(int signo){
}

typedef struct {
    unsigned long int passenger_count;
    unsigned long int trip_time_in_secs;
}block;

void productor(int fd[2], int ppid, char* filename){
    signal(SIGUSR1, sigusr1); // registrar señal

    int N=1000;
    
    if (N > PIPE_MAX_SIZE) exit(1);
    
    write(fd[1], &N, sizeof(int));
    pause();
    // Le decimos que hemos escrito N en la pipe al hijo
    kill(ppid, SIGUSR2);
    // Esperamos para continuar
    
    FILE *file;

    int invalid, value_col8, value_col9;
    char line[256];
    
    int idx;
    
    block *data;

    data=malloc(N*sizeof(block));

    if(data == NULL){
      printf("Error de memoria.\n");
      exit(1);
    }
    
    file= fopen(filename, "r");
    
    if (!file) {
        printf("ERROR: could not open '%s'\n", filename);
        exit(1);
    }
    
    // We ignore the header of the file.
    fgets(line, sizeof(line), file);
    
    // Read the file
    do{
        idx=0;
        while (idx < N && fgets(line, sizeof(line), file)){
            
            invalid = get_column_fields_airport(&value_col8, &value_col9, line);
            
            if (!invalid) {
                data[idx].passenger_count= value_col8; 
                data[idx].trip_time_in_secs= value_col9;
                idx++;
            }
        }

        write(fd[1], &idx, sizeof(int));

        write(fd[1], data, 2*N*sizeof(unsigned long int));
        kill(ppid, SIGUSR2);  

    }while(idx>N-1);

    fclose(file);

    free(data);
}

void consumidor(int fd[2], int ppid){
    signal(SIGUSR2, sigusr2); // registrar señal
      
    int N;

    read(fd[0], &N, sizeof(int));

    kill(ppid, SIGUSR1);

    block *data;

    data=malloc(N*sizeof(block));

    if(data == NULL){
      printf("Error de memoria.\n");
      exit(1);
    }

    float pc = 0, tt = 0;
    unsigned long int aux1,aux2;
    unsigned long int num_elements=0;
    int i, idx;
      
    do{

      read(fd[0], &idx, sizeof(int));
      read(fd[0], data, 2*N*sizeof(unsigned long int));

      for(i=0; i<idx; i++){
        pc+=data[i].passenger_count;
        tt+=data[i].trip_time_in_secs;
        num_elements++;
      }

      kill(ppid, SIGUSR1);

    }while(idx>N-1);

    if (num_elements == 0) {
      printf("Number of elements is zero!!!\n");
      exit(1);
    }

    pc = pc/num_elements; 
    tt = tt/num_elements;

    printf("Llegim %ld elements\n", num_elements);
    printf("Mitja de passatgers: %f\n", pc);
    printf("Mitja del temps de vol: %f secs\n", tt);

    free(data);
}