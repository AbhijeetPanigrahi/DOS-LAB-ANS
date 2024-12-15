### 1. **Producer-Consumer Problem**

In this problem, the producer generates integers from 1 to 100 and places them in a buffer. The consumer processes these numbers, consuming one number at a time. Semaphores and mutexes are used to synchronize access to the shared buffer.

```c
#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define BUFFER_SIZE 10
#define MAX_COUNT 20

int buffer[BUFFER_SIZE];
int in = 0, out = 0;
sem_t empty, full;
pthread_mutex_t mutex;

void *producer(void *arg) {
    for (int i = 1; i <= MAX_COUNT; i++) {
        sem_wait(&empty); // Wait if buffer is full
        pthread_mutex_lock(&mutex); // Lock the buffer

        buffer[in] = i;
        printf("Producer produced: %d\n", i);
        in = (in + 1) % BUFFER_SIZE;

        pthread_mutex_unlock(&mutex); // Unlock the buffer
        sem_post(&full); // Signal that there is a new item to consume
        sleep(1);
    }
    return NULL;
}

void *consumer(void *arg) {
    for (int i = 1; i <= MAX_COUNT; i++) {
        sem_wait(&full); // Wait if buffer is empty
        pthread_mutex_lock(&mutex); // Lock the buffer

        int item = buffer[out];
        printf("Consumer consumed: %d\n", item);
        out = (out + 1) % BUFFER_SIZE;

        pthread_mutex_unlock(&mutex); // Unlock the buffer
        sem_post(&empty); // Signal that there is space in the buffer
        sleep(1);
    }
    return NULL;
}

int main() {
    pthread_t producer_thread, consumer_thread;
    sem_init(&empty, 0, BUFFER_SIZE); // Initially, buffer is empty
    sem_init(&full, 0, 0); // Initially, buffer is empty
    pthread_mutex_init(&mutex, NULL);

    pthread_create(&producer_thread, NULL, producer, NULL);
    pthread_create(&consumer_thread, NULL, consumer, NULL);

    pthread_join(producer_thread, NULL);
    pthread_join(consumer_thread, NULL);

    sem_destroy(&empty);
    sem_destroy(&full);
    pthread_mutex_destroy(&mutex);

    return 0;
}
```

### 2. **Alternating Numbers with Two Threads**

In this problem, two threads print alternating odd and even numbers up to 20. Semaphores are used to control the order of execution.

```c
#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

sem_t semA, semB;

void *print_odd(void *arg) {
    for (int i = 1; i <= 19; i += 2) {
        sem_wait(&semA); // Wait for the turn to print odd numbers
        printf("%d ", i);
        sem_post(&semB); // Signal the other thread to print even numbers
    }
    return NULL;
}

void *print_even(void *arg) {
    for (int i = 2; i <= 20; i += 2) {
        sem_wait(&semB); // Wait for the turn to print even numbers
        printf("%d ", i);
        sem_post(&semA); // Signal the other thread to print odd numbers
    }
    return NULL;
}

int main() {
    pthread_t threadA, threadB;
    sem_init(&semA, 0, 1); // Thread A starts first
    sem_init(&semB, 0, 0); // Thread B starts after thread A

    pthread_create(&threadA, NULL, print_odd, NULL);
    pthread_create(&threadB, NULL, print_even, NULL);

    pthread_join(threadA, NULL);
    pthread_join(threadB, NULL);

    sem_destroy(&semA);
    sem_destroy(&semB);

    return 0;
}
```

### 3. **Alternating Characters**

This program creates two threads to print alternating characters (`A` and `B`) up to 20 times.

