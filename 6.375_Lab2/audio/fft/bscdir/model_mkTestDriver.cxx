/*
 * Generated by Bluespec Compiler (build 14ff62d)
 * 
 * On Thu Apr 25 02:07:26 CST 2024
 * 
 */
#include "bluesim_primitives.h"
#include "model_mkTestDriver.h"

#include <cstdlib>
#include <time.h>
#include "bluesim_kernel_api.h"
#include "bs_vcd.h"
#include "bs_reset.h"


/* Constructor */
MODEL_mkTestDriver::MODEL_mkTestDriver()
{
  mkTestDriver_instance = NULL;
}

/* Function for creating a new model */
void * new_MODEL_mkTestDriver()
{
  MODEL_mkTestDriver *model = new MODEL_mkTestDriver();
  return (void *)(model);
}

/* Schedule functions */

static void schedule_posedge_CLK(tSimStateHdl simHdl, void *instance_ptr)
       {
	 MOD_mkTestDriver &INST_top = *((MOD_mkTestDriver *)(instance_ptr));
	 tUInt8 DEF_INST_top_DEF_m_inited___d2547;
	 tUInt8 DEF_INST_top_DEF_m_doneread__h638543;
	 tUInt8 DEF_INST_top_DEF_pipeline_fir_infifo_i_notFull____d2555;
	 tUInt32 DEF_INST_top_DEF_x__h639249;
	 INST_top.INST_pipeline_fir_m_0.PORT_EN_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_0.DEF_WILL_FIRE_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_1.PORT_EN_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_1.DEF_WILL_FIRE_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_2.PORT_EN_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_2.DEF_WILL_FIRE_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_3.PORT_EN_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_3.DEF_WILL_FIRE_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_4.PORT_EN_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_4.DEF_WILL_FIRE_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_5.PORT_EN_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_5.DEF_WILL_FIRE_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_6.PORT_EN_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_6.DEF_WILL_FIRE_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_7.PORT_EN_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_7.DEF_WILL_FIRE_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_8.PORT_EN_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_8.DEF_WILL_FIRE_getResult = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_0.PORT_EN_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_0.DEF_WILL_FIRE_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_1.PORT_EN_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_1.DEF_WILL_FIRE_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_2.PORT_EN_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_2.DEF_WILL_FIRE_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_3.PORT_EN_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_3.DEF_WILL_FIRE_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_4.PORT_EN_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_4.DEF_WILL_FIRE_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_5.PORT_EN_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_5.DEF_WILL_FIRE_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_6.PORT_EN_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_6.DEF_WILL_FIRE_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_7.PORT_EN_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_7.DEF_WILL_FIRE_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_8.PORT_EN_putOperands = (tUInt8)0u;
	 INST_top.INST_pipeline_fir_m_8.DEF_WILL_FIRE_putOperands = (tUInt8)0u;
	 DEF_INST_top_DEF_x__h639249 = INST_top.INST_m_outstanding.METH_value();
	 DEF_INST_top_DEF_m_doneread__h638543 = INST_top.INST_m_doneread.METH_read();
	 INST_top.DEF_CAN_FIRE_RL_finish = DEF_INST_top_DEF_m_doneread__h638543 && DEF_INST_top_DEF_x__h639249 == 0u;
	 INST_top.DEF_WILL_FIRE_RL_finish = INST_top.DEF_CAN_FIRE_RL_finish;
	 DEF_INST_top_DEF_m_inited___d2547 = INST_top.INST_m_inited.METH_read();
	 INST_top.DEF_CAN_FIRE_RL_init = (INST_top.INST_m_inited_double_write_error.METH_read() && (INST_top.INST_m_in_double_write_error.METH_read() && INST_top.INST_m_out_double_write_error.METH_read())) && !DEF_INST_top_DEF_m_inited___d2547;
	 INST_top.DEF_WILL_FIRE_RL_init = INST_top.DEF_CAN_FIRE_RL_init;
	 DEF_INST_top_DEF_pipeline_fir_infifo_i_notFull____d2555 = INST_top.INST_pipeline_fir_infifo.METH_i_notFull();
	 INST_top.DEF_CAN_FIRE_RL_pad = DEF_INST_top_DEF_pipeline_fir_infifo_i_notFull____d2555 && (DEF_INST_top_DEF_m_inited___d2547 && DEF_INST_top_DEF_m_doneread__h638543);
	 INST_top.DEF_WILL_FIRE_RL_pad = INST_top.DEF_CAN_FIRE_RL_pad;
	 INST_top.DEF_x__h7781 = INST_top.INST_pipeline_chunker_index.METH_read();
	 INST_top.DEF_pipeline_chunker_index_4_EQ_7___d85 = (INST_top.DEF_x__h7781) == (tUInt8)7u;
	 INST_top.DEF_CAN_FIRE_RL_pipeline_chunker_iterate = INST_top.INST_pipeline_chunker_infifo.METH_i_notEmpty() && (INST_top.INST_pipeline_chunker_index_double_write_error.METH_read() && (INST_top.DEF_pipeline_chunker_index_4_EQ_7___d85 ? INST_top.INST_pipeline_chunker_outfifo.METH_i_notFull() : INST_top.INST_pipeline_chunker_pending_double_write_error.METH_read()));
	 INST_top.DEF_WILL_FIRE_RL_pipeline_chunker_iterate = INST_top.DEF_CAN_FIRE_RL_pipeline_chunker_iterate;
	 INST_top.DEF_CAN_FIRE_RL_pipeline_chunker_to_fft = INST_top.INST_pipeline_chunker_outfifo.METH_i_notEmpty() && INST_top.INST_pipeline_fft_fft_inputFIFO.METH_i_notFull();
	 INST_top.DEF_WILL_FIRE_RL_pipeline_chunker_to_fft = INST_top.DEF_CAN_FIRE_RL_pipeline_chunker_to_fft;
	 INST_top.DEF_pipeline_fft_fft_stage_valid_3__h317867 = INST_top.INST_pipeline_fft_fft_stage_valid_3.METH_read();
	 INST_top.DEF_pipeline_fft_fft_stage_valid_2__h211052 = INST_top.INST_pipeline_fft_fft_stage_valid_2.METH_read();
	 INST_top.DEF_pipeline_fft_fft_stage_valid_1__h111932 = INST_top.INST_pipeline_fft_fft_stage_valid_1.METH_read();
	 INST_top.DEF_pipeline_fft_fft_stage_valid_0__h12384 = INST_top.INST_pipeline_fft_fft_stage_valid_0.METH_read();
	 INST_top.DEF_CAN_FIRE_RL_pipeline_fft_fft_linear_fft = INST_top.INST_pipeline_fft_fft_stage_data_0_double_write_error.METH_read() && (INST_top.INST_pipeline_fft_fft_inputFIFO.METH_i_notEmpty() && (INST_top.INST_pipeline_fft_fft_stage_valid_0_double_write_error.METH_read() && (INST_top.INST_pipeline_fft_fft_stage_valid_1_double_write_error.METH_read() && (INST_top.INST_pipeline_fft_fft_stage_valid_2_double_write_error.METH_read() && (INST_top.INST_pipeline_fft_fft_stage_valid_3_double_write_error.METH_read() && ((!(INST_top.DEF_pipeline_fft_fft_stage_valid_0__h12384) || INST_top.INST_pipeline_fft_fft_stage_data_1_double_write_error.METH_read()) && ((!(INST_top.DEF_pipeline_fft_fft_stage_valid_1__h111932) || INST_top.INST_pipeline_fft_fft_stage_data_2_double_write_error.METH_read()) && ((!(INST_top.DEF_pipeline_fft_fft_stage_valid_2__h211052) || INST_top.INST_pipeline_fft_fft_stage_data_3_double_write_error.METH_read()) && (!(INST_top.DEF_pipeline_fft_fft_stage_valid_3__h317867) || INST_top.INST_pipeline_fft_fft_outputFIFO.METH_i_notFull())))))))));
	 INST_top.DEF_WILL_FIRE_RL_pipeline_fft_fft_linear_fft = INST_top.DEF_CAN_FIRE_RL_pipeline_fft_fft_linear_fft;
	 INST_top.DEF_CAN_FIRE_RL_pipeline_fft_to_ifft = INST_top.INST_pipeline_fft_fft_outputFIFO.METH_i_notEmpty() && INST_top.INST_pipeline_ifft_fft_fft_inputFIFO.METH_i_notFull();
	 INST_top.DEF_WILL_FIRE_RL_pipeline_fft_to_ifft = INST_top.DEF_CAN_FIRE_RL_pipeline_fft_to_ifft;
	 INST_top.DEF_CAN_FIRE_RL_pipeline_fir_add = INST_top.INST_pipeline_fir_m_0.METH_RDY_getResult() && (INST_top.INST_pipeline_fir_m_1.METH_RDY_getResult() && (INST_top.INST_pipeline_fir_m_2.METH_RDY_getResult() && (INST_top.INST_pipeline_fir_m_3.METH_RDY_getResult() && (INST_top.INST_pipeline_fir_m_4.METH_RDY_getResult() && (INST_top.INST_pipeline_fir_m_5.METH_RDY_getResult() && (INST_top.INST_pipeline_fir_m_6.METH_RDY_getResult() && (INST_top.INST_pipeline_fir_m_7.METH_RDY_getResult() && (INST_top.INST_pipeline_fir_m_8.METH_RDY_getResult() && INST_top.INST_pipeline_fir_outfifo.METH_i_notFull()))))))));
	 INST_top.DEF_WILL_FIRE_RL_pipeline_fir_add = INST_top.DEF_CAN_FIRE_RL_pipeline_fir_add;
	 INST_top.DEF_CAN_FIRE_RL_pipeline_fir_mult = INST_top.INST_pipeline_fir_m_0.METH_RDY_putOperands() && (INST_top.INST_pipeline_fir_m_1.METH_RDY_putOperands() && (INST_top.INST_pipeline_fir_m_2.METH_RDY_putOperands() && (INST_top.INST_pipeline_fir_m_3.METH_RDY_putOperands() && (INST_top.INST_pipeline_fir_m_4.METH_RDY_putOperands() && (INST_top.INST_pipeline_fir_m_5.METH_RDY_putOperands() && (INST_top.INST_pipeline_fir_m_6.METH_RDY_putOperands() && (INST_top.INST_pipeline_fir_m_7.METH_RDY_putOperands() && (INST_top.INST_pipeline_fir_m_8.METH_RDY_putOperands() && (INST_top.INST_pipeline_fir_infifo.METH_i_notEmpty() && (INST_top.INST_pipeline_fir_r_0_double_write_error.METH_read() && (INST_top.INST_pipeline_fir_r_1_double_write_error.METH_read() && (INST_top.INST_pipeline_fir_r_2_double_write_error.METH_read() && (INST_top.INST_pipeline_fir_r_3_double_write_error.METH_read() && (INST_top.INST_pipeline_fir_r_4_double_write_error.METH_read() && (INST_top.INST_pipeline_fir_r_5_double_write_error.METH_read() && (INST_top.INST_pipeline_fir_r_6_double_write_error.METH_read() && INST_top.INST_pipeline_fir_r_7_double_write_error.METH_read()))))))))))))))));
	 INST_top.DEF_WILL_FIRE_RL_pipeline_fir_mult = INST_top.DEF_CAN_FIRE_RL_pipeline_fir_mult;
	 INST_top.DEF_CAN_FIRE_RL_pipeline_fir_to_chunker = INST_top.INST_pipeline_fir_outfifo.METH_i_notEmpty() && INST_top.INST_pipeline_chunker_infifo.METH_i_notFull();
	 INST_top.DEF_WILL_FIRE_RL_pipeline_fir_to_chunker = INST_top.DEF_CAN_FIRE_RL_pipeline_fir_to_chunker;
	 INST_top.DEF_pipeline_ifft_fft_fft_stage_valid_3__h625119 = INST_top.INST_pipeline_ifft_fft_fft_stage_valid_3.METH_read();
	 INST_top.DEF_pipeline_ifft_fft_fft_stage_valid_2__h518898 = INST_top.INST_pipeline_ifft_fft_fft_stage_valid_2.METH_read();
	 INST_top.DEF_pipeline_ifft_fft_fft_stage_valid_1__h420366 = INST_top.INST_pipeline_ifft_fft_fft_stage_valid_1.METH_read();
	 INST_top.DEF_pipeline_ifft_fft_fft_stage_valid_0__h321846 = INST_top.INST_pipeline_ifft_fft_fft_stage_valid_0.METH_read();
	 INST_top.DEF_CAN_FIRE_RL_pipeline_ifft_fft_fft_linear_fft = INST_top.INST_pipeline_ifft_fft_fft_stage_data_0_double_write_error.METH_read() && (INST_top.INST_pipeline_ifft_fft_fft_inputFIFO.METH_i_notEmpty() && (INST_top.INST_pipeline_ifft_fft_fft_stage_valid_0_double_write_error.METH_read() && (INST_top.INST_pipeline_ifft_fft_fft_stage_valid_1_double_write_error.METH_read() && (INST_top.INST_pipeline_ifft_fft_fft_stage_valid_2_double_write_error.METH_read() && (INST_top.INST_pipeline_ifft_fft_fft_stage_valid_3_double_write_error.METH_read() && ((!(INST_top.DEF_pipeline_ifft_fft_fft_stage_valid_0__h321846) || INST_top.INST_pipeline_ifft_fft_fft_stage_data_1_double_write_error.METH_read()) && ((!(INST_top.DEF_pipeline_ifft_fft_fft_stage_valid_1__h420366) || INST_top.INST_pipeline_ifft_fft_fft_stage_data_2_double_write_error.METH_read()) && ((!(INST_top.DEF_pipeline_ifft_fft_fft_stage_valid_2__h518898) || INST_top.INST_pipeline_ifft_fft_fft_stage_data_3_double_write_error.METH_read()) && (!(INST_top.DEF_pipeline_ifft_fft_fft_stage_valid_3__h625119) || INST_top.INST_pipeline_ifft_fft_fft_outputFIFO.METH_i_notFull())))))))));
	 INST_top.DEF_WILL_FIRE_RL_pipeline_ifft_fft_fft_linear_fft = INST_top.DEF_CAN_FIRE_RL_pipeline_ifft_fft_fft_linear_fft;
	 INST_top.DEF_CAN_FIRE_RL_pipeline_ifft_inversify = INST_top.INST_pipeline_ifft_fft_fft_outputFIFO.METH_i_notEmpty() && INST_top.INST_pipeline_ifft_outfifo.METH_i_notFull();
	 INST_top.DEF_WILL_FIRE_RL_pipeline_ifft_inversify = INST_top.DEF_CAN_FIRE_RL_pipeline_ifft_inversify;
	 INST_top.DEF_CAN_FIRE_RL_pipeline_ifft_to_splitter = INST_top.INST_pipeline_ifft_outfifo.METH_i_notEmpty() && INST_top.INST_pipeline_splitter_infifo.METH_i_notFull();
	 INST_top.DEF_WILL_FIRE_RL_pipeline_ifft_to_splitter = INST_top.DEF_CAN_FIRE_RL_pipeline_ifft_to_splitter;
	 INST_top.DEF_CAN_FIRE_RL_pipeline_splitter_iterate = INST_top.INST_pipeline_splitter_outfifo.METH_i_notFull() && (INST_top.INST_pipeline_splitter_infifo.METH_i_notEmpty() && INST_top.INST_pipeline_splitter_index_double_write_error.METH_read());
	 INST_top.DEF_WILL_FIRE_RL_pipeline_splitter_iterate = INST_top.DEF_CAN_FIRE_RL_pipeline_splitter_iterate;
	 INST_top.DEF_CAN_FIRE_RL_read = (INST_top.INST_m_doneread_double_write_error.METH_read() && DEF_INST_top_DEF_pipeline_fir_infifo_i_notFull____d2555) && ((DEF_INST_top_DEF_m_inited___d2547 && !DEF_INST_top_DEF_m_doneread__h638543) && !(DEF_INST_top_DEF_x__h639249 == 4294967295u));
	 INST_top.DEF_WILL_FIRE_RL_read = INST_top.DEF_CAN_FIRE_RL_read;
	 INST_top.DEF_CAN_FIRE_RL_write = INST_top.INST_pipeline_splitter_outfifo.METH_i_notEmpty() && DEF_INST_top_DEF_m_inited___d2547;
	 INST_top.DEF_WILL_FIRE_RL_write = INST_top.DEF_CAN_FIRE_RL_write;
	 if (INST_top.DEF_WILL_FIRE_RL_finish)
	   INST_top.RL_finish();
	 if (INST_top.DEF_WILL_FIRE_RL_init)
	   INST_top.RL_init();
	 if (INST_top.DEF_WILL_FIRE_RL_pad)
	   INST_top.RL_pad();
	 if (INST_top.DEF_WILL_FIRE_RL_pipeline_chunker_iterate)
	   INST_top.RL_pipeline_chunker_iterate();
	 if (INST_top.DEF_WILL_FIRE_RL_pipeline_chunker_to_fft)
	   INST_top.RL_pipeline_chunker_to_fft();
	 if (INST_top.DEF_WILL_FIRE_RL_pipeline_fft_to_ifft)
	   INST_top.RL_pipeline_fft_to_ifft();
	 if (INST_top.DEF_WILL_FIRE_RL_pipeline_fft_fft_linear_fft)
	   INST_top.RL_pipeline_fft_fft_linear_fft();
	 if (INST_top.DEF_WILL_FIRE_RL_pipeline_fir_add)
	   INST_top.RL_pipeline_fir_add();
	 if (INST_top.DEF_WILL_FIRE_RL_pipeline_fir_mult)
	   INST_top.RL_pipeline_fir_mult();
	 if (INST_top.DEF_WILL_FIRE_RL_pipeline_fir_to_chunker)
	   INST_top.RL_pipeline_fir_to_chunker();
	 if (INST_top.DEF_WILL_FIRE_RL_pipeline_ifft_fft_fft_linear_fft)
	   INST_top.RL_pipeline_ifft_fft_fft_linear_fft();
	 if (INST_top.DEF_WILL_FIRE_RL_pipeline_ifft_inversify)
	   INST_top.RL_pipeline_ifft_inversify();
	 if (INST_top.DEF_WILL_FIRE_RL_pipeline_ifft_to_splitter)
	   INST_top.RL_pipeline_ifft_to_splitter();
	 if (INST_top.DEF_WILL_FIRE_RL_pipeline_splitter_iterate)
	   INST_top.RL_pipeline_splitter_iterate();
	 if (INST_top.DEF_WILL_FIRE_RL_read)
	   INST_top.RL_read();
	 if (INST_top.DEF_WILL_FIRE_RL_write)
	   INST_top.RL_write();
	 if (do_reset_ticks(simHdl))
	 {
	   INST_top.INST_pipeline_fir_m_0.INST_results.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fir_m_1.INST_results.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fir_m_2.INST_results.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fir_m_3.INST_results.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fir_m_4.INST_results.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fir_m_5.INST_results.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fir_m_6.INST_results.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fir_m_7.INST_results.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fir_m_8.INST_results.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fir_infifo.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fir_outfifo.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fir_r_0.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_fir_r_1.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_fir_r_2.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_fir_r_3.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_fir_r_4.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_fir_r_5.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_fir_r_6.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_fir_r_7.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_chunker_infifo.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_chunker_outfifo.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_chunker_index.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_fft_fft_inputFIFO.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fft_fft_outputFIFO.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_fft_fft_stage_valid_0.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_fft_fft_stage_valid_1.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_fft_fft_stage_valid_2.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_fft_fft_stage_valid_3.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_ifft_fft_fft_inputFIFO.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_ifft_fft_fft_outputFIFO.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_ifft_fft_fft_stage_valid_0.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_ifft_fft_fft_stage_valid_1.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_ifft_fft_fft_stage_valid_2.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_ifft_fft_fft_stage_valid_3.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_pipeline_ifft_outfifo.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_splitter_infifo.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_splitter_outfifo.rst_tick_clk((tUInt8)1u);
	   INST_top.INST_pipeline_splitter_index.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_m_inited.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_m_doneread.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_m_outstanding.rst_tick__clk__1((tUInt8)1u);
	 }
       };

