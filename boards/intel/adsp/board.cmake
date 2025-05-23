# Copyright (c) 2022-2025 Intel Corporation
#
# SPDX-License-Identifier: Apache-2.0

if(CONFIG_BOARD_INTEL_ADSP_CAVS25 OR CONFIG_BOARD_INTEL_ADSP_CAVS25_TGPH)

  if($ENV{CAVS_OLD_FLASHER})
    board_set_flasher_ifnset(misc-flasher)
    board_finalize_runner_args(misc-flasher)
  endif()

  board_set_flasher_ifnset(intel_adsp)

  set(RIMAGE_SIGN_KEY "otc_private_key_3k.pem" CACHE STRING "default in cavs25/board.cmake")

  if(CONFIG_BOARD_INTEL_ADSP_CAVS25)
    board_set_rimage_target(tgl)
  endif()

  if(CONFIG_BOARD_INTEL_ADSP_CAVS25_TGPH)
    board_set_rimage_target(tgl-h)
  endif()

  board_finalize_runner_args(intel_adsp)

elseif(CONFIG_BOARD_INTEL_ADSP_ACE15_MTPM  OR CONFIG_BOARD_INTEL_ADSP_ACE15_MTPM_SIM)

  board_set_rimage_target(mtl)

  set(RIMAGE_SIGN_KEY "otc_private_key_3k.pem" CACHE STRING "default in ace15_mtpm/board.cmake")

  board_finalize_runner_args(intel_adsp)

elseif(CONFIG_BOARD_INTEL_ADSP_ACE20_LNL OR CONFIG_BOARD_INTEL_ADSP_ACE20_LNL_SIM)

  set(SUPPORTED_EMU_PLATFORMS acesim)

  board_set_rimage_target(lnl)

  set(RIMAGE_SIGN_KEY "otc_private_key_3k.pem" CACHE STRING "default in ace20_lnl/board.cmake")

elseif(CONFIG_BOARD_INTEL_ADSP_ACE30_PTL OR CONFIG_BOARD_INTEL_ADSP_ACE30_PTL_SIM)

  board_set_rimage_target(ptl)

  set(RIMAGE_SIGN_KEY "otc_private_key.pem" CACHE STRING "default rimage key")

  board_finalize_runner_args(intel_adsp)

elseif(CONFIG_BOARD_INTEL_ADSP_ACE30_WCL OR CONFIG_BOARD_INTEL_ADSP_ACE30_WCL_SIM)

  board_set_rimage_target(wcl)

  set(RIMAGE_SIGN_KEY "otc_private_key.pem" CACHE STRING "default rimage key")

  board_finalize_runner_args(intel_adsp)

endif()
