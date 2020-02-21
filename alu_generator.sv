class alu_generator;

rand alu_transaction trans;

mailbox gen2drive;

int number_of_randomization;

event randomization_done;

function new(mailbox gen2drive);
	this.gen2drive = gen2drive;
endfunction

task main();
	repeat (number_of_randomization) begin
	trans = new();
	if(!trans.randomize()) $fatal( "Generator transaction randomization failed");
	gen2drive.put(trans);
	end
	-> randomization_done; $display ("All randomization done")//Blocking event will wait for all randomization to be compleated.
endtask

endclass