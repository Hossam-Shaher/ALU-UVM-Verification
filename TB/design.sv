module alu
  #(parameter N = 32) (
    input [N-1 : 0] 		a, 			//1st operand
    						b,			//2nd opperand
    input [1 : 0] 			op_code, 	//operation
    input 					clk,
    						reset,
    output logic [N-1 : 0] 	result,
    output logic 			zero_f, 	//flags
    						neg_f, 
    						c_out_f, 
    						overflow_f
  );
  
  localparam ADD = 0;
  localparam SUB = 1;
  localparam AND = 2;
  localparam OR  = 3;
  
  always_ff @(posedge clk) begin: always_blk
    
    if(reset) begin
      
      result = 0;
      {zero_f, neg_f, c_out_f, overflow_f} = 0;
      
    end 
    
    else begin
      
      case(op_code)
        ADD: begin
                {c_out_f, result} = a + b;
                overflow_f	= ( a[N-1] && b[N-1] && !result[N-1] ) || 
                              ( !a[N-1] && !b[N-1] && result[N-1] ); 
          	 end
        SUB: begin
                {c_out_f, result} = a - b;
                overflow_f 	= ( a[N-1] && !b[N-1] && !result[N-1] ) || 
                              ( !a[N-1] && b[N-1] && result[N-1] );         
             end
        AND: begin
                result		= a & b; //bitwise and
                c_out_f 	= 0;
                overflow_f 	= 0;         
             end
        OR:  begin
                result 		= a | b; //bitwise or
                c_out_f 	= 0;
                overflow_f 	= 0;         
             end
        default: $error("undefined op_code: %b", op_code);
      endcase
   
      zero_f = &(~result);	//or, simply, zero_f = (result === 0);
      neg_f	 = result[N-1];    
    end   
  
  end: always_blk
  
endmodule: alu