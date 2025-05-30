/*
 * Copyright (c) 2020 Linumiz
 *
 * SPDX-License-Identifier: Apache-2.0
 */
#include "hawkbit_device.h"
#include <string.h>
#include <zephyr/mgmt/hawkbit/hawkbit.h>

static bool hawkbit_get_device_identity_default(char *id, int id_max_len);

static hawkbit_get_device_identity_cb_handler_t hawkbit_get_device_identity_cb_handler =
	hawkbit_get_device_identity_default;

bool hawkbit_get_device_identity(char *id, int id_max_len)
{
	return hawkbit_get_device_identity_cb_handler(id, id_max_len);
}

static bool hawkbit_get_device_identity_default(char *id, int id_max_len)
{
#ifdef CONFIG_HAWKBIT_HWINFO_DEVICE_ID
	uint8_t hwinfo_id[DEVICE_ID_BIN_MAX_SIZE];
	ssize_t id_length, length;

	memset(id, 0, id_max_len);
	length = snprintk(id, id_max_len, "%s-", CONFIG_BOARD);
	if (length <= 0) {
		return false;
	}

	id_length = hwinfo_get_device_id(hwinfo_id, DEVICE_ID_BIN_MAX_SIZE);
	if (id_length <= 0) {
		return false;
	}

	length = bin2hex(hwinfo_id, (size_t)id_length, &id[length], id_max_len - length);

	return length > 0;
#else /* CONFIG_HAWKBIT_HWINFO_DEVICE_ID */
	ARG_UNUSED(id);
	ARG_UNUSED(id_max_len);

	return false;
#endif /* CONFIG_HAWKBIT_HWINFO_DEVICE_ID */
}

#ifdef CONFIG_HAWKBIT_CUSTOM_DEVICE_ID
int hawkbit_set_device_identity_cb(hawkbit_get_device_identity_cb_handler_t cb)
{
	if (cb == NULL) {
		return -EINVAL;
	}

	hawkbit_get_device_identity_cb_handler = cb;

	return 0;
}
#endif /* CONFIG_HAWKBIT_CUSTOM_DEVICE_ID */
