/*
 * Generated by Bluespec Compiler (build 14ff62d)
 * 
 * On Thu Apr 18 23:14:37 CST 2024
 * 
 */
#include "bluesim_primitives.h"
#include "mkMultiplier.h"


/* Constructor */
MOD_mkMultiplier::MOD_mkMultiplier(tSimStateHdl simHdl, char const *name, Module *parent)
  : Module(simHdl, name, parent),
    __clk_handle_0(BAD_CLOCK_HANDLE),
    INST_results(simHdl, "results", this, 32u, 2u, 1u, 0u),
    PORT_RST_N((tUInt8)1u)
{
  PORT_EN_putOperands = false;
  PORT_EN_getResult = false;
  PORT_putOperands_coeff = 0u;
  PORT_putOperands_samp = 0u;
  PORT_RDY_putOperands = false;
  PORT_getResult = 0u;
  PORT_RDY_getResult = false;
  symbol_count = 12u;
  symbols = new tSym[symbol_count];
  init_symbols_0();
}


/* Symbol init fns */

void MOD_mkMultiplier::init_symbols_0()
{
  init_symbol(&symbols[0u], "CAN_FIRE_getResult", SYM_DEF, &DEF_CAN_FIRE_getResult, 1u);
  init_symbol(&symbols[1u], "CAN_FIRE_putOperands", SYM_DEF, &DEF_CAN_FIRE_putOperands, 1u);
  init_symbol(&symbols[2u], "EN_getResult", SYM_PORT, &PORT_EN_getResult, 1u);
  init_symbol(&symbols[3u], "EN_putOperands", SYM_PORT, &PORT_EN_putOperands, 1u);
  init_symbol(&symbols[4u], "getResult", SYM_PORT, &PORT_getResult, 32u);
  init_symbol(&symbols[5u], "putOperands_coeff", SYM_PORT, &PORT_putOperands_coeff, 32u);
  init_symbol(&symbols[6u], "putOperands_samp", SYM_PORT, &PORT_putOperands_samp, 16u);
  init_symbol(&symbols[7u], "RDY_getResult", SYM_PORT, &PORT_RDY_getResult, 1u);
  init_symbol(&symbols[8u], "RDY_putOperands", SYM_PORT, &PORT_RDY_putOperands, 1u);
  init_symbol(&symbols[9u], "results", SYM_MODULE, &INST_results);
  init_symbol(&symbols[10u], "WILL_FIRE_getResult", SYM_DEF, &DEF_WILL_FIRE_getResult, 1u);
  init_symbol(&symbols[11u], "WILL_FIRE_putOperands", SYM_DEF, &DEF_WILL_FIRE_putOperands, 1u);
}


/* Rule actions */


/* Methods */

