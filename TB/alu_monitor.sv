`ifndef ALU_MONITOR
  `define ALU_MONITOR

  typedef class alu_seq_item_mon;

  class alu_monitor extends uvm_monitor;

    `uvm_component_utils(alu_monitor)

    virtual alu_if#(`ALU_DATA_WIDTH) 		alu_vif;
    uvm_analysis_port#(alu_seq_item_mon) 	ap;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      ap = new("ap", this);

      if( ! uvm_config_db#(virtual alu_if#(`ALU_DATA_WIDTH))::get(this, "", "alu_vif", alu_vif) ) begin
        `uvm_error( this.get_type_name(), "alu_vif NOT found" )
      end    
    endfunction: build_phase

    task run_phase(uvm_phase phase);
      forever begin
          monitor();  
      end
    endtask: run_phase

    extern local task monitor();

  endclass: alu_monitor

  //monitor
  task alu_monitor:: monitor();
    alu_seq_item_mon item;
    item = alu_seq_item_mon::type_id::create("item");
    
    @(posedge alu_vif.clk);  
    
    item.a 			= alu_vif.a;
    item.b 			= alu_vif.b;
    item.op_code 	= op_code_enum'(alu_vif.op_code);
    item.reset 		= alu_vif.reset;

    item.result 	= alu_vif.result;
    item.zero_f 	= alu_vif.zero_f;
    item.neg_f 		= alu_vif.neg_f;
    item.c_out_f 	= alu_vif.c_out_f;
    item.overflow_f = alu_vif.overflow_f;
    
    ap.write(item);

    `uvm_info(this.get_type_name(), item.convert2string, UVM_LOW) 
  endtask: monitor
    
`endif //ALU_MONITOR