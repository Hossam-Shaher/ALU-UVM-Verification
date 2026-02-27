`ifndef ALU_SEQUENCE_OVERFLOW_F_SV
  `define ALU_SEQUENCE_OVERFLOW_F_SV

  typedef class alu_seq_item_drv;
  typedef class alu_sequence_random;

  //The purpose of this sequence is to cover overflow_f and overflow_x_add_sub
    
  class alu_sequence_overflow_f extends alu_sequence_random;

    `uvm_object_utils(alu_sequence_overflow_f)
    
    localparam N = `ALU_DATA_WIDTH ;

    function new(string name = "");
      super.new(name);
    endfunction: new

    task body();
      
      item.default_a_b.constraint_mode(0);
      
      start_item(item);
      assert( item.randomize() with {
        op_code == ADD;
        //overflow condition in case of op_code == ADD
        add_overflow_f(a, b) == 1;
      } );
      finish_item(item);
      
      start_item(item);
      assert( item.randomize() with {
        op_code == SUB;
        //overflow condition in case of op_code == SUB
        sub_overflow_f(a, b) == 1;
      } );
      finish_item(item);

    endtask: body
    
    //auxiliary functions
    //-------------------
    
    //return the LHS of "overflow condition in case of op_code == ADD"
    function bit add_overflow_f(data_t a, data_t b);
      data_t result = a + b;
      return ( a[N-1] && b[N-1] && !result ) || ( !a[N-1] && !b[N-1] && result ) ;
    endfunction: add_overflow_f

    //return the LHS of "overflow condition in case of op_code == SUB"
    function bit sub_overflow_f(data_t a, data_t b);
      data_t result = a - b;
      return ( a[N-1] && !b[N-1] && !result ) || ( !a[N-1] && b[N-1] && result ) ;
    endfunction: sub_overflow_f

  endclass: alu_sequence_overflow_f

`endif //ALU_SEQUENCE_OVERFLOW_F_SV