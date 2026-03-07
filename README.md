# ALU: UVM Verification
This **N-bit ALU** takes two N-bit operands and performs an operation (ADD, SUB, AND, or OR) then outputs the result. 
Also, four output flags are provided (zero_f, neg_f, c_out_f, and overflow_f). This ALU is a sequential circuit that updates its outputs on the positive edges of a clock.

In this project, the ALU is designed, modeled, and verified using the **SystemVerilog HDVL** and the **Universal Verification Methodology (UVM)**.

## Design

The following figure shows the ALU as a black box.

<img width="645" height="460" alt="ALU-Page-2 drawio" src="https://github.com/user-attachments/assets/7b15ecf6-095b-44e4-afd2-017e398dcb9a" />

**Parameters** of the ALU are listed in the following table.

Parameter Name | Default Value | Description
:--- | :---: | :---
`N` | 32 | Operands and result width = $N$ bit

**Ports** of the ALU are listed in the following table.

Port Name | Width | Direction | Description
:--- | :---: | :---: | :--- 
`clk` | 1 | Input | System clock
`reset` | 1 | Input | Active-high synchronous reset 
`a` | $N$ | Input | First operand 
`b` | $N$ | Input | Second operand 
`op_code` | 2 | Input | Operation to be performed (`ADD`, `SUB`, `AND`, or `OR`) 
`result` | $N$ | Output | Result
`zero_f` | 1 | Output | "`result` equals zero" status flag 
`neg_f` | 1 | Output | "`result` is negative" status flag 
`c_out_f` | 1 | Output | Carry out status flag 
`overflow_f` | 1 | Output | Overflow status flag 

## UVM testbench

The following figures show the **structure of the UVM testbench**.

<img width="621.5" height="511" alt="image" src="https://github.com/user-attachments/assets/1466a581-038f-43b9-b252-48b28a9a5e19" />

<img width="933" height="530" alt="image" src="https://github.com/user-attachments/assets/c4b9beb6-8611-4014-9c72-699f49a048e8" />

<img width="446.5" height="522.2" alt="image" src="https://github.com/user-attachments/assets/e3c54a92-8dbe-49a5-99e4-f45f878aa778" />


The following figure shows **UML class diagrams of the UVM tests** used to verify the DUT.

<img width="729" height="373" alt="ALU drawio" src="https://github.com/user-attachments/assets/affd9e5b-95e6-4c4c-a366-163bf7b15052" />


*alu_test_merged* merges multiple test scenarios; it executes multiple sequences sequentially to achieve 100% functional coverage in a single run.
