class driver;

virtual alu_interface alu_vif;

mailbox gen2drive;

int number_of_transction;

  function new (virtual alu_interface alu_vif,mailbox gen2drive);
	this.alu_vif = alu_vif;
	this.gen2drive = gen2drive;
endfunction

task reset;
  wait(alu_vif.reset);
	alu_vif.alu_driver_mp.alu_driver_clocking.input_a <= 8'b00000000;
	alu_vif.alu_driver_mp.alu_driver_clocking.input_b <= 8'b00000000;
	alu_vif.alu_driver_mp.alu_driver_clocking.operator <= 4'b0000;
  wait(!alu_vif.reset);
	$display("Reset done");
endtask

task drive;
	forever begin
	transaction trans;
	gen2drive.get(trans);
      $display ("ALU Driver Driving data ");
      @(posedge alu_vif.alu_driver_mp.clock)
        alu_vif.alu_driver_mp.alu_driver_clocking.data_in <= trans.data_in;  
	alu_vif.alu_driver_mp.alu_driver_clocking.input_a <= trans.input_a;
	alu_vif.alu_driver_mp.alu_driver_clocking.input_b <= trans.input_b;
	alu_vif.alu_driver_mp.alu_driver_clocking.operator <= trans.operator;
      $display ("Data Driven transaction number is %d ", number_of_transction);
      $display ("Input a = %d, input b = %d  ", trans.input_a, trans.input_b);      	  			  
      $display ("Data in = %b ", trans.data_in);
      $display ("operator = %b \n", trans.operator);
	number_of_transction++;
	end
endtask
  
task main;
    forever begin
      fork
        //Thread-1: Waiting for reset
        begin
          wait(alu_vif.reset);
        end
        //Thread-2: Calling drive task
        begin
            drive();
        end
      join
      disable fork;
    end
  endtask
	
endclass

