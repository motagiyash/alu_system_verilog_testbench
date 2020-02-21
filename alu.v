module alu ( clock,input_a,input_b,operator,calculated,result);
//I have not included reset because i have to keep the design of testbench easy to build and understand but reset is very essintial in all DUT designs.
input clock;
input [7:0] input_a;
input [7:0] input_b;
input [3:0] operator;
output calculated;
output [7:0] result;

reg [7:0] result_internal;
reg calculated_internal;

always@(posedge(clock))
begin
case (operator)  // number of bits in a word
	4'b0000 : result_internal  <= input_a + input_b;
	4'b0001 : result_internal  <= input_a + input_b;
	4'b0010 : result_internal  <= input_a + input_b;
	4'b0011 : result_internal  <= input_a + input_b;
	default: result <= 7'bxxxxxx;
      endcase 
#10;
$display ("Calculation Done");
calculated_internal <= 1;
#5;
calculated_internal <= 0;
end

assign result = result_internal;       
assign calculated = calculated_internal;

endmodule;
