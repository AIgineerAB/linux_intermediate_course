# awk

<a href="" target="_blank">
  <img src="https://github.com/kokchun/assets/blob/main/FOLDER_NAME/.png?raw=true" alt="DESCRIPTION" width="600">
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


### Filter

```bash
# filters out those with ID less than or equal to 151 i.e. pokemons gen 1
< pokemons.csv awk -F, '$1<=151 { print $1"," $2","  $10}' | column -t -s,

# NR top 10 rows
awk -F, 'NR<=10' pokemons.csv

# skip header
awk -F, 'NR>1' pokemons.csv
```

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
