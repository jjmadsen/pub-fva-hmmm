#
# fix PBC issue:
#
package require pbctools
pbc wrap -center com -centersel "segname PROB" -compound residue -all
pbc wrap -center com -centersel "segname PROA PROB" -compound residue -all
#----


# Change this index to specify the correct spike C_alpha selections
set A1 [atomselect top "protein and name CA and resid 1 to 299"]
set A2 [atomselect top "protein and name CA and resid 320 to 655"]
set A3 [atomselect top "protein and name CA and resid 1550 to 1876"]
set C1 [atomselect top "protein and name CA and resid 1879 to 2033"]
set C2 [atomselect top "protein and name CA and resid 2038 to 2193"]
set FVa [atomselect top "protein"]
set z_offset 107.6
#---------

#Get number of frames loaded into top molecule
set numframes [molinfo top get numframes]

#Open file for writing output
set output1 [open "domains_z-height.csv" w]

#Write a short header to the file
puts $output1 "Frame,A1_z,A2_z,A3_z,C1_z,C2_z,FVa"

#Loop over all frames
for {set i 0} {$i < $numframes} {incr i} {
#Advance to frame i
#Selection for the two atoms of choice
$A1 frame $i
$A2 frame $i
$A3 frame $i
$C1 frame $i
$C2 frame $i
$FVa frame $i
$A1 update
$A2 update
$A3 update
$C1 update
$C2 update
$FVa update

set zA1 [expr { [lindex [measure center $A1] 2] - $z_offset}]
set zA2 [expr { [lindex [measure center $A2] 2] - $z_offset}]
set zA3 [expr { [lindex [measure center $A3] 2] - $z_offset}]
set zC1 [expr { [lindex [measure center $C1] 2] - $z_offset}]
set zC2 [expr { [lindex [measure center $C2] 2] - $z_offset}]
set zFVa [expr { [lindex [measure center $FVa] 2] - $z_offset}]

#Write the frame number and distance to file, separated by a tabulator
puts $output1 "$i,$zA1,$zA2,$zA3,$zC1,$zC2,$zFVa"
}

#Close and clean up everything


quit

