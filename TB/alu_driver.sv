`ifndef ALU_DRIVER
  `define ALU_DRIVER

  typedef class alu_seq_item_drv;

  class alu_driver extends uvm_driver#(alu_seq_item_drv);

    `uvm_component_utils(alu_driver)

    virtual alu_if#(`ALU_DATA_WIDTH) alu_vif;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if( ! uvm_config_db#(virtual alu_if#(`ALU_DATA_WIDTH))::get(this, "", "alu_vif", alu_vif) ) begin
        `uvm_error( this.get_type_name(), "alu_vif NOT found" )
      end    
    endfunction: build_phase

    task run_phase(uvm_phase phase);
      initialize();

      forever begin
        seq_item_port.get_next_item(req);
          drive(req);            
        seq_item_port.item_done();
      end
    endtask: run_phase

    extern local task initialize();

    extern local task drive(alu_seq_item_drv req);

  endclass: alu_driver

  //initialize
  task alu_driver:: initialize();
    alu_vif.a		= 0;
    alu_vif.b		= 0;
    alu_vif.op_code = ADD;
    alu_vif.reset	= 0;
  endtask

  //drive
  task alu_driver:: drive(alu_seq_item_drv req);
    @(posedge alu_vif.clk);
    
    alu_vif.a		= req.a;
    alu_vif.b		= req.b;
    alu_vif.op_code = req.op_code;
    alu_vif.reset	= req.reset;    
    
    `uvm_info(this.get_type_name(), req.convert2string, UVM_LOW) 
  endtask: drive
    
`endif //ALU_DRIVER