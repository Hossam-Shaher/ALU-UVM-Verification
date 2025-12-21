`ifndef ALU_AGENT_SV
  `define ALU_AGENT_SV

  typedef class alu_agent_config;
  typedef class alu_monitor;
  typedef class alu_driver; 
  typedef class alu_sequencer;
  typedef class alu_seq_item_mon;

  class alu_agent extends uvm_agent;
    `uvm_component_utils(alu_agent)

    alu_agent_config 	m_alu_agent_config;
    alu_driver 			m_alu_driver;
    alu_sequencer		m_alu_sequencer;
    alu_monitor			m_alu_monitor;
    uvm_analysis_port#(alu_seq_item_mon)	ap;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new 

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      m_alu_agent_config = alu_agent_config::type_id::create("m_alu_agent_config", this);
      if( ! uvm_config_db#(alu_agent_config)::get(this, "", "m_alu_agent_config", m_alu_agent_config) ) begin
        `uvm_error(this.get_type_name(), "m_alu_agent_config NOT found");
      end    
      if ( m_alu_agent_config.alu_vif == null ) begin
        `uvm_error(this.get_type_name(), "m_alu_agent_config.alu_vif == null")
      end
      if ( get_is_active() == UVM_ACTIVE) begin
        m_alu_driver = alu_driver::type_id::create("m_alu_driver", this);
        m_alu_sequencer = alu_sequencer::type_id::create("m_alu_sequencer", this); 

        uvm_config_db#(virtual alu_if#(`ALU_DATA_WIDTH))::set(this, "m_alu_driver", "alu_vif", m_alu_agent_config.alu_vif);
        m_alu_sequencer.set_arbitration(m_alu_agent_config.arb_mode);
      end

      m_alu_monitor = alu_monitor::type_id::create("m_alu_monitor", this);
      uvm_config_db#(virtual alu_if#(`ALU_DATA_WIDTH))::set(this, "m_alu_monitor", "alu_vif", m_alu_agent_config.alu_vif);
/*
      m_alu_monitor.checks_enable = m_alu_agent_config.checks_enable ;
      m_alu_monitor.stuck_threshold = m_alu_agent_config.stuck_threshold ;
*/
      ap = new("ap", this);

    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
      if ( get_is_active() == UVM_ACTIVE) begin
          m_alu_driver.seq_item_port.connect(m_alu_sequencer.seq_item_export);
      end
      m_alu_monitor.ap.connect(ap);
    endfunction: connect_phase

    function uvm_active_passive_enum get_is_active();
      return uvm_active_passive_enum'(m_alu_agent_config.is_active);
    endfunction: get_is_active

  endclass: alu_agent

`endif  //ALU_AGENT_SV