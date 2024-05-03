source contactFreq.tcl

echo "Beginning.."
contactFreq "protein" "resname POPS POPC" 0 3 prot-lip_cutoff3.dat
echo "1/9"
contactFreq "protein" "resname POPS POPC" 0 4 prot-lip_cutoff4.dat
echo "2/9"
contactFreq "protein" "resname POPS POPC" 0 5 prot-lip_cutoff5.dat
echo "3/9"

contactFreq "protein" "resname POPS" 0 3 prot-PS_cutoff3.dat
echo "4/9"
contactFreq "protein" "resname POPS" 0 4 prot-PS_cutoff4.dat
echo "5/9"
contactFreq "protein" "resname POPS" 0 5 prot-PS_cutoff5.dat
echo "6/9"

contactFreq "protein" "resname POPC" 0 3 prot-PC_cutoff3.dat
echo "7/9"
contactFreq "protein" "resname POPC" 0 4 prot-PC_cutoff4.dat
echo "8/9"
contactFreq "protein" "resname POPC" 0 5 prot-PC_cutoff5.dat
echo "9/9"

echo "Quitting.."

quit