void MOD_mkMultiplier::METH_putOperands(tUInt32 ARG_putOperands_coeff, tUInt32 ARG_putOperands_samp)
{
  tUInt32 DEF_y_f__h2130;
  tUInt32 DEF_x__h1055;
  tUInt32 DEF_x__h1090;
  tUInt32 DEF_x__h1074;
  tUInt32 DEF_IF_NOT_IF_NOT_IF_putOperands_coeff_BIT_31_AND__ETC___d47;
  tUInt64 DEF_IF_putOperands_coeff_BIT_31_THEN_NEG_putOperan_ETC___d13;
  tUInt8 DEF_putOperands_samp_BIT_15___d2;
  tUInt8 DEF_putOperands_coeff_BIT_31___d1;
  tUInt64 DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d27;
  tUInt8 DEF_x_BIT_31___h3544;
  tUInt8 DEF_IF_NOT_IF_putOperands_coeff_BIT_31_AND_NOT_put_ETC___d31;
  tUInt8 DEF_x_BIT_15___h1614;
  tUInt8 DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d16;
  tUInt32 DEF_check__h166;
  tUInt64 DEF_IF_NOT_IF_putOperands_coeff_BIT_31_AND_NOT_put_ETC___d30;
  tUInt64 DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d15;
  PORT_EN_putOperands = (tUInt8)1u;
  DEF_WILL_FIRE_putOperands = (tUInt8)1u;
  PORT_putOperands_coeff = ARG_putOperands_coeff;
  PORT_putOperands_samp = ARG_putOperands_samp;
  DEF_putOperands_coeff_BIT_31___d1 = (tUInt8)(ARG_putOperands_coeff >> 31u);
  DEF_putOperands_samp_BIT_15___d2 = (tUInt8)(ARG_putOperands_samp >> 15u);
  DEF_x__h1090 = ARG_putOperands_samp << 16u;
  DEF_x__h1074 = DEF_putOperands_samp_BIT_15___d2 ? -DEF_x__h1090 : DEF_x__h1090;
  DEF_x__h1055 = DEF_putOperands_coeff_BIT_31___d1 ? -ARG_putOperands_coeff : ARG_putOperands_coeff;
  DEF_IF_putOperands_coeff_BIT_31_THEN_NEG_putOperan_ETC___d13 = ((tUInt64)(DEF_x__h1055)) * ((tUInt64)(DEF_x__h1074));
  DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d15 = (DEF_putOperands_coeff_BIT_31___d1 && !DEF_putOperands_samp_BIT_15___d2) || (DEF_putOperands_samp_BIT_15___d2 && !DEF_putOperands_coeff_BIT_31___d1) ? -DEF_IF_putOperands_coeff_BIT_31_THEN_NEG_putOperan_ETC___d13 : DEF_IF_putOperands_coeff_BIT_31_THEN_NEG_putOperan_ETC___d13;
  DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d16 = (tUInt8)(DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d15 >> 63u);
  DEF_x_BIT_15___h1614 = (tUInt8)((tUInt8)1u & (DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d15 >> 15u));
  DEF_y_f__h2130 = DEF_x_BIT_15___h1614 && (DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d16 || !(((tUInt32)(32767u & DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d15)) == 0u)) ? 1u : 0u;
  DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d27 = 281474976710655llu & (((tUInt64)(DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d15 >> 16u)) + (281474976710655llu & ((((tUInt64)(0u)) << 16u) | (tUInt64)(DEF_y_f__h2130))));
  DEF_IF_NOT_IF_putOperands_coeff_BIT_31_AND_NOT_put_ETC___d30 = !DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d16 && (tUInt8)(DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d27 >> 47u) ? 140737488355327llu : DEF_IF_putOperands_coeff_BIT_31_AND_NOT_putOperand_ETC___d27;
  DEF_check__h166 = (tUInt32)(DEF_IF_NOT_IF_putOperands_coeff_BIT_31_AND_NOT_put_ETC___d30 >> 32u);
  DEF_IF_NOT_IF_putOperands_coeff_BIT_31_AND_NOT_put_ETC___d31 = (tUInt8)(DEF_IF_NOT_IF_putOperands_coeff_BIT_31_AND_NOT_put_ETC___d30 >> 47u);
  DEF_x_BIT_31___h3544 = (tUInt8)((tUInt8)1u & (DEF_IF_NOT_IF_putOperands_coeff_BIT_31_AND_NOT_put_ETC___d30 >> 31u));
  DEF_IF_NOT_IF_NOT_IF_putOperands_coeff_BIT_31_AND__ETC___d47 = !DEF_IF_NOT_IF_putOperands_coeff_BIT_31_AND_NOT_put_ETC___d31 && (DEF_x_BIT_31___h3544 || !(DEF_check__h166 == 0u)) ? 2147483647u : (DEF_IF_NOT_IF_putOperands_coeff_BIT_31_AND_NOT_put_ETC___d31 && (!DEF_x_BIT_31___h3544 || !((65535u & ~DEF_check__h166) == 0u)) ? 2147483648u : (tUInt32)(DEF_IF_NOT_IF_putOperands_coeff_BIT_31_AND_NOT_put_ETC___d30));
  INST_results.METH_enq(DEF_IF_NOT_IF_NOT_IF_putOperands_coeff_BIT_31_AND__ETC___d47);
}

tUInt8 MOD_mkMultiplier::METH_RDY_putOperands()
{
  DEF_CAN_FIRE_putOperands = INST_results.METH_i_notFull();
  PORT_RDY_putOperands = DEF_CAN_FIRE_putOperands;
  return PORT_RDY_putOperands;
}

tUInt32 MOD_mkMultiplier::METH_getResult()
{
  tUInt32 DEF_getResult__avValue1;
  PORT_EN_getResult = (tUInt8)1u;
  DEF_WILL_FIRE_getResult = (tUInt8)1u;
  DEF_getResult__avValue1 = INST_results.METH_first();
  PORT_getResult = DEF_getResult__avValue1;
  INST_results.METH_deq();
  return PORT_getResult;
}

