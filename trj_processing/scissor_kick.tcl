#
# fix PBC issue:
#
package require pbctools
pbc wrap -center com -centersel "segname PROB" -compound residue -all
pbc wrap -center com -centersel "segname PROA PROB" -compound residue -all
#----


# Change this index to specify the correct spike C_alpha selections
#set A1 [atomselect top "protein and name CA and resid 1 to 299"]
#set A2 [atomselect top "protein and name CA and resid 320 to 655"]
#set A3 [atomselect top "protein and name CA and resid 1550 to 1876"]
set C1 [atomselect top "protein and name CA and resid 1879 to 2033"]
set C2 [atomselect top "protein and name CA and resid 2038 to 2193"]
#set C1C2 [atomselect top "protein and name CA and (resid 1879 to 2033 or resid 2038 to 2193)"]
#set heavych [atomselect top "protein and name CA and (resid 1 to 299 or resid 320 to 655 or resid 1550 to 1876)"]
#set FVa [atomselect top "protein"]
#set z_offset 107.6
set hinge [atomselect top "protein and name CA and resid 2037"]

#for dihe:
set u1 [atomselect top "protein and name CA and resid 2186"]
set u2 [atomselect top "protein and name CA and resid 2127"]
set u3 [atomselect top "protein and name CA and resid 1967"]
set u4 [atomselect top "protein and name CA and resid 2026"]

#---------

#Get number of frames loaded into top molecule
set numframes [molinfo top get numframes]

#Open file for writing output
set output1 [open "scissor_kick.csv" w]

#Write a short header to the file
puts $output1 "Frame,scissor,kick"

#Loop over all frames
for {set i 0} {$i < $numframes} {incr i} {
#Advance to frame i
#Selection for the two atoms of choice
$C1 frame $i
$C2 frame $i
$hinge frame $i
$u1 frame $i
$u2 frame $i
$u3 frame $i
$u4 frame $i

$C1 update
$C2 update
$hinge update
$u1 update
$u2 update
$u3 update
$u4 update

set A [measure center $C1]
set B [measure center $hinge]
set C [measure center $C2]

set D [vecdot [vecnorm [vecsub $A $B]] [vecnorm [vecsub $C $B]]]
set scissor [expr acos($D)/3.14*180]

#dihe:
set kick [measure dihed [list [$u1 get index] [$u2 get index] [$u3 get index] [$u4 get index]] frame $i]

#Write the frame number and distance to file, separated by a tabulator
puts $output1 "$i,$scissor,$kick"
}

#Close and clean up everything


quit

