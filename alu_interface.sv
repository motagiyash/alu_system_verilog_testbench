interface alu_interface (input logic clock);

	clocking alu_driver_clocking @(posedge clock );
		output [7:0] input_a;
		output [7:0] input_b;
		output [3:0] operator;
		input calculated;
		input [7:0] result;
	endclocking;
	
	clocking alu_monitor_clocking @(posedge clock );
		default input #1;
		input [7:0] input_a;
		input [7:0] input_b;
		input [3:0] operator;
		input calculated;
		input [7:0] result;
	endclocking;
	
	modport alu_driver_mp (clocking alu_driver_clocking, input clock);
	
	modport alu_monitor_mp (clocking alu_monitor_clocking, input clock);
	
endinterface