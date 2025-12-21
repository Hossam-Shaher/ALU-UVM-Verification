`ifndef ALU_SEQ_ITEM_DRV_SV 
  `define ALU_SEQ_ITEM_DRV_SV

  typedef class alu_seq_item_base;

  class alu_seq_item_drv extends alu_seq_item_base;

    `uvm_object_utils(alu_seq_item_drv)

    //add rand properties and soft constraints HERE

    constraint default_a_b {
      soft a inside { [-20 : 20] } ;
      soft b inside { [-20 : 20] } ;
      soft reset == 0;
    }
    
    constraint default_reset {
      soft reset == 0;
    }
    
/*
    function string convert2string;
      convert2string = $sformatf("%0s, . . . ", 
                                 super.convert2string);
    endfunction: convert2string
*/
    function new (string name = "");
      super.new(name);
    endfunction: new

  endclass: alu_seq_item_drv

`endif //ALU_SEQ_ITEM_DRV_SV