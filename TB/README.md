# UVM Testbench
This is a categorized list of SV files used to build this testbench.

**Top module**
* testbench.sv

**ALU package**
* alu_pkg.sv

**Interface**
* alu_if.sv

**Globals (types, enumerations, ...)**
* alu_globals.sv

**Model & Scoreboard**
* alu_model.sv
* alu_scoreboard.sv

**Sequence items**
* alu_seq_item_base.sv
* alu_seq_item_drv.sv
* alu_seq_item_mon.sv

**Sequencer, driver, and monitor**
* alu_monitor.sv
* alu_driver.sv
* alu_sequencer.sv

**Agent and agent configuration object**
* alu_agent_config.sv
* alu_agent.sv

**Coverage collector**
* alu_coverage_collector.sv

**Environment and environment configuration object**
* alu_env_config.sv
* alu_env.sv

**Sequences**
* alu_sequence_random.sv
* alu_sequence_a_x_b.sv
* alu_sequence_overflow_f.sv
* alu_sequence_merged.sv

**Tests**
* alu_test_base.sv
* alu_test_random.sv
* alu_test_a_x_b.sv
* alu_test_overflow_f.sv
* alu_test_merged.sv
