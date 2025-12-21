`ifndef ALU_SEQ_ITEM_BASE_SV 
  `define ALU_SEQ_ITEM_BASE_SV

  class alu_seq_item_base extends uvm_sequence_item;

    `uvm_object_utils(alu_seq_item_base)
    
    rand data_t 		a, b;
    rand op_code_enum 	op_code;
    rand bit 			reset;
    
    function string convert2string;
      if( (op_code == ADD) || (op_code == SUB) )
        convert2string = $sformatf("a=%0d, b=%0d, op_code=%0s, reset=%0b", 
                                    a, b, op_code.name, reset);
      else
        convert2string = $sformatf("a=%0b, b=%0b, op_code=%0s, reset=%0b", 
                            a, b, op_code.name, reset);
    endfunction: convert2string

    function new (string name = "");
      super.new(name);
    endfunction: new

  endclass: alu_seq_item_base

`endif //ALU_SEQ_ITEM_BASE_SV