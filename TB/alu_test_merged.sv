`ifndef ALU_TEST_MERGED_SV
  `define ALU_TEST_MERGED_SV

  typedef class alu_test_random;
  typedef class alu_sequence_merged;
  typedef class alu_sequence_random;
  
  //alu_test_merged merges multiple test scenarios; 
  //it executes multiple sequences sequentially to achieve 100% functional coverage in a single run.
    
  class alu_test_merged extends alu_test_random;

    `uvm_component_utils(alu_test_merged)
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
      //You can manipulate nu_repetitions HERE

      alu_sequence_random::type_id::set_inst_override( alu_sequence_merged::get_type(), "m_alu_sequence_random", this);
      //This factory override shall be an instance override
      //A type override will override m_alu_sequence_random in alu_sequence_merged
      //This will lead to a stack overflow
    endfunction: new

  endclass: alu_test_merged

`endif //ALU_TEST_MERGED_SV