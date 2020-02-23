class monitor;

virtual alu_interface alu_vif;

mailbox mon2score;

function new (virtual alu_interface alu_vif, mailbox mon2score);
	this.alu_vif = alu_vif;
	this.mon2score = mon2score;
endfunction

task main;
  forever begin
	transaction trans;
  	trans = new();
    
    wait (alu_vif.alu_monitor_mp.alu_monitor_clocking.data_in == 1'b1);
    @(posedge alu_vif.alu_driver_mp.clock)
    $display ("Monitor data in recived "); 
    $display ("Monitor result recived %d \n", alu_vif.alu_monitor_mp.alu_monitor_clocking.result);
    trans.data_in <= alu_vif.alu_monitor_mp.alu_monitor_clocking.data_in;
    trans.input_a <= alu_vif.alu_monitor_mp.alu_monitor_clocking.input_a;
    trans.input_b <= alu_vif.alu_monitor_mp.alu_monitor_clocking.input_b;
    trans.result <= alu_vif.alu_monitor_mp.alu_monitor_clocking.result;
	mon2score.put(trans);
  end
endtask
  
endclass