/* Model creation/destruction functions */

void MODEL_mkTestDriver::create_model(tSimStateHdl simHdl, bool master)
{
  sim_hdl = simHdl;
  init_reset_request_counters(sim_hdl);
  mkTestDriver_instance = new MOD_mkTestDriver(sim_hdl, "top", NULL);
  bk_get_or_define_clock(sim_hdl, "CLK");
  if (master)
  {
    bk_alter_clock(sim_hdl, bk_get_clock_by_name(sim_hdl, "CLK"), CLK_LOW, false, 0llu, 5llu, 5llu);
    bk_use_default_reset(sim_hdl);
  }
  bk_set_clock_event_fn(sim_hdl,
			bk_get_clock_by_name(sim_hdl, "CLK"),
			schedule_posedge_CLK,
			NULL,
			(tEdgeDirection)(POSEDGE));
  (mkTestDriver_instance->INST_pipeline_fir_infifo.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_outfifo.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_0.INST_results.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_0.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_1.INST_results.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_1.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_2.INST_results.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_2.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_3.INST_results.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_3.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_4.INST_results.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_4.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_5.INST_results.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_5.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_6.INST_results.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_6.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_7.INST_results.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_7.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_8.INST_results.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fir_m_8.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_chunker_infifo.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_chunker_outfifo.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fft_fft_inputFIFO.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_fft_fft_outputFIFO.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_ifft_fft_fft_inputFIFO.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_ifft_fft_fft_outputFIFO.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_ifft_outfifo.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_splitter_infifo.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_pipeline_splitter_outfifo.set_clk_0)("CLK");
  (mkTestDriver_instance->INST_m_outstanding.set_clk_0)("CLK");
  (mkTestDriver_instance->set_clk_0)("CLK");
}
void MODEL_mkTestDriver::destroy_model()
{
  delete mkTestDriver_instance;
  mkTestDriver_instance = NULL;
}
void MODEL_mkTestDriver::reset_model(bool asserted)
{
  (mkTestDriver_instance->reset_RST_N)(asserted ? (tUInt8)0u : (tUInt8)1u);
}
void * MODEL_mkTestDriver::get_instance()
{
  return mkTestDriver_instance;
}

