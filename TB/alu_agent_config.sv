`ifndef ALU_AGENT_CONFIG_SV
  `define ALU_AGENT_CONFIG_SV

  class alu_agent_config extends uvm_object;
    `uvm_object_utils(alu_agent_config)

    virtual alu_if 				alu_vif;
    uvm_active_passive_enum 	is_active = UVM_ACTIVE;
    uvm_sequencer_arb_mode 		arb_mode = UVM_SEQ_ARB_FIFO;

    function new(string name="");
      super.new(name);
    endfunction: new   

  endclass: alu_agent_config

`endif  //ALU_AGENT_CONFIG_SV