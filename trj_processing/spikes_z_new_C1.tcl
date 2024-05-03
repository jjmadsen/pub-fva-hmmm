#
# fix PBC issue:
#
package require pbctools
pbc wrap -center com -centersel "segname PROB" -compound residue -all
pbc wrap -center com -centersel "segname PROA PROB" -compound residue -all
#----


# Change this index to specify the correct spike C_alpha selections
set S11 [atomselect top "protein and resid 1901"]
set S12 [atomselect top "protein and resid 1902"]
set S13 [atomselect top "protein and resid 1903"]
set S14 [atomselect top "protein and resid 1904"]

set S21 [atomselect top "protein and resid 1914"]
set S22 [atomselect top "protein and resid 1915"]
set S23 [atomselect top "protein and resid 1916"]
set S24 [atomselect top "protein and resid 1917"]
set S25 [atomselect top "protein and resid 1918"]
set S26 [atomselect top "protein and resid 1919"]
set S27 [atomselect top "protein and resid 1920"]

set S31 [atomselect top "protein and resid 1953"]
set S32 [atomselect top "protein and resid 1954"]
set S33 [atomselect top "protein and resid 1955"]
set S34 [atomselect top "protein and resid 1956"]
set S35 [atomselect top "protein and resid 1957"]
set S36 [atomselect top "protein and resid 1958"]
set S37 [atomselect top "protein and resid 1959"]
set S38 [atomselect top "protein and resid 1960"]

set z_offset 107.6
#---------

#Get number of frames loaded into top molecule
set numframes [molinfo top get numframes]

#Open file for writing output
set output1 [open "spikes_z-height_C1.csv" w]

#Write a short header to the file
puts $output1 "Frame,S11,S12,S13,S14,S21,S22,S23,S24,S25,S26,S27,S31,S32,S33,S34,S35,S36,S37,S38"

#Loop over all frames
for {set i 0} {$i < $numframes} {incr i} {
#Advance to frame i
#Selection for the two atoms of choice
$S11 frame $i
$S12 frame $i
$S13 frame $i
$S14 frame $i
$S21 frame $i
$S22 frame $i
$S23 frame $i
$S24 frame $i
$S25 frame $i
$S26 frame $i
$S27 frame $i
$S31 frame $i
$S32 frame $i
$S33 frame $i
$S34 frame $i
$S35 frame $i
$S36 frame $i
$S37 frame $i
$S38 frame $i

$S11 update
$S12 update
$S13 update
$S14 update
$S21 update
$S22 update
$S23 update
$S24 update
$S25 update
$S26 update
$S27 update
$S31 update
$S32 update
$S33 update
$S34 update
$S35 update
$S36 update
$S37 update
$S38 update


set z1 [expr { [lindex [measure center $S11] 2] - $z_offset}]
set z2 [expr { [lindex [measure center $S12] 2] - $z_offset}]
set z3 [expr { [lindex [measure center $S13] 2] - $z_offset}]
set z4 [expr { [lindex [measure center $S14] 2] - $z_offset}]

set z10 [expr { [lindex [measure center $S21] 2] - $z_offset}]
set z11 [expr { [lindex [measure center $S22] 2] - $z_offset}]
set z12 [expr { [lindex [measure center $S23] 2] - $z_offset}]
set z13 [expr { [lindex [measure center $S24] 2] - $z_offset}]
set z14 [expr { [lindex [measure center $S25] 2] - $z_offset}]
set z15 [expr { [lindex [measure center $S26] 2] - $z_offset}]
set z16 [expr { [lindex [measure center $S27] 2] - $z_offset}]

set z17 [expr { [lindex [measure center $S31] 2] - $z_offset}]
set z18 [expr { [lindex [measure center $S32] 2] - $z_offset}]
set z19 [expr { [lindex [measure center $S33] 2] - $z_offset}]
set z20 [expr { [lindex [measure center $S34] 2] - $z_offset}]
set z21 [expr { [lindex [measure center $S35] 2] - $z_offset}]
set z22 [expr { [lindex [measure center $S36] 2] - $z_offset}]
set z23 [expr { [lindex [measure center $S37] 2] - $z_offset}]
set z24 [expr { [lindex [measure center $S38] 2] - $z_offset}]

#Write the frame number and distance to file, separated by a tabulator
puts $output1 "$i,$z1,$z2,$z3,$z4,$z10,$z11,$z12,$z13,$z14,$z15,$z16,$z17,$z18,$z19,$z20,$z21,$z22,$z23,$z24"
}

#Close and clean up everything


quit

