`include "enviornment.sv"

program alu_test (alu_interface alu_vif);
    
enviornment env;

initial begin
	env =new(alu_vif);
	env.gen.number_of_randomization = 5;
	env.run();
	end

endprogram
