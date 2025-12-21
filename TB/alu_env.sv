`ifndef ALU_ENV_SV
  `define ALU_ENV_SV

  typedef class alu_env_config;
  typedef class alu_agent;
  typedef class alu_coverage_collector;
  typedef class alu_model;  
  typedef class alu_scoreboard;

  class alu_env extends uvm_env;

    `uvm_component_utils(alu_env)

    alu_env_config 				m_alu_env_config;
    alu_agent 					m_alu_agent;
    alu_coverage_collector 		m_alu_coverage_collector;
    alu_model 					m_alu_model;
    alu_scoreboard				m_alu_scoreboard;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new

    extern function void build_phase(uvm_phase phase);

    extern function void connect_phase(uvm_phase phase);

  endclass: alu_env
      
  /**************************************************************************/    
  /***************************** IMPLEMENTATION *****************************/    
  /**************************************************************************/    
      

  //build_phase
  //-----------

  function void alu_env:: build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_alu_env_config = alu_env_config::type_id::create("m_alu_env_config", this);
    if( ! uvm_config_db#(alu_env_config)::get(this, "", "m_alu_env_config", m_alu_env_config) ) begin
      `uvm_error(this.get_type_name(), "m_alu_env_config NOT found")
    end    
    // manipulate properties of m_algn_env_config HERE

    m_alu_agent = alu_agent::type_id::create("m_alu_agent", this);
    if( m_alu_env_config.coverage_enable == 1 )
        m_alu_coverage_collector = alu_coverage_collector::type_id::create("m_alu_coverage_collector", this);

    uvm_config_db#(alu_agent_config)::set(this, "m_alu_agent", "m_alu_agent_config", m_alu_env_config.m_alu_agent_config);

    m_alu_model = alu_model::type_id::create("m_alu_model", this);
/*    
    if ( m_alu_env_config.alu_vif == null ) begin
      `uvm_error(this.get_type_name(), "m_alu_env_config.alu_vif == null")
    end
    uvm_config_db#(virtual alu_if#(`ALU_DATA_WIDTH)):: set(this, "m_alu_model" , "alu_vif", m_alu_env_config.alu_vif);
*/    
    m_alu_scoreboard = alu_scoreboard::type_id::create("m_alu_scoreboard", this);
  endfunction: build_phase 

  //connect_phase
  //-------------

  function void alu_env:: connect_phase(uvm_phase phase);
    
    if( m_alu_env_config.coverage_enable == 1 )
        m_alu_agent.ap.connect(m_alu_coverage_collector.analysis_export);

    m_alu_agent.ap.connect(m_alu_model.analysis_imp);

    m_alu_agent.ap.connect(m_alu_scoreboard.export_in_agent);
        
    m_alu_model.analysis_port.connect(m_alu_scoreboard.export_in_model);
    
  endfunction: connect_phase 
    
`endif //ALU_ENV_SV