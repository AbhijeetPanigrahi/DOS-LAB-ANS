# Script 1: prog
# Merges the content of files a.txt, b.txt, and c.txt, sorts them, saves the result in result, and displays it.
cat a.txt b.txt c.txt | sort > result
echo "Sorted content of a.txt, b.txt, and c.txt:" 
cat result

# Script 2: systeminfo
# Displays login name, Unix system name, shell type, current directory path, and files in the directory.
echo "Login Name: $(whoami)"
echo "System Name: $(uname)"
echo "Shell Type: $SHELL"
echo "Current Working Directory: $(pwd)"
echo "Files in Current Directory:"
ls

# Script 3: dtcal
# Displays system date and calendar for a specific month and year.
echo "Date: $(date '+%Y-%m-%d')"
echo "Calendar for March 2022:"
cal 3 2022

# Script 4: nvwc
# Displays filename, line count, word count, and character count of dtcal file.
echo "Filename: dtcal"
line_count=$(wc -l < dtcal)
word_count=$(wc -w < dtcal)
char_count=$(wc -c < dtcal)
echo "Line count: $line_count"
echo "Word count: $word_count"
echo "Char count: $char_count"

# Script 5: nvwc2
# Displays filename, line count, word count, and character count of a file given as argument.
if [ $# -eq 1 ]; then
  file=$1
  echo "Filename: $file"
  line_count=$(wc -l < "$file")
  word_count=$(wc -w < "$file")
  char_count=$(wc -c < "$file")
  echo "Line count: $line_count"
  echo "Word count: $word_count"
  echo "Char count: $char_count"
else
  echo "Usage: ./nvwc2 <filename>"
fi

# Script 6: darg
# Displays the total number of command line arguments, first two arguments, and all arguments.
echo "Total number of arguments: $#"
echo "First argument: $1"
echo "Second argument: $2"
echo "All arguments: $@"

# Script 7: ndisp
# Takes n, m, and a filename as arguments and displays the first n and last m lines of the file.
if [ $# -eq 3 ]; then
  n=$1
  m=$2
  file=$3
  echo "First $n lines of $file:"
  head -n $n "$file"
  echo "Last $m lines of $file:"
  tail -n $m "$file"
else
  echo "Usage: ./ndisp <n> <m> <filename>"
fi
