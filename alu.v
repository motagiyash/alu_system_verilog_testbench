module alu ( clock,reset,data_in,input_a,input_b,operator,result);
//Active high reset
input clock,reset;
input data_in;
input [7:0] input_a;
input [7:0] input_b;
input [3:0] operator;
output wire [7:0] result;

reg [7:0] result_internal;
reg calculated_internal;
  
assign result = result_internal;       
assign calculated = calculated_internal;

always@(posedge(clock))
begin
	if (reset == 1) 
		begin
      			result_internal <= 8'b00000000;
    		end
  	if (data_in == 1'b1)
          	begin
			case (operator)  // number of bits in a word
				4'b0000 : result_internal  <= input_a ;
				4'b0001 : result_internal  <= input_a ;
				4'b0010 : result_internal  <= input_a ;
				4'b0011 : result_internal  <= input_a ;
				default: result_internal <= 8'bxxxxxxxx;
		        endcase
          	end	
end

endmodule;
