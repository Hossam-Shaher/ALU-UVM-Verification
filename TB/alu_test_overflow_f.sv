`ifndef ALU_TEST_OVERFLOW_F_SV
  `define ALU_TEST_OVERFLOW_F_SV

  typedef class alu_test_random;
  typedef class alu_sequence_overflow_f;
  typedef class alu_sequence_random;
    
  //The purpose of this test is to cover overflow_f and overflow_x_add_sub

  class alu_test_overflow_f extends alu_test_random;

    `uvm_component_utils(alu_test_overflow_f)
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
      //You can manipulate nu_repetitions HERE
      
      alu_sequence_random::type_id::set_type_override( alu_sequence_overflow_f::get_type() );
    endfunction: new

  endclass: alu_test_overflow_f

`endif //ALU_TEST_OVERFLOW_F_SV