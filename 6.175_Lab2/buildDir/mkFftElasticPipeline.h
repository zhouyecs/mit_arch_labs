/*
 * Generated by Bluespec Compiler (build 14ff62d)
 * 
 * On Mon Mar 11 00:47:43 CST 2024
 * 
 */

/* Generation options: */
#ifndef __mkFftElasticPipeline_h__
#define __mkFftElasticPipeline_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"
#include "mkBfly4.h"


/* Class declaration for the mkFftElasticPipeline module */
class MOD_mkFftElasticPipeline : public Module {
 
 /* Clock handles */
 private:
  tClock __clk_handle_0;
 
 /* Clock gate handles */
 public:
  tUInt8 *clk_gate[0];
 
 /* Instantiation parameters */
 public:
 
 /* Module state */
 public:
  MOD_mkBfly4 INST_bfly_0_0;
  MOD_mkBfly4 INST_bfly_0_1;
  MOD_mkBfly4 INST_bfly_0_10;
  MOD_mkBfly4 INST_bfly_0_11;
  MOD_mkBfly4 INST_bfly_0_12;
  MOD_mkBfly4 INST_bfly_0_13;
  MOD_mkBfly4 INST_bfly_0_14;
  MOD_mkBfly4 INST_bfly_0_15;
  MOD_mkBfly4 INST_bfly_0_2;
  MOD_mkBfly4 INST_bfly_0_3;
  MOD_mkBfly4 INST_bfly_0_4;
  MOD_mkBfly4 INST_bfly_0_5;
  MOD_mkBfly4 INST_bfly_0_6;
  MOD_mkBfly4 INST_bfly_0_7;
  MOD_mkBfly4 INST_bfly_0_8;
  MOD_mkBfly4 INST_bfly_0_9;
  MOD_mkBfly4 INST_bfly_1_0;
  MOD_mkBfly4 INST_bfly_1_1;
  MOD_mkBfly4 INST_bfly_1_10;
  MOD_mkBfly4 INST_bfly_1_11;
  MOD_mkBfly4 INST_bfly_1_12;
  MOD_mkBfly4 INST_bfly_1_13;
  MOD_mkBfly4 INST_bfly_1_14;
  MOD_mkBfly4 INST_bfly_1_15;
  MOD_mkBfly4 INST_bfly_1_2;
  MOD_mkBfly4 INST_bfly_1_3;
  MOD_mkBfly4 INST_bfly_1_4;
  MOD_mkBfly4 INST_bfly_1_5;
  MOD_mkBfly4 INST_bfly_1_6;
  MOD_mkBfly4 INST_bfly_1_7;
  MOD_mkBfly4 INST_bfly_1_8;
  MOD_mkBfly4 INST_bfly_1_9;
  MOD_mkBfly4 INST_bfly_2_0;
  MOD_mkBfly4 INST_bfly_2_1;
  MOD_mkBfly4 INST_bfly_2_10;
  MOD_mkBfly4 INST_bfly_2_11;
  MOD_mkBfly4 INST_bfly_2_12;
  MOD_mkBfly4 INST_bfly_2_13;
  MOD_mkBfly4 INST_bfly_2_14;
  MOD_mkBfly4 INST_bfly_2_15;
  MOD_mkBfly4 INST_bfly_2_2;
  MOD_mkBfly4 INST_bfly_2_3;
  MOD_mkBfly4 INST_bfly_2_4;
  MOD_mkBfly4 INST_bfly_2_5;
  MOD_mkBfly4 INST_bfly_2_6;
  MOD_mkBfly4 INST_bfly_2_7;
  MOD_mkBfly4 INST_bfly_2_8;
  MOD_mkBfly4 INST_bfly_2_9;
  MOD_Fifo<tUWide> INST_fifo1;
  MOD_Fifo<tUWide> INST_fifo2;
  MOD_Fifo<tUWide> INST_inFifo;
  MOD_Fifo<tUWide> INST_outFifo;
 
 /* Constructor */
 public:
  MOD_mkFftElasticPipeline(tSimStateHdl simHdl, char const *name, Module *parent);
 
 /* Symbol init methods */
 private:
  void init_symbols_0();
 
 /* Reset signal definitions */
 private:
  tUInt8 PORT_RST_N;
 
 /* Port definitions */
 public:
  tUWide PORT_enq_in;
  tUWide PORT_deq;
 
 /* Publicly accessible definitions */
 public:
 
 /* Local definitions */
 private:
  tUWide DEF_fifo2_first____d268;
  tUWide DEF_fifo1_first____d136;
  tUWide DEF_inFifo_first____d4;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d396;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d393;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d132;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d129;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d264;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d261;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d390;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d126;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d258;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d387;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d123;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d255;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d384;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d120;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d252;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d381;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d117;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d249;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d378;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d114;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d246;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d375;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d111;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d243;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d372;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d108;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d240;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d369;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d105;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d237;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d366;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d102;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d234;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d363;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d99;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d231;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d360;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d96;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d228;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d357;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d225;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d93;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d354;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d90;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d222;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d351;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d87;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d219;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d348;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d84;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d216;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d343;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d79;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d211;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d338;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d74;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d206;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d333;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d69;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d201;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d328;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d64;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d196;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d323;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d59;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d191;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d318;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d54;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d186;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d313;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d49;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d181;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d308;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d44;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d176;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d303;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d39;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d171;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d298;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d34;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d166;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d293;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d29;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d161;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d288;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d24;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d156;
  tUWide DEF_bfly_2_15_bfly4_2251552690364292668_fifo2_firs_ETC___d283;
  tUWide DEF_bfly_0_15_bfly4_2251552690364292668_inFifo_fir_ETC___d19;
  tUWide DEF_bfly_1_15_bfly4_2251552690364292668_fifo1_firs_ETC___d151;
  tUWide DEF_deq__avValue1;
 
 /* Rules */
 public:
  void RL_stage0();
  void RL_stage1();
  void RL_stage2();
 
 /* Methods */
 public:
  void METH_enq(tUWide ARG_enq_in);
  tUInt8 METH_RDY_enq();
  tUWide METH_deq();
  tUInt8 METH_RDY_deq();
 
 /* Reset routines */
 public:
  void reset_RST_N(tUInt8 ARG_rst_in);
 
 /* Static handles to reset routines */
 public:
 
 /* Pointers to reset fns in parent module for asserting output resets */
 private:
 
 /* Functions for the parent module to register its reset fns */
 public:
 
 /* Functions to set the elaborated clock id */
 public:
  void set_clk_0(char const *s);
 
 /* State dumping routine */
 public:
  void dump_state(unsigned int indent);
 
 /* VCD dumping routines */
 public:
  unsigned int dump_VCD_defs(unsigned int levels);
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkFftElasticPipeline &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkFftElasticPipeline &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkFftElasticPipeline &backing);
  void vcd_submodules(tVCDDumpType dt, unsigned int levels, MOD_mkFftElasticPipeline &backing);
};

#endif /* ifndef __mkFftElasticPipeline_h__ */
