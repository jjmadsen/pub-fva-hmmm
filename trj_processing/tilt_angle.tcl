#
# fix PBC issue:
#
package require pbctools
pbc wrap -center com -centersel "segname PROB" -compound residue -all
pbc wrap -center com -centersel "segname PROA PROB" -compound residue -all
#----


# Change this index to specify the correct spike C_alpha selections
#set A1 [atomselect top "protein and name CA and resid 1 to 299"]
set A2 [atomselect top "protein and name CA and resid 320 to 655"]
#set A3 [atomselect top "protein and name CA and resid 1550 to 1876"]
#set C1 [atomselect top "protein and name CA and resid 1879 to 2033"]
#set C2 [atomselect top "protein and name CA and resid 2038 to 2193"]
set C1C2 [atomselect top "protein and name CA and (resid 1879 to 2033 or resid 2038 to 2193)"]
#set heavych [atomselect top "protein and name CA and (resid 1 to 299 or resid 320 to 655 or resid 1550 to 1876)"]
#set FVa [atomselect top "protein"]
#set z_offset 107.6
#---------

#Get number of frames loaded into top molecule
set numframes [molinfo top get numframes]

#Open file for writing output
set output1 [open "tilt_angle.csv" w]

#Write a short header to the file
puts $output1 "Frame,tilt_angle"

#Loop over all frames
for {set i 0} {$i < $numframes} {incr i} {
#Advance to frame i
#Selection for the two atoms of choice
$A2 frame $i
$C1C2 frame $i
$A2 update
$C1C2 update

set A [measure center $A2]
set B [measure center $C1C2]
set C [vecdot [vecnorm [vecsub $A $B]] {0 0 1}]
set tilt [expr acos($C)/3.14*180]

#Write the frame number and distance to file, separated by a tabulator
puts $output1 "$i,$tilt"
}

#Close and clean up everything


quit

