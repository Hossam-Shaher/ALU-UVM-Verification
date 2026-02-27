`ifndef ALU_SEQUENCE_A_X_B_SV
  `define ALU_SEQUENCE_A_X_B_SV

  typedef class alu_seq_item_drv;
  typedef class alu_sequence_random;

  //The purpose of this sequence is to cover a_x_b (a coverage cross in the coverage model)
    
  class alu_sequence_a_x_b extends alu_sequence_random;

    `uvm_object_utils(alu_sequence_a_x_b)

    function new(string name = "");
      super.new(name);
    endfunction: new

    task body();
      
      item.default_a_b.constraint_mode(0);
      
      start_item(item);
      assert( item.randomize() with {
        a inside { [1:$] };
        b inside { [1:$] };
      } );
      finish_item(item);
      
      start_item(item);
      assert( item.randomize() with {
        a inside { [1:$] };
        b inside { [$ : -1] };
      } ); 
      finish_item(item);
      
      start_item(item);
      assert( item.randomize() with {
        a inside { [1:$] };
        b inside { 0 };
      } );
      finish_item(item);
      
      start_item(item);
      assert( item.randomize() with {
        a inside { [$ : -1] };
        b inside { [1:$] };
      } ); 
      finish_item(item);
      
      start_item(item);
      assert( item.randomize() with {
        a inside { [$ : -1] };
        b inside { [$ : -1] };
      } );
      finish_item(item);
      
      start_item(item);
      assert( item.randomize() with {
        a inside { [$ : -1] };
        b inside { 0 };
      } );
      finish_item(item);
      
      start_item(item);
      assert( item.randomize() with {
        a inside { 0 };
        b inside { [1:$] };
      } );
      finish_item(item);
      
      start_item(item);
      assert( item.randomize() with {
        a inside { 0 };
        b inside { [$ : -1] };
      } );
      finish_item(item);

      start_item(item);
      assert( item.randomize() with {
        a inside { 0 };
        b inside { 0 };
      } );
      finish_item(item);

    endtask: body

  endclass: alu_sequence_a_x_b

`endif //ALU_SEQUENCE_A_X_B_SV