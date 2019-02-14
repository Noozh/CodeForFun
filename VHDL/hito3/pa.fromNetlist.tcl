
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name hito3 -dir "C:/Xilinx/14.7/hito3/planAhead_run_2" -part xc3s100ecp132-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Xilinx/14.7/hito3/hito3.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Xilinx/14.7/hito3} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "hito3.ucf" [current_fileset -constrset]
add_files [list {hito3.ucf}] -fileset [get_property constrset [current_run]]
link_design
