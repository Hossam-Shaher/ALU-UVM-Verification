`ifndef ALU_SEQUENCE_SIMPLE_SV
  `define ALU_SEQUENCE_SIMPLE_SV

  typedef class alu_seq_item_drv;

  class alu_sequence_simple extends uvm_sequence#(alu_seq_item_drv);

    `uvm_object_utils(alu_sequence_simple)

    rand alu_seq_item_drv item;

    function new(string name = "");
      super.new(name);
      item = alu_seq_item_drv::type_id::create("item"); 
      //Do NOT insert a 2nd actual argument "this", bcz "this" shall be a component
    endfunction: new

    task body();
      start_item(item);
      finish_item(item);    
    endtask: body

  endclass: alu_sequence_simple

`endif //ALU_SEQUENCE_SIMPLE_SV