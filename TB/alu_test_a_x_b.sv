`ifndef ALU_TEST_A_X_B_SV
  `define ALU_TEST_A_X_B_SV

  typedef class alu_test_random;
  typedef class alu_sequence_a_x_b;
  typedef class alu_sequence_random;
    
  //The purpose of this sequence is to cover a_x_b (a coverage cross in the coverage model)
    
  class alu_test_a_x_b extends alu_test_random;

    `uvm_component_utils(alu_test_a_x_b)
    
    function new(string name, uvm_component parent);
      super.new(name, parent);
      //You can manipulate nu_repetitions HERE
      
      alu_sequence_random::type_id::set_type_override( alu_sequence_a_x_b::get_type() );
    endfunction: new

  endclass: alu_test_a_x_b

`endif //ALU_TEST_A_X_B_SV