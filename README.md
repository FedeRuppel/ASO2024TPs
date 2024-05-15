1)

a) sinhilos.py: En este archivo, las tareas se ejecutan secuencialmente en el hilo principal. El tiempo de ejecución es má 
predecible, ya que cada tarea debe esperar a que la anterior termine antes de comenzar. Siempre será aproximadamente la suma de los tiempos de ejecución de las tres tareas.

conhilos.py: Aquí, las tareas se ejecutan en hilos separados, lo que significa que pueden ejecutarse en paralelo. El tiempo de ejecución puede variar dependiendo de factores como la carga
del sistema y la eficiencia de la gestión de hilos del sistema operativo. Puede ser menos predecible que en el caso anterior.

b)Los tiempos de ejecucion no son iguales.

c) Si primero ejecutas el código con las líneas comentadas y luego lo ejecutas sin comentarlas, experimentarás diferencias significativas en el comportamiento del programa.
- Con las líneas comentadas: Cuando las líneas están comentadas, las operaciones de suma y resta se realizan sin ningún tipo de sincronización entre los hilos.
Esto puede llevar a condiciones de carrera ya que múltiples hilos pueden acceder y modificar la variable "acumulador" simultáneamente.

-Sin las líneas comentadas: Al descomentar las líneas, se establece un mecanismo de bloqueo que garantiza que solo un hilo pueda acceder y modificar la variable acumulador a la vez.
Esto evita condiciones de carrera y asegura que las operaciones de suma y resta se realicen de manera segura y predecible.

2)
a)
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#define NUMBER_OF_THREADS 2
#define CANTIDAD_INICIAL_HAMBURGUESAS 20
int cantidad_restante_hamburguesas = CANTIDAD_INICIAL_HAMBURGUESAS;
int turno = 0; // Variable para el turno

void *comer_hamburguesa(void *tid)
{
    while (1 == 1)
    {
        // INICIO DE LA ZONA CRÍTICA
        while (turno != (int)tid); 
        if (cantidad_restante_hamburguesas > 0)
        {
            printf("Hola! Soy el hilo (comensal) %d, me voy a comer una hamburguesa! Todavía quedan %d \n", (int) tid, cantidad_restante_hamburguesas);
            cantidad_restante_hamburguesas--; // Me como una hamburguesa
        }
        else
        {
            printf("SE TERMINARON LAS HAMBURGUESAS :( \n");
            pthread_exit(NULL); // Forzar terminación del hilo
        }
        // SALIDA DE LA ZONA CRÍTICA
        turno = (turno + 1) % NUMBER_OF_THREADS; // Cambia el turno
    }
}

int main(int argc, char *argv[])
{
    pthread_t threads[NUMBER_OF_THREADS];
    int status, i, ret;
    for (int i = 0; i < NUMBER_OF_THREADS; i++)
    {
        printf("Hola!, soy el hilo principal. Estoy creando el hilo %d \n", i);
        status = pthread_create(&threads[i], NULL, comer_hamburguesa, (void *)i);
        if (status != 0)
        {
            printf("Algo salió mal, al crear el hilo recibi el código de error %d \n", status);
            exit(-1);
        }
    }

    for (i = 0; i < NUMBER_OF_THREADS; i++)
    {
        void *retval;
        ret = pthread_join(threads[i], &retval); // Espero por la terminación de los hilos que creé
    }
    pthread_exit(NULL); // Como los hilos que creé ya terminaron de ejecutarse, termino yo también.
}

b)La imagen de la respuesta esta guardada en la carpeta "TP03".
