# awk

<a href="" target="_blank">
  <img src="https://github.com/kokchun/assets/blob/main/FOLDER_NAME/.png?raw=true" alt="DESCRIPTION" width="600">
</a>

awk is a scripting language for data extraction, filtering and reporting, which exists by default in Unix like operating systems.

## Dataset

In this lecture we use this [pokemon csv file](https://www.kaggle.com/datasets/maca11/all-pokemon-dataset?resource=download). I renamed it to pokemons.csv.

## Basic commands in awk 

In awk, it processes the text line by line. Simple text formatting here  

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
< pokemons.csv awk -F, '{print $1" "$2 "," "is of type," $3}' | column -t -s,
```

Combine several 
