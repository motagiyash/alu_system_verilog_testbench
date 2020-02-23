class transaction;

rand bit data_in;
rand bit [7:0] input_a;
rand bit [7:0] input_b;
rand bit [3:0] operator;
bit [7:0] result;
  
constraint constr_for_opr { operator inside {0,1,2,3};}
  
constraint constr_for_data_in { data_in == 1'b1;  }
  
 function void post_randomize();
    $display("--------- [Trans] post_randomize ------");
    $display("\tData in = %d ",data_in);
    $display("\t input a = %d \t input b = %d ",input_a, input_b);
    $display("\toperator = %d ",operator);
    $display("-----------------------------------------");
 endfunction
  
function transaction do_copy;
  transaction trans;
  trans = new();
  trans.data_in = this.data_in;
  trans.input_a = this.input_a;
  trans.input_b = this.input_b;
  trans.operator = this.operator;
  return trans;
endfunction
	
endclass


