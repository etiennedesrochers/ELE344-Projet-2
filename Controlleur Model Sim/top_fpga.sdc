# Spécifications de contraintes pour diriger la synthèse logique du design
#

# Contrainte de la période maximum de l'horloge à 18 ns (Fmin=55.6MHz). 
# Cette contrainte concerne les chemins combinatoires entre les bascules. 
create_clock -name {CLK} -period 18.180 -waveform { 0.000 9.000 } [get_ports {clk}]

derive_clock_uncertainty



