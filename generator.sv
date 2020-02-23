class generator;

rand transaction trans,trans_for_copy;

mailbox gen2drive;

int number_of_randomization;

event randomization_done;

function new(mailbox gen2drive, event randomization_done);
	this.gen2drive = gen2drive;
	this.randomization_done = randomization_done;
endfunction

task main();
	repeat (number_of_randomization) begin
	trans = new();
      if(!trans.randomize()) $fatal( "Generator transaction randomization failed \n");
    trans_for_copy = trans.do_copy;
      gen2drive.put(trans_for_copy);
	end
  -> randomization_done; $display ("All randomization done \n");//Blocking event will wait for all randomization to be compleated.
endtask

endclass
