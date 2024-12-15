# 1

```c
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main() {
    pid_t pid = fork(); // Create a child process

    if (pid < 0) {
        // Error occurred during fork
        perror("fork failed");
        return 1;
    } else if (pid == 0) {
        // Child process
        while (1) {
            printf("Child: Process ID = %d\n", getpid());
        }
    } else {
        // Parent process
        while (1) {
            printf("Parent: Process ID = %d\n", getpid());
        }
    }

    return 0;
}
```

### Explanation:

- `fork()` creates a new process by duplicating the parent process. The return value of `fork()` is:
  - `0` in the child process.
  - The child process ID (PID) in the parent process.
- Both processes enter infinite loops, printing their respective messages and process IDs.

### Tasks Breakdown:

1. **Run the program and trace the state of both processes**:

   - Both the child and the parent processes will continuously print their respective messages.
   - Trace: You’ll see alternating outputs from both processes, with both printing their PID.

2. **Terminate the child process. Then trace the state of processes**:

   - You can terminate the child process by sending a signal (e.g., `kill <pid>` or pressing `Ctrl+C` in the terminal).
   - Trace: After terminating the child, the parent process will keep running and printing its messages, and the child process will no longer exist.

3. **Run the program and trace the state of both processes. Terminate the parent process. Then trace the state of processes**:

   - If you terminate the parent process, the child process will be adopted by the init process (PID 1).
   - Trace: After terminating the parent, the child process will still be running and printing its messages, but its parent (the original process) will be gone.

4. **Modify the program so that the parent process after displaying the message will wait for the child process to complete its task**:

   - Use `wait()` system call to make the parent process wait for the child to terminate before continuing.
   - Modified code:

   ```c
   #include <stdio.h>
   #include <unistd.h>
   #include <sys/types.h>
   #include <sys/wait.h> // Required for wait()

   int main() {
       pid_t pid = fork();

       if (pid < 0) {
           perror("fork failed");
           return 1;
       } else if (pid == 0) {
           // Child process
           while (1) {
               printf("Child: Process ID = %d\n", getpid());
           }
       } else {
           // Parent process
           printf("Parent: Process ID = %d\n", getpid());
           wait(NULL); // Wait for the child process to terminate
           printf("Parent: Child process has terminated\n");
       }

       return 0;
   }
   ```

   - The parent process will wait for the child process to terminate using `wait()`.
   - Trace: The parent will wait for the child process to finish its task before printing the "Child process has terminated" message.

5. **Terminate the child process. Then trace the state of processes**:
   - After running the program with `wait()`, you can again terminate the child process using `kill` or `Ctrl+C`.
   - Trace: After terminating the child, the parent will continue and eventually terminate after the child process finishes its task.

---

# 2

### **(a)**

```c
int main() {
    if (fork() == 0)
        printf("1");
    else
        printf("2");
    printf("3");
    return 0;
}
```

**Possible outputs**:

1. **213**
2. **2313**

Explanation:

- The `fork()` creates a child process.
- Both processes execute `printf("3")` after their respective `if` or `else` block.

---

### **(b)**

```c
int main() {
    if (vfork() == 0) {
        printf("1");
        _exit(0);
    } else {
        printf("2");
    }
    printf("3");
    return 0;
}
```

**Output**:

- **213**

Explanation:

- `vfork()` creates a child process but suspends the parent until the child exits.
- The child prints `1`, exits, and then the parent prints `2` and `3`.

---

### **(c)**

```c
int main() {
    pid_t pid;
    int i = 5;
    pid = fork();
    i = i + 1;
    if (pid == 0) {
        printf("Child: %d\n", i);
    } else {
        wait(NULL);
        printf("Parent: %d\n", i);
    }
    return 0;
}
```

**Output**:

1. **Child: 6**
2. **Parent: 6**

---

### **(d)**

```c
int main() {
    pid_t pid;
    int i = 5;
    pid = vfork();
    i = i + 1;
    if (pid == 0) {
        printf("Child: %d\n", i);
        _exit(0);
    } else {
        printf("Parent: %d\n", i);
    }
    return 0;
}
```

**Output**:

1. **Child: 6**
2. **Parent: 6**

---

### **(e)**

```c
int main() {
    pid_t pid;
    int i = 5;
    pid = fork();
    if (pid == 0) {
        i = i + 1;
        printf("Child: %d\n", i);
    } else {
        wait(NULL);
        printf("Parent: %d\n", i);
    }
    return 0;
}
```

**Output**:

1. **Child: 6**
2. **Parent: 5**

---

### **(f)**

```c
int main() {
    pid_t pid;
    int i = 5;
    pid = vfork();
    if (pid == 0) {
        i = i + 1;
        printf("Child: %d\n", i);
        _exit(0);
    } else {
        printf("Parent: %d\n", i);
    }
    return 0;
}
```

