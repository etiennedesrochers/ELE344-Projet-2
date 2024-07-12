transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/desro/Documents/ELE344/Projet 2/ELE344-Projet-2/Controlleur Model Sim/ual.vhd}
vcom -93 -work work {C:/Users/desro/Documents/ELE344/Projet 2/ELE344-Projet-2/Controlleur Model Sim/regfile.vhd}
vcom -93 -work work {C:/Users/desro/Documents/ELE344/Projet 2/ELE344-Projet-2/Controlleur Model Sim/pcplus4.vhd}
vcom -93 -work work {C:/Users/desro/Documents/ELE344/Projet 2/ELE344-Projet-2/Controlleur Model Sim/pc.vhd}
vcom -93 -work work {C:/Users/desro/Documents/ELE344/Projet 2/ELE344-Projet-2/Controlleur Model Sim/mux2.vhd}
vcom -93 -work work {C:/Users/desro/Documents/ELE344/Projet 2/ELE344-Projet-2/Controlleur Model Sim/imem.vhd}
vcom -93 -work work {C:/Users/desro/Documents/ELE344/Projet 2/ELE344-Projet-2/Controlleur Model Sim/dmem.vhd}
vcom -93 -work work {C:/Users/desro/Documents/ELE344/Projet 2/ELE344-Projet-2/Controlleur Model Sim/control.vhd}
vcom -93 -work work {C:/Users/desro/Documents/ELE344/Projet 2/ELE344-Projet-2/Controlleur Model Sim/datapath.vhd}
vcom -93 -work work {C:/Users/desro/Documents/ELE344/Projet 2/ELE344-Projet-2/Controlleur Model Sim/mips.vhd}
vcom -93 -work work {C:/Users/desro/Documents/ELE344/Projet 2/ELE344-Projet-2/Controlleur Model Sim/top.vhd}

