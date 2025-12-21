`ifndef ALU_ENV_CONFIG_SV
  `define ALU_ENV_CONFIG_SV

  typedef class alu_agent_config;

  class alu_env_config extends uvm_object;
    `uvm_object_utils(alu_env_config)

    alu_agent_config m_alu_agent_config;

    bit coverage_enable = 1;			//if this field == 1, alu_coverage_collector will be instantiated in the env 

    function new(string name="");
      super.new(name);

      m_alu_agent_config = alu_agent_config::type_id::create("m_alu_agent_config");
    endfunction: new   

  endclass: alu_env_config

`endif  //ALU_ENV_CONFIG_SV