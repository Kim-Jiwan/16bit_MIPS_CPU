# 16bit_MIPS_CPU

## hierarchy
- mips_16bit_tb.v
  - mips_16bit.v
    - data_mem.v
    - inst_mem.v
    - register.v
    - program_counter.v
    - field_generator.v
    - ALU.v
    - ALU_ctrl_unit.v
    - ctrl_sig_unit.v
    - jr_ctrl_unit.v
    - adder_13bit.v
    - MUX_3_1_3bit.v
    - MUX_3_1_16bit.v
    - MUX_2_1_13bit.v
    - MUX_2_1_16bit.v
    - sign_extension.v

## design target
![datapath](https://user-images.githubusercontent.com/65444464/161568473-b0dadc79-b502-4286-9ebe-e58d373d6fd4.png)

## design verification
![result_after_debbuging](https://user-images.githubusercontent.com/65444464/161568798-46d5ca0a-71b9-4bb7-8feb-fec63ee4dd2b.png)
![vcs_simulation_after_debbuging](https://user-images.githubusercontent.com/65444464/161568842-f2a96e28-5a8f-42c3-a0c7-dbe427a1bef3.png)
![Synthesis_after_debbuging](https://user-images.githubusercontent.com/65444464/161568862-c3af18af-4250-4bbc-870f-3a9dc3cc0811.png)
