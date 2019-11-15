/**
 * Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import { Notification } from "../../models";
import {
    DISMISS_NOTIFICATION,
    DismissNotificationAction,
    FIRE_NOTIFICATION,
    FireNotificationAction,
    GlobalActionTypes,
    HideGlobalLoaderAction,
    ShowGlobalLoaderAction
} from "./types";
/**
 * Show global loader action.
 *
 * @returns An action of type `SHOW_GLOBAL_LOADER`
 */
export const showGlobalLoader = (): ShowGlobalLoaderAction => ({
    type: GlobalActionTypes.SHOW_GLOBAL_LOADER
});

/**
 * Hide global loader action.
 *
 * @returns An action of type `HIDE_GLOBAL_LOADER`
 */
export const hideGlobalLoader = (): HideGlobalLoaderAction => ({
    type: GlobalActionTypes.HIDE_GLOBAL_LOADER
});

/**
 * Dispatches an action that fires a notification
 * @param notification
 */
export const fireNotification = (notification: Notification): FireNotificationAction => ({
    payload: notification,
    type: FIRE_NOTIFICATION
});

export const dismissNotification = (): DismissNotificationAction => ({
    type: DISMISS_NOTIFICATION
});
