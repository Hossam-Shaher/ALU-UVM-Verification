`ifndef ALU_COVERAGE_COLLECTOR_SV
  `define ALU_COVERAGE_COLLECTOR_SV

  typedef class alu_seq_item_mon;
    
  class alu_coverage_collector extends uvm_subscriber#(alu_seq_item_mon);
    `uvm_component_utils(alu_coverage_collector)

    alu_seq_item_mon 	item;

    covergroup cover_group;
      option.per_instance = 1;

      a : coverpoint item.a {
        option.comment = "First operand";
        bins a_eq_0 = {0};
        bins a_le_0 = {[$ : -1]};
        bins a_gt_0 = {[1 : $]};
      }

      b : coverpoint item.b {
        option.comment = "Second operand";
        bins a_eq_0 = {0};
        bins a_le_0 = {[$ : -1]};
        bins a_gt_0 = {[1 : $]};
      }
      
      op_code : coverpoint item.op_code {
        option.comment = "operation";
      }
      
      reset : coverpoint item.reset {
        option.comment = "reset";
      }
      
      zero_f : coverpoint item.zero_f {
        option.comment = "zero_f";
      }
      
      neg_f : coverpoint item.neg_f {
        option.comment = "neg_f";
      }
      
      c_out_f : coverpoint item.c_out_f {
        option.comment = "c_out_f";
      }
      
      overflow_f : coverpoint item.overflow_f {
        option.comment = "overflow_f";
      }
      
      a_x_b : cross a, b;
      
      //auxiliary coverpoint
      add_sub : coverpoint item.op_code {
        bins add_sub_op = {ADD, SUB};
      }
      
      overflow_x_add_sub : cross overflow_f, add_sub;

    endgroup: cover_group

    function new(string name, uvm_component parent);
      super.new(name, parent);
      cover_group = new();
    endfunction: new  

    function void write(alu_seq_item_mon t);
      item = t;
      cover_group.sample();
    endfunction: write

    function string coverage2string();
      coverage2string  = {
        $sformatf("\n  cover_group:              %.2f%%", cover_group.get_inst_coverage()),
        $sformatf("\n       a:                   %.2f%%", cover_group.a.get_inst_coverage()),
        $sformatf("\n       b:                   %.2f%%", cover_group.b.get_inst_coverage()),
        $sformatf("\n       op_code:             %.2f%%", cover_group.op_code.get_inst_coverage()),
        $sformatf("\n       zero_f:              %.2f%%", cover_group.zero_f.get_inst_coverage()),
        $sformatf("\n       neg_f:               %.2f%%", cover_group.neg_f.get_inst_coverage()),
        $sformatf("\n       c_out_f:             %.2f%%", cover_group.c_out_f.get_inst_coverage()),
        $sformatf("\n       overflow_f:          %.2f%%", cover_group.overflow_f.get_inst_coverage()),
        $sformatf("\n       a_x_b:               %.2f%%", cover_group.a_x_b.get_inst_coverage()),
        $sformatf("\n       overflow_x_add_sub:  %.2f%%", cover_group.overflow_x_add_sub.get_inst_coverage()),
        $sformatf("\n  ======================================"),
        $sformatf("\n  OVERALL Coverage:         %.2f%%", $get_coverage())

        };    
    endfunction: coverage2string

    function void report_phase(uvm_phase phase);
      `uvm_info("COVERAGE", coverage2string(), UVM_NONE)
    endfunction: report_phase

  endclass: alu_coverage_collector

`endif //ALU_COVERAGE_COLLECTOR_SV