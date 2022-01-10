transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/UART_RX.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/vga_xy_controller.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/sprite_rom.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/background_rom.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/display_sprite.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/displayscoreboard.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/sprite_manager.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/framerate_clock.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/datapath.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/controller.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/system.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/system_de2.v}
vlog -vlog01compat -work work +incdir+G:/My\ Drive/Logic\ Design\ FA21/VGA/verilog {G:/My Drive/Logic Design FA21/VGA/verilog/scoreboard.v}

