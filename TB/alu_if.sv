`ifndef ALU_IF_SV
  `define ALU_IF_SV

  interface alu_if #(parameter N = 32) (input logic clk);
    logic [N-1 : 0] 	a, 			//1st operand
    					b;			//2nd opperand
    logic [1 : 0] 		op_code; 	//operation
    logic 				reset;
    					
    logic [N-1 : 0] 	result;
    logic 				zero_f, 	//flags
    					neg_f, 
    					c_out_f, 
    					overflow_f;
    
  endinterface: alu_if 

`endif // ALU_IF_SV