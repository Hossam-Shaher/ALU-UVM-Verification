`ifndef ALU_SEQUENCE_CONSTRAINED_RANDOM_SV
  `define ALU_SEQUENCE_CONSTRAINED_RANDOM_SV

  typedef class alu_seq_item_drv;

  class alu_sequence_constrained_random extends uvm_sequence#(alu_seq_item_drv);

    `uvm_object_utils(alu_sequence_constrained_random)

    localparam N = `ALU_DATA_WIDTH ;    
    
    rand alu_sequence_simple 	m_alu_sequence_simple;

    function new(string name = "");
      super.new(name);
      m_alu_sequence_simple = alu_sequence_simple::type_id::create("m_alu_sequence_simple");       
    endfunction: new

    task body();
      //constrained randomization to reach corners

      m_alu_sequence_simple.item.default_a_b.constraint_mode(0);

      //hit a_x_b
      //---------
      
      assert ( m_alu_sequence_simple.randomize() with {
        item.a inside { [1:$] };
        item.b inside { [1:$] };
      } );
      m_alu_sequence_simple.start(m_sequencer);

      assert ( m_alu_sequence_simple.randomize() with {
        item.a inside { [1:$] };
        item.b inside { [$ : -1] };
      } );
      m_alu_sequence_simple.start(m_sequencer);

      assert ( m_alu_sequence_simple.randomize() with {
        item.a inside { [1:$] };
        item.b inside { 0 };
      } );
      m_alu_sequence_simple.start(m_sequencer);
      
      assert ( m_alu_sequence_simple.randomize() with {
        item.a inside { [$ : -1] };
        item.b inside { [1:$] };
      } );
      m_alu_sequence_simple.start(m_sequencer);

      assert ( m_alu_sequence_simple.randomize() with {
        item.a inside { [$ : -1] };
        item.b inside { [$ : -1] };
      } );
      m_alu_sequence_simple.start(m_sequencer);

      assert ( m_alu_sequence_simple.randomize() with {
        item.a inside { [$ : -1] };
        item.b inside { 0 };
      } );
      m_alu_sequence_simple.start(m_sequencer);
      
      assert ( m_alu_sequence_simple.randomize() with {
        item.a inside { 0 };
        item.b inside { [1:$] };
      } );
      m_alu_sequence_simple.start(m_sequencer);

      assert ( m_alu_sequence_simple.randomize() with {
        item.a inside { 0 };
        item.b inside { [$ : -1] };
      } );
      m_alu_sequence_simple.start(m_sequencer);

      assert ( m_alu_sequence_simple.randomize() with {
        item.a inside { 0 };
        item.b inside { 0 };
      } );
      m_alu_sequence_simple.start(m_sequencer);

      //hit overflow_f and overflow_x_add_sub
      //-------------------------------------

      assert ( m_alu_sequence_simple.randomize() with {
        item.op_code == ADD;
        //overflow condition in case of op_code == ADD
        add_overflow_f(item.a, item.b) == 1;
      } );
      m_alu_sequence_simple.start(m_sequencer);

      assert ( m_alu_sequence_simple.randomize() with {
        item.op_code == SUB;
        //overflow condition in case of op_code == SUB
        sub_overflow_f(item.a, item.b) == 1;
      } );
      m_alu_sequence_simple.start(m_sequencer);

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

  endclass: alu_sequence_constrained_random

`endif //ALU_SEQUENCE_CONSTRAINED_RANDOM_SV