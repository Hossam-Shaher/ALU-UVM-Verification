# ALU: UVM Verification
This **N-bit ALU** takes two N-bit operands and performs an operation (ADD, SUB, AND, or OR) then outputs the result. 
Also, four output flags are provided (zero_f, neg_f, c_out_f, and overflow_f). This ALU is a sequential circuit that updates its outputs on the positive edges of a clock.

In this project, the ALU is designed, modeled, and verified using the **SystemVerilog HDVL** and the **Universal Verification Methodology (UVM)**.

The following figures show the **structure of the UVM testbench**.

<img width="621.5" height="511" alt="image" src="https://github.com/user-attachments/assets/1466a581-038f-43b9-b252-48b28a9a5e19" />

<img width="933" height="530" alt="image" src="https://github.com/user-attachments/assets/c4b9beb6-8611-4014-9c72-699f49a048e8" />

<img width="446.5" height="522.2" alt="image" src="https://github.com/user-attachments/assets/e3c54a92-8dbe-49a5-99e4-f45f878aa778" />


The following figure shows **UML class diagrams of the UVM tests** used to verify the DUT.

<img width="561" height="311" alt="ALU drawio" src="https://github.com/user-attachments/assets/affd9e5b-95e6-4c4c-a366-163bf7b15052" />


*alu_test_merged* merges multiple test scenarios; it executes multiple sequences sequentially to achieve 100% functional coverage in a single run.
