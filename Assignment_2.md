Below are the shell scripts for each task in the assignment:

---

### **1. Merge and sort files**

```bash
#!/bin/bash
# prog: Merges, sorts, and displays the content of a.txt, b.txt, and c.txt

cat a.txt b.txt c.txt | sort -n > result
echo "Sorted content of merged files:"
cat result
```

Make it executable:

```bash
chmod +x prog
```

Run it:

```bash
./prog
```

---

### **2. Display system information**

```bash
#!/bin/bash
# systeminfo: Displays user and system information

echo "Login Name: $USER"
echo "System Name: $(uname -n)"
echo "Shell Type: $SHELL"
echo "Current Working Directory: $PWD"
echo "Files in Current Directory:"
ls
```

Make it executable:

```bash
chmod +x systeminfo
```

Run it:

```bash
./systeminfo
```

---

### **3. Display date and calendar**

```bash
#!/bin/bash
# dtcal: Displays system date and specific calendar

echo "Date: $(date)"
echo "Calendar for March 2022:"
cal 03 2022
```

Make it executable:

```bash
chmod +x dtcal
```

Run it:

```bash
./dtcal
```

---

### **4. Line, word, and character count of `dtcal`**

```bash
#!/bin/bash
# nvwc: Counts lines, words, and characters in dtcal script

filename="dtcal"
linecount=$(wc -l < "$filename")
wordcount=$(wc -w < "$filename")
charcount=$(wc -m < "$filename")

echo "Filename: $filename"
echo "Line count: $linecount"
echo "Word count: $wordcount"
echo "Char count: $charcount"
```

Make it executable:

```bash
chmod +x nvwc
```

Run it:

```bash
./nvwc
```

---

### **5. Line, word, and character count of any file**

```bash
#!/bin/bash
# nvwc2: Counts lines, words, and characters of a file given as argument

filename=$1

if [ -f "$filename" ]; then
  linecount=$(wc -l < "$filename")
  wordcount=$(wc -w < "$filename")
  charcount=$(wc -m < "$filename")

  echo "Filename: $filename"
  echo "Line count: $linecount"
  echo "Word count: $wordcount"
  echo "Char count: $charcount"
else
  echo "File $filename not found."
fi
```

Make it executable:

```bash
chmod +x nvwc2
```

Run it:

```bash
./nvwc2 <filename>
```

---

### **6. Command line arguments display**

```bash
#!/bin/bash
# darg: Displays command line arguments

echo "Total arguments: $#"
echo "First argument: $1"
echo "Second argument: $2"

# Modify to display all arguments
echo "All arguments: $@"
```

Make it executable:

```bash
chmod +x darg
```

Run it:

```bash
./darg arg1 arg2 arg3
```

---

### **7. Display first and last lines of a file**

```bash
#!/bin/bash
# ndisp: Displays first n and last m lines of a file

n=$1
m=$2
filename=$3

if [ -f "$filename" ]; then
  echo "First $n lines:"
  head -n "$n" "$filename"
  echo
  echo "Last $m lines:"
  tail -n "$m" "$filename"
else
  echo "File $filename not found."
fi
```

Make it executable:

```bash
chmod +x ndisp
```

Run it:

```bash
./ndisp 3 2 <filename>
```

---

Ensure all the scripts are made executable using `chmod +x <script_name>` before running them.
