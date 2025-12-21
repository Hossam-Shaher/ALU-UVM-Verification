`ifndef ALU_GLOBALS_SV
  `define ALU_GLOBALS_SV

  //Enumerations
  typedef enum bit [1 : 0] {ADD = 0, SUB = 1, AND = 2, OR  = 3} op_code_enum;

  //type of a, b, and result
  typedef bit signed [`ALU_DATA_WIDTH -1 : 0] data_t;

`endif	//ALU_GLOBALS_SV