class scoreboard;

mailbox mon2score;

int number_of_transaction_recived;

  function new (mailbox mon2score );
	this.mon2score = mon2score;
endfunction

task main;
	transaction trans;
  forever begin
	mon2score.get(trans);
    wait (trans.data_in == 1);
    $display ("The value of result recived by scoreboard is %d \n" , trans.result); 	
    number_of_transaction_recived++;
  end
endtask

endclass


