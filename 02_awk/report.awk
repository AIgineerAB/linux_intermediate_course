# FS is a variable for field separator while -F is the command line option
BEGIN { FS=","; print "=== Fire Pokemon ==="}
$10 ~ /[fF]ire/ { 
    print $1, $2, $5
    n++; total_attack+=$5
}

END {printf "Count: %d, avg attack: %.1f\n",n,total_attack/n}