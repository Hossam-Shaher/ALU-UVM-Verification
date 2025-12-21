`include "alu_pkg.sv"

module tb; 
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import alu_pkg::*;
  
  //Clock generator
  logic clk = 0;
  always #`CLK clk = ~clk;

  //Interface
  alu_if #(.N(`ALU_DATA_WIDTH)) alu_if_inst( .clk( clk ) );
  
  //DUT
  alu #(.N(`ALU_DATA_WIDTH)) dut (
    .a			( alu_if_inst.a 		),
    .b			( alu_if_inst.b			),
    .op_code	( alu_if_inst.op_code	),
    .clk		( clk					),
    .reset		( alu_if_inst.reset		),
    .result		( alu_if_inst.result	),
    .zero_f		( alu_if_inst.zero_f	),
    .neg_f		( alu_if_inst.neg_f		),
    .c_out_f	( alu_if_inst.c_out_f	),
    .overflow_f	( alu_if_inst.overflow_f)   
  );
  
  //Initial reset generator
  initial begin
    alu_if_inst.op_code = ADD;
    
    alu_if_inst.reset = 0;
    #3  alu_if_inst.reset = 1;
    #30 alu_if_inst.reset = 0;    
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
    uvm_config_db#(virtual alu_if#(`ALU_DATA_WIDTH)):: set(null, "uvm_test_top", "alu_vif", alu_if_inst);
    
    run_test("algn_test_base"); 
    //Default test is "alu_test_base" 
    //Use +UVM_TESTNAME=<class name> to choose another test
  end
  
endmodule: tb