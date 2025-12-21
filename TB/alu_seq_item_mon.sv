`ifndef ALU_SEQ_ITEM_MON_SV 
  `define ALU_SEQ_ITEM_MON_SV

  typedef class alu_seq_item_base;

  class alu_seq_item_mon extends alu_seq_item_base;

    `uvm_object_utils(alu_seq_item_mon)

    //There is no reason to declare the properties of this class as rand

    data_t 	result;		//data_t is defined in alu_globals.sv
    bit 	zero_f, 
        	neg_f, 
        	c_out_f, 
        	overflow_f;
    
    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
       alu_seq_item_mon item;
       bit status = 1;
       $cast(item, rhs);

       status &= super.do_compare(rhs, comparer);		//In this case, super.do_compre always return 1
       status &= (this.a 		=== item.a);
       status &= (this.b 		=== item.b);
       status &= (this.op_code 	=== item.op_code);
       status &= (this.reset 	=== item.reset);
       status &= (this.result 	=== item.result);
       status &= (this.zero_f 	=== item.zero_f);
       status &= (this.neg_f 	=== item.neg_f);
       status &= (this.c_out_f	=== item.c_out_f);
       status &= (this.overflow_f === item.overflow_f);

       return status;
    endfunction: do_compare

    function string convert2string;
      if( (op_code == ADD) || (op_code == SUB) )
        convert2string = $sformatf("%0s, result=%0d, zero_f=%0b, neg_f=%0b, c_out_f=%0b, overflow_f=%0b", 
                                   super.convert2string, result, zero_f, neg_f, c_out_f, overflow_f);
      else
        convert2string = $sformatf("%0s, result=%0b, zero_f=%0b, neg_f=%0b, c_out_f=%0b, overflow_f=%0b", 
                           super.convert2string, result, zero_f, neg_f, c_out_f, overflow_f);
    endfunction: convert2string

    function new (string name = "");
      super.new(name);
    endfunction: new

  endclass: alu_seq_item_mon

`endif //ALU_SEQ_ITEM_MON_SV