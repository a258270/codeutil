/**
 * 
 */
package com.fh.util;

import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jpush.api.JPushClient;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.notification.Notification;

/**
 * @author Administrator
 *
 */
public class SendUtil {
	
	public static PushPayload buildPushObject_all_alias_alert(String name, String content) {
        return PushPayload.newBuilder()
                .setPlatform(Platform.android())
                .setAudience(Audience.alias(name))
                .setNotification(Notification.alert(content))
                .build();
    }
	
	public static void SendMsg(String name, String content){
		JPushClient jpushClient = new JPushClient("58b2a07d8ac17bc2a469b47e", "97f0b292ac1ae6f7763efcb3", 3);
		PushPayload payload = buildPushObject_all_alias_alert(name, content);
		try {
			jpushClient.sendPush(payload);
		} catch (APIConnectionException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		} catch (APIRequestException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}
	}
}