```c
#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

sem_t semA, semB;

void *print_A(void *arg) {
    for (int i = 0; i < 10; i++) {
        sem_wait(&semA); // Wait for the turn to print A
        printf("A");
        sem_post(&semB); // Signal the other thread to print B
    }
    return NULL;
}

void *print_B(void *arg) {
    for (int i = 0; i < 10; i++) {
        sem_wait(&semB); // Wait for the turn to print B
        printf("B");
        sem_post(&semA); // Signal the other thread to print A
    }
    return NULL;
}

int main() {
    pthread_t threadA, threadB;
    sem_init(&semA, 0, 1); // Thread A starts first
    sem_init(&semB, 0, 0); // Thread B starts after thread A

    pthread_create(&threadA, NULL, print_A, NULL);
    pthread_create(&threadB, NULL, print_B, NULL);

    pthread_join(threadA, NULL);
    pthread_join(threadB, NULL);

    sem_destroy(&semA);
    sem_destroy(&semB);

    return 0;
}
```

### 4. **Countdown and Countup**

In this program, two threads count down from 10 to 1 and count up from 1 to 10, respectively.

```c
#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

sem_t semA, semB;

void *countdown(void *arg) {
    for (int i = 10; i >= 1; i--) {
        sem_wait(&semA); // Wait for the turn to print countdown
        printf("%d ", i);
        sem_post(&semB); // Signal the other thread to print countup
    }
    return NULL;
}

void *countup(void *arg) {
    for (int i = 1; i <= 10; i++) {
        sem_wait(&semB); // Wait for the turn to print countup
        printf("%d ", i);
        sem_post(&semA); // Signal the other thread to print countdown
    }
    return NULL;
}

int main() {
    pthread_t threadA, threadB;
    sem_init(&semA, 0, 1); // Thread A starts first
    sem_init(&semB, 0, 0); // Thread B starts after thread A

    pthread_create(&threadA, NULL, countdown, NULL);
    pthread_create(&threadB, NULL, countup, NULL);

    pthread_join(threadA, NULL);
    pthread_join(threadB, NULL);

    sem_destroy(&semA);
    sem_destroy(&semB);

    return 0;
}
```

### 5. **Sequence Printing using Threads**

This program creates three threads (A, B, C) to print numbers in a specific sequence: A1, B2, C3, A4, B5, C6, ...

```c
#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

sem_t semA, semB, semC;

void *print_A(void *arg) {
    for (int i = 1; i <= 20; i += 3) {
        sem_wait(&semA); // Wait for the turn to print A
        printf("A%d ", i);
        sem_post(&semB); // Signal the next thread to print B
    }
    return NULL;
}

void *print_B(void *arg) {
    for (int i = 2; i <= 20; i += 3) {
        sem_wait(&semB); // Wait for the turn to print B
        printf("B%d ", i);
        sem_post(&semC); // Signal the next thread to print C
    }
    return NULL;
}

void *print_C(void *arg) {
    for (int i = 3; i <= 20; i += 3) {
        sem_wait(&semC); // Wait for the turn to print C
        printf("C%d ", i);
        sem_post(&semA); // Signal the next thread to print A
    }
    return NULL;
}

int main() {
    pthread_t threadA, threadB, threadC;
    sem_init(&semA, 0, 1); // Thread A starts first
    sem_init(&semB, 0, 0); // Thread B starts after thread A
    sem_init(&semC, 0, 0); // Thread C starts after thread B

    pthread_create(&threadA, NULL, print_A, NULL);
    pthread_create(&threadB, NULL, print_B, NULL);
    pthread_create(&threadC, NULL, print_C, NULL);

    pthread_join(threadA, NULL);
    pthread_join(threadB, NULL);
    pthread_join(threadC, NULL);

    sem_destroy(&semA);
    sem_destroy(&semB);
    sem_destroy(&semC);

    return 0;
}
```

### Key Concepts:

- **Semaphores**: Used to synchronize the execution of threads, ensuring that only one thread can execute a critical section at a time.
- **Mutex**: A lock to ensure that only one thread at a time can access a shared resource (e.g., the buffer in the producer-consumer problem).

Each problem makes use of semaphores to coordinate the actions of multiple threads, ensuring that they print or modify data in a synchronized and orderly manner.
