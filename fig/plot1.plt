outFile = "plot1.pdf"

set term pdfcairo enhanced size 9,6 font "Helvetica,32" lw 2
set out outFile
set key at graph 0.1, graph 0.9 left top Left

p "data1.dat" t "y=x", 'data2.dat' t "y=2x", "data3.dat" t "y=3x", 'data1.dat' t "y=x"

print sprintf("Saved: %s",outFile)
