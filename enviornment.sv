`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class enviornment;

generator gen;
driver driv;

monitor mon;
scoreboard score;

mailbox gen2drive;
mailbox mon2score;

event randomization_done;

virtual alu_interface alu_vif;

  function new (virtual alu_interface alu_vif);
	this.alu_vif = alu_vif;
	gen2drive = new();
    	mon2score = new();
	gen = new( gen2drive,randomization_done );
	driv = new ( alu_vif,gen2drive );
	mon = new ( alu_vif,mon2score);
	score = new ( mon2score );
endfunction

task pre_test;
	driv.reset();
endtask
  
  
task test;
	fork 
	driv.main();
	gen.main();
	mon.main();
	score.main();
    join_any;
endtask

task post_test;
    wait(randomization_done.triggered);
	wait(gen.number_of_randomization == driv.number_of_transction);
    wait(gen.number_of_randomization == score.number_of_transaction_recived);
    $display("Total number of transaction recived by scoreboard is %d \n",score.number_of_transaction_recived);
endtask

  task run;
    pre_test();
    test();
    post_test();
    $finish;
  endtask;
endclass
