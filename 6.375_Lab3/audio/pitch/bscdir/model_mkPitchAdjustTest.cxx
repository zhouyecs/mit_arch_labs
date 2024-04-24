/*
 * Generated by Bluespec Compiler (build 14ff62d)
 * 
 * On Wed Apr 24 22:55:21 CST 2024
 * 
 */
#include "bluesim_primitives.h"
#include "model_mkPitchAdjustTest.h"

#include <cstdlib>
#include <time.h>
#include "bluesim_kernel_api.h"
#include "bs_vcd.h"
#include "bs_reset.h"


/* Constructor */
MODEL_mkPitchAdjustTest::MODEL_mkPitchAdjustTest()
{
  mkPitchAdjustTest_instance = NULL;
}

/* Function for creating a new model */
void * new_MODEL_mkPitchAdjustTest()
{
  MODEL_mkPitchAdjustTest *model = new MODEL_mkPitchAdjustTest();
  return (void *)(model);
}

/* Schedule functions */

static void schedule_posedge_CLK(tSimStateHdl simHdl, void *instance_ptr)
       {
	 MOD_mkPitchAdjustTest &INST_top = *((MOD_mkPitchAdjustTest *)(instance_ptr));
	 INST_top.DEF_x__h6486 = INST_top.INST_check.METH_read();
	 INST_top.DEF_CAN_FIRE_RL_c0 = (INST_top.DEF_x__h6486) == 0u;
	 INST_top.DEF_WILL_FIRE_RL_c0 = INST_top.DEF_CAN_FIRE_RL_c0;
	 INST_top.DEF_CAN_FIRE_RL_c1 = (INST_top.DEF_x__h6486) == 1u;
	 INST_top.DEF_WILL_FIRE_RL_c1 = INST_top.DEF_CAN_FIRE_RL_c1;
	 INST_top.DEF_CAN_FIRE_RL_c2 = (INST_top.DEF_x__h6486) == 2u;
	 INST_top.DEF_WILL_FIRE_RL_c2 = INST_top.DEF_CAN_FIRE_RL_c2;
	 INST_top.DEF_x__h6481 = INST_top.INST_feed.METH_read();
	 INST_top.DEF_CAN_FIRE_RL_f0 = (INST_top.DEF_x__h6481) == 0u;
	 INST_top.DEF_WILL_FIRE_RL_f0 = INST_top.DEF_CAN_FIRE_RL_f0;
	 INST_top.DEF_CAN_FIRE_RL_f1 = (INST_top.DEF_x__h6481) == 1u;
	 INST_top.DEF_WILL_FIRE_RL_f1 = INST_top.DEF_CAN_FIRE_RL_f1;
	 INST_top.DEF_CAN_FIRE_RL_finish = (INST_top.DEF_x__h6481) == 3u && (INST_top.DEF_x__h6486) == 3u;
	 INST_top.DEF_WILL_FIRE_RL_finish = INST_top.DEF_CAN_FIRE_RL_finish;
	 INST_top.DEF_CAN_FIRE_RL_f2 = (INST_top.DEF_x__h6481) == 2u;
	 INST_top.DEF_WILL_FIRE_RL_f2 = INST_top.DEF_CAN_FIRE_RL_f2;
	 if (INST_top.DEF_WILL_FIRE_RL_c0)
	   INST_top.RL_c0();
	 if (INST_top.DEF_WILL_FIRE_RL_c1)
	   INST_top.RL_c1();
	 if (INST_top.DEF_WILL_FIRE_RL_c2)
	   INST_top.RL_c2();
	 if (INST_top.DEF_WILL_FIRE_RL_f0)
	   INST_top.RL_f0();
	 if (INST_top.DEF_WILL_FIRE_RL_f1)
	   INST_top.RL_f1();
	 if (INST_top.DEF_WILL_FIRE_RL_finish)
	   INST_top.RL_finish();
	 if (INST_top.DEF_WILL_FIRE_RL_f2)
	   INST_top.RL_f2();
	 if (do_reset_ticks(simHdl))
	 {
	   INST_top.INST_passed.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_feed.rst_tick__clk__1((tUInt8)1u);
	   INST_top.INST_check.rst_tick__clk__1((tUInt8)1u);
	 }
       };

/* Model creation/destruction functions */

void MODEL_mkPitchAdjustTest::create_model(tSimStateHdl simHdl, bool master)
{
  sim_hdl = simHdl;
  init_reset_request_counters(sim_hdl);
  mkPitchAdjustTest_instance = new MOD_mkPitchAdjustTest(sim_hdl, "top", NULL);
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
  (mkPitchAdjustTest_instance->set_clk_0)("CLK");
}
void MODEL_mkPitchAdjustTest::destroy_model()
{
  delete mkPitchAdjustTest_instance;
  mkPitchAdjustTest_instance = NULL;
}
void MODEL_mkPitchAdjustTest::reset_model(bool asserted)
{
  (mkPitchAdjustTest_instance->reset_RST_N)(asserted ? (tUInt8)0u : (tUInt8)1u);
}
void * MODEL_mkPitchAdjustTest::get_instance()
{
  return mkPitchAdjustTest_instance;
}

/* Fill in version numbers */
void MODEL_mkPitchAdjustTest::get_version(unsigned int *year,
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
time_t MODEL_mkPitchAdjustTest::get_creation_time()
{
  
  /* Wed Apr 24 14:55:21 UTC 2024 */
  return 1713970521llu;
}

/* State dumping function */
void MODEL_mkPitchAdjustTest::dump_state()
{
  (mkPitchAdjustTest_instance->dump_state)(0u);
}

/* VCD dumping functions */
MOD_mkPitchAdjustTest & mkPitchAdjustTest_backing(tSimStateHdl simHdl)
{
  static MOD_mkPitchAdjustTest *instance = NULL;
  if (instance == NULL)
  {
    vcd_set_backing_instance(simHdl, true);
    instance = new MOD_mkPitchAdjustTest(simHdl, "top", NULL);
    vcd_set_backing_instance(simHdl, false);
  }
  return *instance;
}
void MODEL_mkPitchAdjustTest::dump_VCD_defs()
{
  (mkPitchAdjustTest_instance->dump_VCD_defs)(vcd_depth(sim_hdl));
}
void MODEL_mkPitchAdjustTest::dump_VCD(tVCDDumpType dt)
{
  (mkPitchAdjustTest_instance->dump_VCD)(dt, vcd_depth(sim_hdl), mkPitchAdjustTest_backing(sim_hdl));
}