/* Fill in version numbers */
void MODEL_mkTestDriver::get_version(unsigned int *year,
				     unsigned int *month,
				     char const **annotation,
				     char const **build)
{
  *year = 0u;
  *month = 0u;
  *annotation = NULL;
  *build = "14ff62d";
}

/* Get the model creation time */
time_t MODEL_mkTestDriver::get_creation_time()
{
  
  /* Wed Apr 24 18:07:26 UTC 2024 */
  return 1713982046llu;
}

/* State dumping function */
void MODEL_mkTestDriver::dump_state()
{
  (mkTestDriver_instance->dump_state)(0u);
}

/* VCD dumping functions */
MOD_mkTestDriver & mkTestDriver_backing(tSimStateHdl simHdl)
{
  static MOD_mkTestDriver *instance = NULL;
  if (instance == NULL)
  {
    vcd_set_backing_instance(simHdl, true);
    instance = new MOD_mkTestDriver(simHdl, "top", NULL);
    vcd_set_backing_instance(simHdl, false);
  }
  return *instance;
}
void MODEL_mkTestDriver::dump_VCD_defs()
{
  (mkTestDriver_instance->dump_VCD_defs)(vcd_depth(sim_hdl));
}
void MODEL_mkTestDriver::dump_VCD(tVCDDumpType dt)
{
  (mkTestDriver_instance->dump_VCD)(dt, vcd_depth(sim_hdl), mkTestDriver_backing(sim_hdl));
}
