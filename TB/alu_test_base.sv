`ifndef ALU_TEST_BASE_SV
  `define ALU_TEST_BASE_SV

  typedef class alu_env;
  typedef class alu_env_config;

  class alu_test_base extends uvm_test;

    `uvm_component_utils(alu_test_base)

    alu_env 		m_alu_env;
    alu_env_config	m_alu_env_config;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      m_alu_env			= alu_env::type_id::create("m_alu_env", this); 
      m_alu_env_config 	= alu_env_config::type_id::create("m_alu_env_config", this);  

      if( ! uvm_config_db#(virtual alu_if#(`ALU_DATA_WIDTH))::get(this, "", "alu_vif", m_alu_env_config.m_alu_agent_config.alu_vif) ) begin
        `uvm_error(this.get_type_name(), "alu_vif NOT found")
      end

      uvm_config_db#(alu_env_config)::set(this, "m_alu_env", "m_alu_env_config", m_alu_env_config);

    endfunction: build_phase 

  endclass: alu_test_base

`endif //ALU_TEST_BASE_SV