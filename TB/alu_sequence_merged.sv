`ifndef ALU_SEQUENCE_MERGED_SV
  `define ALU_SEQUENCE_MERGED_SV

  typedef class alu_seq_item_drv;
  typedef class alu_sequence_random;
  typedef class alu_sequence_a_x_b;
  typedef class alu_sequence_overflow_f;

  //The purpose of this hierarchical sequence is to execute 
  //alu_sequence_random, alu_sequence_a_x_b, and alu_sequence_overflow_f sequentially
    
  class alu_sequence_merged extends alu_sequence_random;

    `uvm_object_utils(alu_sequence_merged)
        
    alu_sequence_random 		m_alu_sequence_random;
    alu_sequence_a_x_b			m_alu_sequence_a_x_b;
    alu_sequence_overflow_f		m_alu_sequence_overflow_f;
    
    function new(string name = "");
      super.new(name);
      
      m_alu_sequence_random 	= alu_sequence_random::type_id::create("m_alu_sequence_random");
      m_alu_sequence_a_x_b 		= alu_sequence_a_x_b::type_id::create("m_alu_sequence_a_x_b");
      m_alu_sequence_overflow_f = alu_sequence_overflow_f::type_id::create("m_alu_sequence_overflow_f");
      //Do NOT insert a 2nd actual argument "this", bcz "this" shall be a component
    endfunction: new

    task body();
      
      m_alu_sequence_random.start(get_sequencer(), this);		//get_sequencer() returns m_sequencer of this hierarchical sequence
      m_alu_sequence_a_x_b.start(get_sequencer(), this);
      m_alu_sequence_overflow_f.start(get_sequencer(), this);

    endtask: body

  endclass: alu_sequence_merged

`endif //ALU_SEQUENCE_MERGED_SV