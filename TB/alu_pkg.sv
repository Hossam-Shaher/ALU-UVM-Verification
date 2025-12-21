`ifndef ALU_PKG_SV
  `define ALU_PKG_SV

  //Timescale
  `timescale 1ns/1ns

  //Macros
  `define ALU_DATA_WIDTH 	32
  `define CLK 				5ns		//Half cycle

  //Interface
  `include "alu_if.sv"

  package alu_pkg;

      //UVM
      `include "uvm_macros.svh"
      import uvm_pkg::*;

      //Globals (enumerations, types, ...)
      `include "alu_globals.sv"

      //Modeling & Checking
      `include "alu_model.sv"
      `include "alu_scoreboard.sv"

      //Sequence items
      `include "alu_seq_item_base.sv"
      `include "alu_seq_item_drv.sv"
      `include "alu_seq_item_mon.sv"

      //Monitor, sequencer, driver
      `include "alu_monitor.sv"
      `include "alu_sequencer.sv"
      `include "alu_driver.sv"

      //Agent, agent configuration object
      `include "alu_agent_config.sv"
      `include "alu_agent.sv"

      //Coverage collector
      `include "alu_coverage_collector.sv"

      //Environment
      `include "alu_env_config.sv"
      `include "alu_env.sv"

      //Sequences
      `include "alu_sequence_simple.sv"
      `include "alu_sequence_constrained_random.sv"

      //Tests
      `include "alu_test_base.sv"
      `include "alu_test_random.sv"

  endpackage: alu_pkg 

`endif //ALU_PKG_SV