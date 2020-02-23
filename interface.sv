interface alu_interface (input logic clock,reset);

  		logic data_in;
  		logic [7:0] input_a;
		logic [7:0] input_b;
		logic [3:0] operator;
		logic [7:0] result;
  
	clocking alu_driver_clocking @(posedge clock );
      default input #1 output #1;
      	output data_in;
		output input_a;
		output input_b;
		output operator;
		input result;
	endclocking;
	
	clocking alu_monitor_clocking @(posedge clock );
		default input #1 output #1;
      	input data_in;
		input input_a;
		input input_b;
		input operator;
		input result;
	endclocking;
	
	modport alu_driver_mp (clocking alu_driver_clocking, input clock,reset);
	
	modport alu_monitor_mp (clocking alu_monitor_clocking, input clock,reset);
	
endinterface

