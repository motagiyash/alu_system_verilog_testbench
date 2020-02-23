`include "interface.sv"
`include "test.sv"

module alu_test_top;

bit clock,reset;

always #5 clock = ~clock;

initial begin
	reset = 1;
    	#5 reset =0;
end

alu_interface alu_vif(clock,reset);

alu_test alu_simple_test(alu_vif);

alu DUT (.clock(alu_vif.clock),
	.reset(alu_vif.reset),
        .data_in(alu_vif.data_in),
	.input_a(alu_vif.input_a),
	.input_b(alu_vif.input_b),
	.operator(alu_vif.operator),
	.result(alu_vif.result));
  
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end 

endmodule
