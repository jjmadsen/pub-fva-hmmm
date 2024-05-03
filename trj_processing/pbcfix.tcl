#
# fix PBC issue:
#
package require pbctools
pbc wrap -center com -centersel "segname PROB" -compound fragment -all
pbc wrap -center com -centersel "segname PROA PROB" -compound fragment -all
#----

