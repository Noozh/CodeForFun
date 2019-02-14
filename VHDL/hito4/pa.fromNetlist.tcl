
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name hito4 -dir "C:/Xilinx/14.7/hito4/planAhead_run_1" -part xc3s100ecp132-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Xilinx/14.7/hito4/hito4.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Xilinx/14.7/hito4} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "hito4.ucf" [current_fileset -constrset]
add_files [list {hito4.ucf}] -fileset [get_property constrset [current_run]]
link_design