tUInt8 MOD_mkMultiplier::METH_RDY_getResult()
{
  DEF_CAN_FIRE_getResult = INST_results.METH_i_notEmpty();
  PORT_RDY_getResult = DEF_CAN_FIRE_getResult;
  return PORT_RDY_getResult;
}


/* Reset routines */

void MOD_mkMultiplier::reset_RST_N(tUInt8 ARG_rst_in)
{
  PORT_RST_N = ARG_rst_in;
  INST_results.reset_RST(ARG_rst_in);
}


/* Static handles to reset routines */


/* Functions for the parent module to register its reset fns */


/* Functions to set the elaborated clock id */

void MOD_mkMultiplier::set_clk_0(char const *s)
{
  __clk_handle_0 = bk_get_or_define_clock(sim_hdl, s);
}


/* State dumping routine */
void MOD_mkMultiplier::dump_state(unsigned int indent)
{
  printf("%*s%s:\n", indent, "", inst_name);
  INST_results.dump_state(indent + 2u);
}


/* VCD dumping routines */

unsigned int MOD_mkMultiplier::dump_VCD_defs(unsigned int levels)
{
  vcd_write_scope_start(sim_hdl, inst_name);
  vcd_num = vcd_reserve_ids(sim_hdl, 13u);
  unsigned int num = vcd_num;
  for (unsigned int clk = 0u; clk < bk_num_clocks(sim_hdl); ++clk)
    vcd_add_clock_def(sim_hdl, this, bk_clock_name(sim_hdl, clk), bk_clock_vcd_num(sim_hdl, clk));
  vcd_write_def(sim_hdl, bk_clock_vcd_num(sim_hdl, __clk_handle_0), "CLK", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "CAN_FIRE_getResult", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "CAN_FIRE_putOperands", 1u);
  vcd_write_def(sim_hdl, num++, "RST_N", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "WILL_FIRE_getResult", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "WILL_FIRE_putOperands", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "EN_getResult", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "EN_putOperands", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "RDY_getResult", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "RDY_putOperands", 1u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "getResult", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "putOperands_coeff", 32u);
  vcd_set_clock(sim_hdl, num, __clk_handle_0);
  vcd_write_def(sim_hdl, num++, "putOperands_samp", 16u);
  num = INST_results.dump_VCD_defs(num);
  vcd_write_scope_end(sim_hdl);
  return num;
}

void MOD_mkMultiplier::dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkMultiplier &backing)
{
  vcd_defs(dt, backing);
  vcd_prims(dt, backing);
}

