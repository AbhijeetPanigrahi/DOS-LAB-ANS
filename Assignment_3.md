Here are the solutions for each problem in **Assignment 3** using shell scripting. Follow the instructions at the end to make the scripts executable and run them.

---

### 1. **Integer Arithmetic (`iaop`)**

```bash
#!/bin/bash
echo "Enter two integers:"
read num1 num2
echo "Addition: $((num1 + num2))"
echo "Subtraction: $((num1 - num2))"
echo "Multiplication: $((num1 * num2))"
echo "Division: $((num1 / num2))"
echo "Modulo: $((num1 % num2))"
```

---

### 2. **Floating Point Arithmetic (`faop`)**

```bash
#!/bin/bash
echo "Enter two floating-point numbers:"
read num1 num2
echo "Addition: $(echo "$num1 + $num2" | bc)"
echo "Subtraction: $(echo "$num1 - $num2" | bc)"
echo "Multiplication: $(echo "$num1 * $num2" | bc)"
echo "Division: $(echo "scale=2; $num1 / $num2" | bc)"
```

---

### 3. **Gross Salary Calculation**

```bash
#!/bin/bash
echo "Enter Ramesh's basic salary:"
read basic
da=$(echo "$basic * 0.40" | bc)
hra=$(echo "$basic * 0.20" | bc)
gross=$(echo "$basic + $da + $hra" | bc)
echo "Gross Salary: $gross"
```

---

### 4. **Sum of Digits of a Five-Digit Number**

```bash
#!/bin/bash
echo "Enter a five-digit number:"
read num
sum=0
while [ $num -gt 0 ]; do
    digit=$((num % 10))
    sum=$((sum + digit))
    num=$((num / 10))
done
echo "Sum of digits: $sum"
```

---

### 5. **Profit or Loss Calculation**

```bash
#!/bin/bash
echo "Enter cost price and selling price:"
read cp sp
if [ $sp -gt $cp ]; then
    profit=$((sp - cp))
    echo "Profit: $profit"
elif [ $sp -lt $cp ]; then
    loss=$((cp - sp))
    echo "Loss: $loss"
else
    echo "No profit, no loss."
fi
```

---

### 6. **Leap Year Determination**

```bash
#!/bin/bash
year=$(date +%Y)
if [ $# -gt 0 ]; then
    year=$1
fi
if (( year % 4 == 0 && year % 100 != 0 || year % 400 == 0 )); then
    echo "$year is a leap year."
else
    echo "$year is not a leap year."
fi
```

---

### 7. **Semester Eligibility Check (`allow`)**

```bash
#!/bin/bash
echo "Enter internal marks:"
read marks
echo "Enter attendance percentage:"
read attendance
if [ $marks -ge 20 ] && [ $attendance -ge 75 ]; then
    echo "Allowed for Semester"
else
    echo "Not Allowed"
fi
```

---

### 8. **Smallest of Three Numbers (`small3`)**

```bash
#!/bin/bash
if [ $# -ne 3 ]; then
    echo "Please provide exactly three numbers."
    exit 1
fi
small=$1
if [ $2 -lt $small ]; then
    small=$2
fi
if [ $3 -lt $small ]; then
    small=$3
fi
echo "Smallest number: $small"
```

---

### 9. **Character Identification (`check_char`)**

```bash
#!/bin/bash
echo "Enter a character:"
read char
if [[ ${#char} -ne 1 ]]; then
    echo "You have entered more than one character."
elif [[ $char =~ [a-z] ]]; then
    echo "You entered a lower case alphabet."
elif [[ $char =~ [A-Z] ]]; then
    echo "You entered an upper case alphabet."
elif [[ $char =~ [0-9] ]]; then
    echo "You entered a digit."
else
    echo "You entered a special symbol."
fi
```

---

### 10. **Class Timing Information (`class_time`)**

```bash
#!/bin/bash
echo "Enter the day:"
read day
case $day in
    Monday|Wednesday|Friday)
        echo "DOS class: 10 AM, Room 101"
        ;;
    Tuesday|Thursday)
        echo "DOS class: 2 PM, Room 201"
        ;;
    Sunday)
        echo "Holiday"
        ;;
    *)
        echo "No class on $day"
        ;;
esac
```

---

### 11. **File Content Comparison (`filechk`)**

```bash
#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Provide exactly two file names."
    exit 1
fi
if cmp -s "$1" "$2"; then
    echo "Files $1 and $2 have same content."
    rm "$2"
    echo "So $2 is deleted."
else
    echo "Files $1 and $2 have different content."
fi
```

---

### 12. **Arithmetic Calculator (`calculator`)**

```bash
#!/bin/bash
if [ $# -ne 3 ]; then
    echo "Invalid input"
    echo "Enter input in the format: op1 operator op2"
    exit 1
fi

op1=$1
operator=$2
op2=$3

case $operator in
    +)
        result=$(echo "$op1 + $op2" | bc)
        ;;
    -)
        result=$(echo "$op1 - $op2" | bc)
        ;;
    x)
        result=$(echo "$op1 * $op2" | bc)
        ;;
    /)
        result=$(echo "scale=2; $op1 / $op2" | bc)
        ;;
    %)
        result=$((op1 % op2))
        ;;
    ^)
        result=$(echo "$op1 ^ $op2" | bc)
        ;;
    *)
        echo "Invalid operator"
        exit 1
        ;;
esac
echo "$op1 $operator $op2 = $result"
```

---

### **Instructions to Run Scripts**

1. Save each script with the respective name, e.g., `iaop`, `faop`, etc.
2. Make the script executable:
   ```bash
   chmod +x <script_name>
   ```
3. Run the script:
   ```bash
   ./<script_name> <arguments_if_required>
   ```
   Example:
   ```bash
   ./iaop
   ./calculator 10 x 2
   ./filechk file1.txt file2.txt
   ```