**Output**:

1. **Child: 6**
2. **Parent: 5**

---

### **(g)**

```c
int main() {
    int i = 5;
    if (fork() == 0) {
        printf("Child: %d\n", i);
    } else {
        printf("Parent: %d\n", i);
    }
    return 0;
}
```

**Output**:

1. **Parent: 5**
2. **Child: 5**

---

### **(h)**

```c
int main() {
    int i = 5;
    if (vfork() == 0) {
        printf("Child: %d\n", i);
        _exit(0);
    } else {
        printf("Parent: %d\n", i);
    }
    return 0;
}
```

**Output**:

1. **Child: 5**
2. **Parent: 5**

---

### **(i)**

```c
int main() {
    if (fork() == 0) {
        printf("1");
    } else {
        wait(NULL);
        printf("2");
        printf("3");
    }
    return 0;
}
```

**Output**:

1. **123**
2. **213**

---

### **(j)**

```c
int main() {
    if (vfork() == 0) {
        printf("1");
        _exit(0);
    } else {
        printf("2");
        printf("3");
    }
    return 0;
}
```

**Output**:

- **213**

---

### **(k)**

```c
int main() {
    pid_t c1;
    int n = 10;
    c1 = fork();
    if (c1 == 0) {
        printf("Child\n");
        n = 20;
        printf("n = %d\n", n);
    } else {
        wait(NULL);
        printf("Parent\n");
        printf("n = %d\n", n);
    }
    return 0;
}
```

**Output**:

1. **Child**  
   **n = 20**  
   **Parent**  
   **n = 10**

---

### **(l)**

```c
int main() {
    pid_t c1;
    int n = 10;
    c1 = vfork();
    if (c1 == 0) {
        printf("Child\n");
        n = 20;
        printf("n = %d\n", n);
        _exit(0);
    } else {
        printf("Parent\n");
        printf("n = %d\n", n);
    }
    return 0;
}
```

**Output**:

1. **Child**  
   **n = 20**  
   **Parent**  
   **n = 10**

---

### **(m)**

```c
int main() {
    int i = 5;
    fork();
    i = i + 1;
    fork();
    printf("%d\n", i);
    return 0;
}
```

**Output**:

- 6 (printed 4 times due to 2 forks)

---

### **(n)**

```c
int main() {
    pid_t pid;
    int i = 5;
    pid = vfork();
    if (pid == 0) {
        printf("Child: %d\n", i);
        _exit(0);
    } else {
        i = i + 1;
        printf("Parent: %d\n", i);
    }
    return 0;
}
```

**Output**:

1. **Child: 5**
2. **Parent: 6**

---

### **(o)**

```c
int main() {
    int i = 5;
    if (fork() == 0)
        i = i + 1;
    else
        i = i - 1;
    printf("%d\n", i);
    return 0;
}
```

**Output**:

1. **4**
2. **6**

---

### **(p)**

```c
int main() {
    int i = 5;
    if (vfork() == 0) {
        i = i + 1;
        _exit(0);
    } else {
        i = i - 1;
    }
    fprintf(stderr, "%d\n", i);
    return 0;
}
```

**Output**:

- **4**

---

### **(q)**

```c
int main() {
    int j, i = 5;
    for (j = 1; j < 3; j++) {
        if (fork() == 0) {
            i = i + 1;
            break;
        } else {
            wait(NULL);
        }
    }
    printf("%d\n", i);
    return 0;
}
```

**Output**:

- **7**
- **6**

---

### **(r)**

```c
int main() {
    int j, i = 5;
    for (j = 1; j < 3; j++) {
        if (fork() != 0) {
            i = i - 1;
            break;
        }
    }
    fprintf(stderr, "%d\n", i);
    return 0;
}
```

**Output**:

- **4**
- **3**

---

### **(s)**

```c
int main() {
    if (fork() == 0)
        if (fork())
            printf("1\n");
    return 0;
}
```

**Output**:

- **1**

---

### **(t)**

```c
void fun1() {
    fork();
    fork();
    printf("1\n");
}

int main() {
    fun1();
    printf("1\n");
    return 0;
}
```

**Output**:

- Eight "1" printed due to 3 forks (2 in `fun1()` and 1 in `main()`).

---

# 3

### C Program to Create Three Child Processes

This C program creates three child processes to perform the following operations:

1. Copy the content of `file1` to `file2`.
2. Display the content of `file2`.
3. Display the sorted content of `file2` in reverse order.

The parent process will create each child process, wait for a second after each creation, and display its message after all child processes have completed.

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>

void copy_file(const char *source, const char *destination) {
    FILE *src = fopen(source, "r");
    FILE *dest = fopen(destination, "w");
    char ch;
    if (src == NULL || dest == NULL) {
        perror("File open failed");
        exit(1);
    }
    while ((ch = fgetc(src)) != EOF) {
        fputc(ch, dest);
    }
    fclose(src);
    fclose(dest);
}

