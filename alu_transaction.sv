class alu_transaction;

rand bit [7:0] input_a;
rand bit [7:0] input_b;
rand bit [3:0] operator;
bit calculated;
bit [7:0] result;

constraint constr_for_opr { operator inside {0,1,2,3};}

endclass
