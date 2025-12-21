`ifndef ALU_TEST_RANDOM_SV
  `define ALU_TEST_RANDOM_SV

  typedef class alu_test_base;
  typedef class alu_sequence_simple;
  typedef class alu_sequence_constrained_random;

  class alu_test_random extends alu_test_base;

    `uvm_component_utils(alu_test_random)
    
    alu_sequence_simple 				m_alu_sequence_simple;
    alu_sequence_constrained_random		m_alu_sequence_constrained_random;
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // manipulate properties of m_algn_env_config HERE
      
      m_alu_sequence_simple 			= alu_sequence_simple::type_id::create("m_alu_sequence_simple", this);
      m_alu_sequence_constrained_random = alu_sequence_constrained_random::type_id::create("m_alu_sequence_constrained_random", this);
    endfunction: build_phase 

    task run_phase (uvm_phase phase);
      phase.raise_objection(this, "alu_test_random", 1);
      #100ns;
      
      //alu_sequence_simple
      //-------------------
      
      repeat (30) begin
        assert ( m_alu_sequence_simple.randomize() );
        m_alu_sequence_simple.start(m_alu_env.m_alu_agent.m_alu_sequencer);
      end
      
      //alu_sequence_constrained_random
      //-------------------------------
      
      repeat (30) begin
        assert ( m_alu_sequence_constrained_random.randomize() );
        m_alu_sequence_constrained_random.start(m_alu_env.m_alu_agent.m_alu_sequencer);
      end
   
      #10ns;
      phase.drop_objection(this, "alu_test_random", 1);
    endtask: run_phase
    
  endclass: alu_test_random


`endif //ALU_TEST_RANDOM_SV