void display_file(const char *filename) {
    FILE *file = fopen(filename, "r");
    char ch;
    if (file == NULL) {
        perror("File open failed");
        exit(1);
    }
    while ((ch = fgetc(file)) != EOF) {
        putchar(ch);
    }
    fclose(file);
}

void sort_file_reverse(const char *filename) {
    FILE *file = fopen(filename, "r");
    char *lines[100];
    char line[256];
    int count = 0;

    if (file == NULL) {
        perror("File open failed");
        exit(1);
    }

    while (fgets(line, sizeof(line), file)) {
        lines[count] = strdup(line);
        count++;
    }
    fclose(file);

    // Sorting lines in reverse order
    for (int i = 0; i < count - 1; i++) {
        for (int j = i + 1; j < count; j++) {
            if (strcmp(lines[i], lines[j]) < 0) {
                char *temp = lines[i];
                lines[i] = lines[j];
                lines[j] = temp;
            }
        }
    }

    // Displaying the sorted lines in reverse order
    for (int i = count - 1; i >= 0; i--) {
        printf("%s", lines[i]);
        free(lines[i]);
    }
}

int main() {
    pid_t pid;

    // Create the first child process
    pid = fork();
    if (pid == 0) {
        printf("Child 1 (PID: %d, Parent PID: %d): Copying file1 to file2\n", getpid(), getppid());
        copy_file("file1", "file2");
        exit(0);
    } else {
        sleep(1); // Delay parent process
    }

    // Create the second child process
    pid = fork();
    if (pid == 0) {
        printf("Child 2 (PID: %d, Parent PID: %d): Displaying content of file2\n", getpid(), getppid());
        display_file("file2");
        exit(0);
    } else {
        sleep(1); // Delay parent process
    }

    // Create the third child process
    pid = fork();
    if (pid == 0) {
        printf("Child 3 (PID: %d, Parent PID: %d): Displaying sorted content of file2 in reverse order\n", getpid(), getppid());
        sort_file_reverse("file2");
        exit(0);
    } else {
        // Wait for all child processes to finish
        wait(NULL);
        wait(NULL);
        wait(NULL);
        printf("Parent (PID: %d): All child processes completed\n", getpid());
    }

    return 0;
}
```

### Explanation:

- The program first creates a child process to copy the content of `file1` to `file2`.
- The second child process displays the content of `file2`.
- The third child process sorts the content of `file2` in reverse order.
- The parent process waits for 1 second after creating each child process.
- After all child processes are done, the parent displays a message.

---

# 4

## C Program to Generate Fibonacci Series and Display Prime Fibonacci Numbers

This C program creates a child process to generate a Fibonacci series of a specified length, stores it in an array, and then the parent process waits for the child to complete its task. After that, it displays the Fibonacci series and the prime Fibonacci numbers along with their positions.

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdbool.h>

// Function to check if a number is prime
bool is_prime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return false;
    }
    return true;
}

// Function to generate Fibonacci series
void generate_fibonacci(int length, int *fibonacci) {
    fibonacci[0] = 0;
    if (length > 1) fibonacci[1] = 1;
    for (int i = 2; i < length; i++) {
        fibonacci[i] = fibonacci[i-1] + fibonacci[i-2];
    }
}

int main() {
    int length;
    printf("Enter the length of Fibonacci series: ");
    scanf("%d", &length);

    pid_t pid = fork();

    if (pid == 0) {
        // Child process to generate Fibonacci series
        int fibonacci[length];
        generate_fibonacci(length, fibonacci);
        printf("Child (PID: %d): Fibonacci series generated\n", getpid());
        // Storing the Fibonacci series in a file or shared memory (optional)
        exit(0);
    } else {
        // Parent process waits for the child process to finish
        wait(NULL);

        int fibonacci[length];
        generate_fibonacci(length, fibonacci);
        printf("Parent (PID: %d): Fibonacci series is:\n", getpid());
        for (int i = 0; i < length; i++) {
            printf("%d ", fibonacci[i]);
        }
        printf("\n");

        // Display prime Fibonacci numbers
        printf("Prime Fibonacci numbers and their positions:\n");
        for (int i = 0; i < length; i++) {
            if (is_prime(fibonacci[i])) {
                printf("Fibonacci[%d] = %d (Prime)\n", i, fibonacci[i]);
            }
        }
    }

    return 0;
}
```

### Explanation:

- The child process generates the Fibonacci series and stores it in an array.
- The parent process waits for the child process to finish and then displays the Fibonacci series.
- The parent also identifies and displays the prime Fibonacci numbers along with their positions in the series.

---

Both programs demonstrate inter-process communication using `fork()` and `wait()`, and how the parent and child processes can interact with files and arrays to perform specific tasks.
