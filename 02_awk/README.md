# awk

<a href="https://youtu.be/8Ib3SXMlMc0" target="_blank">
  <img src="https://github.com/kokchun/assets/blob/main/linux/awk.png?raw=true" alt="DESCRIPTION" width="600">
</a>

awk is a scripting language for data extraction, filtering and reporting, which exists by default in Unix like operating systems.

## Dataset

In this lecture we use this [pokemon csv file](https://www.kaggle.com/datasets/onurgitmez/pokemon-stats-gen-1-9). I renamed it to pokemons.csv.

## Basic commands in awk

In awk processes text line by line. The columns can be accessed with

- $0 for the whole line
- $1 for column 1
- $n for column n

Simple text formatting here

```bash
# prints all lines and all columns. -F, means use comma ',' as field separator
# otherwise it defaults to space or tab as field separator
cat pokemons.csv | awk -F, '{print $0}'
cat pokemons.csv | awk -F, '{print}'

# also possible to read directly from stdin
< pokemons.csv awk -F, '{print $0}'

# pick out column n with `$n`, the comma is for adding space between
< pokemons.csv awk -F, '{print $1, $2}'

# puts a string between betwen col 2 and col 3
< pokemons.csv awk -F, '{print $1, $2}'

# pipe to column for nice table formatting using -s, -> separator comma
# it pads to longest entry
< pokemons.csv awk -F, '{print $1" "$2 "," "is of type," $10}' | column -t -s,
```

Another way to read in a file is to use awk directly

```bash
awk -F, '{print $1,$2,$3}' pokemons.csv
```

## Pattern-action rule

Basically an awk program is a list of pattern-action rules

```awk
pattern { action }

awk 'pattern1 { action1 }
     pattern2 { action2 }' file
```

### Three forms

1. `pattern { action }` - run action where pattern is true
2. `{ action }` - no pattern -> run action on every line
3. `pattern` - no action -> print line when pattern true

**Examples**

If you want to print out a csv but with tabs instead of comma

```awk
# a pattern without action 1 is always true -> defaults to print
# same behavior as cat
awk '1' pokemons.csv

```

```awk
awk -F, -v OFS='\t' '{ $1=$1 } 1' pokemons.csv
#                    ^^^^^^^^^ ^
#                    rule 1    rule 2
```

- -v to set assign a value to awk variable before program starts
- OFS - output field separator
- $1=$1 -> assigns column 1 to itself which does nothing but triggers OFS to tab, else it would print out $0
- 1 -> a pattern that is always true -> prints out

- rule 1 has an action and no pattern -> runs on all lines
- rule 2 has a pattern but no action -> defaults to print

More examples

```awk
# makes everything uppercase and prints it out
awk '{ $0=toupper($0) } 1' pokemons.csv

# uppercase for col2 and tab separated in outputs
awk -F, -v OFS='\t' '{ $2=toupper($2) } 1' pokemons.csv

# uppercase for col2 except for header and tab separated in outputs
awk -F, -v OFS='\t' '{$1=$1} NR>1 { $2=toupper($2) } 1' pokemons.csv
```

### Filter

```bash
# filters out those with ID less than or equal to 151 i.e. pokemons gen 1
< pokemons.csv awk -F, '$1<=151 { print $1"," $2","  $10}' | column -t -s,

# NR top 10 rows
awk -F, 'NR<=10' pokemons.csv

# skip header
awk -F, 'NR>1' pokemons.csv
```

### Regex matching

The structure for regex matching is

```bash
# matches the whole line
awk -F, '/regex_pattern/ {print ...} filename'

# tilde ~ to match on one field
awk -F, '$n~/regex_pattern/ {print ...}' filename
```

Here are some examples

```bash
# regex matching - matches all that has Char and char
awk -F, '$2~/[Cc]har/ {print $1, $2, $3}' pokemons.csv

# match all that ends with ard
awk -F, '$2~/ard$/ {print $1, $2, $3}' pokemons.csv

# match all that starts with pi case insensitive
awk -F, '$2~/^[pP]i/ {print $1, $2, $3}' pokemons.csv
```

More on regex in regex lecture

## awk scripts

awk scripts are standalone scripts that you write. In awk scripts you omit the quotes and run it with

```bash
awk -f script.awk pokemons.csv
```

### BEGIN/END

Controls things that happens before any line is read and after it has been read once. The flow is

```awk
[BEGIN block] - used for prep, field separator, write header
[NORMAL block] - runs for each line
[END block] - type out reports or messages when script is done
```
