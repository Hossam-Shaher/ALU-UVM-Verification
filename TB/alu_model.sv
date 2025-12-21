`ifndef ALU_MODEL_SV
  `define ALU_MODEL_SV

  typedef class alu_seq_item_mon;
    
  class alu_model extends uvm_component;
    
    `uvm_component_utils(alu_model)
     
    uvm_analysis_imp#(alu_seq_item_mon, alu_model) analysis_imp;	//for receiving information from the agent
    
    uvm_analysis_port#(alu_seq_item_mon) analysis_port;		//for sending the expected transactions to the scorebored
            
    extern function new (string name = "", uvm_component parent);
    
    extern function void build_phase (uvm_phase phase);

    extern function void write (alu_seq_item_mon item);
      
  endclass: alu_model
      
  /**************************************************************************/    
  /***************************** IMPLEMENTATION *****************************/    
  /**************************************************************************/ 

  //new
  //---
      
  function alu_model:: new(string name = "", uvm_component parent);
    super.new(name, parent);  
  endfunction
      
  //build_phase
  //-----------
      
  function void alu_model:: build_phase(uvm_phase phase);
    super.build_phase(phase);

    analysis_imp  = new("analysis_imp",  this);
    analysis_port = new("analysis_port", this);

  endfunction: build_phase

  //write
  //-----
      
  function void alu_model:: write(alu_seq_item_mon item);
    localparam N = `ALU_DATA_WIDTH ;
    
    if(item.reset) begin
     
      item.result = 0;
      {item.zero_f, item.neg_f, item.c_out_f, item.overflow_f} = 0;
      
    end 
    
    else begin
      
      case(item.op_code)
        ADD: begin
                {item.c_out_f, item.result} = item.a + item.b;
                item.overflow_f	= ( item.a[N-1] && item.b[N-1] && !item.result[N-1] ) || 
                                  ( !item.a[N-1] && !item.b[N-1] && item.result[N-1] ); 
          	 end
        SUB: begin
                {item.c_out_f, item.result} = item.a - item.b;
                item.overflow_f = ( item.a[N-1] && !item.b[N-1] && !item.result[N-1] ) || 
                                  ( !item.a[N-1] && item.b[N-1] && item.result[N-1] );         
             end
        AND: begin
                item.result		= item.a & item.b; //bitwise and
                item.c_out_f 	= 0;
                item.overflow_f = 0;         
             end
        OR:  begin
                item.result 	= item.a | item.b; //bitwise or
                item.c_out_f 	= 0;
                item.overflow_f = 0;         
             end
        default: $error("undefined op_code: %b", item.op_code);
      endcase
   
      item.zero_f = (item.result === 0);
      item.neg_f  = item.result[N-1];    
    end 
    
    analysis_port.write(item);
    
  endfunction: write

`endif //ALU_MODEL_SV