void MOD_mkMultiplier::vcd_defs(tVCDDumpType dt, MOD_mkMultiplier &backing)
{
  unsigned int num = vcd_num;
  if (dt == VCD_DUMP_XS)
  {
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 1u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 32u);
    vcd_write_x(sim_hdl, num++, 16u);
  }
  else
    if (dt == VCD_DUMP_CHANGES)
    {
      if ((backing.DEF_CAN_FIRE_getResult) != DEF_CAN_FIRE_getResult)
      {
	vcd_write_val(sim_hdl, num, DEF_CAN_FIRE_getResult, 1u);
	backing.DEF_CAN_FIRE_getResult = DEF_CAN_FIRE_getResult;
      }
      ++num;
      if ((backing.DEF_CAN_FIRE_putOperands) != DEF_CAN_FIRE_putOperands)
      {
	vcd_write_val(sim_hdl, num, DEF_CAN_FIRE_putOperands, 1u);
	backing.DEF_CAN_FIRE_putOperands = DEF_CAN_FIRE_putOperands;
      }
      ++num;
      if ((backing.PORT_RST_N) != PORT_RST_N)
      {
	vcd_write_val(sim_hdl, num, PORT_RST_N, 1u);
	backing.PORT_RST_N = PORT_RST_N;
      }
      ++num;
      if ((backing.DEF_WILL_FIRE_getResult) != DEF_WILL_FIRE_getResult)
      {
	vcd_write_val(sim_hdl, num, DEF_WILL_FIRE_getResult, 1u);
	backing.DEF_WILL_FIRE_getResult = DEF_WILL_FIRE_getResult;
      }
      ++num;
      if ((backing.DEF_WILL_FIRE_putOperands) != DEF_WILL_FIRE_putOperands)
      {
	vcd_write_val(sim_hdl, num, DEF_WILL_FIRE_putOperands, 1u);
	backing.DEF_WILL_FIRE_putOperands = DEF_WILL_FIRE_putOperands;
      }
      ++num;
      if ((backing.PORT_EN_getResult) != PORT_EN_getResult)
      {
	vcd_write_val(sim_hdl, num, PORT_EN_getResult, 1u);
	backing.PORT_EN_getResult = PORT_EN_getResult;
      }
      ++num;
      if ((backing.PORT_EN_putOperands) != PORT_EN_putOperands)
      {
	vcd_write_val(sim_hdl, num, PORT_EN_putOperands, 1u);
	backing.PORT_EN_putOperands = PORT_EN_putOperands;
      }
      ++num;
      if ((backing.PORT_RDY_getResult) != PORT_RDY_getResult)
      {
	vcd_write_val(sim_hdl, num, PORT_RDY_getResult, 1u);
	backing.PORT_RDY_getResult = PORT_RDY_getResult;
      }
      ++num;
      if ((backing.PORT_RDY_putOperands) != PORT_RDY_putOperands)
      {
	vcd_write_val(sim_hdl, num, PORT_RDY_putOperands, 1u);
	backing.PORT_RDY_putOperands = PORT_RDY_putOperands;
      }
      ++num;
      if ((backing.PORT_getResult) != PORT_getResult)
      {
	vcd_write_val(sim_hdl, num, PORT_getResult, 32u);
	backing.PORT_getResult = PORT_getResult;
      }
      ++num;
      if ((backing.PORT_putOperands_coeff) != PORT_putOperands_coeff)
      {
	vcd_write_val(sim_hdl, num, PORT_putOperands_coeff, 32u);
	backing.PORT_putOperands_coeff = PORT_putOperands_coeff;
      }
      ++num;
      if ((backing.PORT_putOperands_samp) != PORT_putOperands_samp)
      {
	vcd_write_val(sim_hdl, num, PORT_putOperands_samp, 16u);
	backing.PORT_putOperands_samp = PORT_putOperands_samp;
      }
      ++num;
    }
    else
    {
      vcd_write_val(sim_hdl, num++, DEF_CAN_FIRE_getResult, 1u);
      backing.DEF_CAN_FIRE_getResult = DEF_CAN_FIRE_getResult;
      vcd_write_val(sim_hdl, num++, DEF_CAN_FIRE_putOperands, 1u);
      backing.DEF_CAN_FIRE_putOperands = DEF_CAN_FIRE_putOperands;
      vcd_write_val(sim_hdl, num++, PORT_RST_N, 1u);
      backing.PORT_RST_N = PORT_RST_N;
      vcd_write_val(sim_hdl, num++, DEF_WILL_FIRE_getResult, 1u);
      backing.DEF_WILL_FIRE_getResult = DEF_WILL_FIRE_getResult;
      vcd_write_val(sim_hdl, num++, DEF_WILL_FIRE_putOperands, 1u);
      backing.DEF_WILL_FIRE_putOperands = DEF_WILL_FIRE_putOperands;
      vcd_write_val(sim_hdl, num++, PORT_EN_getResult, 1u);
      backing.PORT_EN_getResult = PORT_EN_getResult;
      vcd_write_val(sim_hdl, num++, PORT_EN_putOperands, 1u);
      backing.PORT_EN_putOperands = PORT_EN_putOperands;
      vcd_write_val(sim_hdl, num++, PORT_RDY_getResult, 1u);
      backing.PORT_RDY_getResult = PORT_RDY_getResult;
      vcd_write_val(sim_hdl, num++, PORT_RDY_putOperands, 1u);
      backing.PORT_RDY_putOperands = PORT_RDY_putOperands;
      vcd_write_val(sim_hdl, num++, PORT_getResult, 32u);
      backing.PORT_getResult = PORT_getResult;
      vcd_write_val(sim_hdl, num++, PORT_putOperands_coeff, 32u);
      backing.PORT_putOperands_coeff = PORT_putOperands_coeff;
      vcd_write_val(sim_hdl, num++, PORT_putOperands_samp, 16u);
      backing.PORT_putOperands_samp = PORT_putOperands_samp;
    }
}

void MOD_mkMultiplier::vcd_prims(tVCDDumpType dt, MOD_mkMultiplier &backing)
{
  INST_results.dump_VCD(dt, backing.INST_results);
}
