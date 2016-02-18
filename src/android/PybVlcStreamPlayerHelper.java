package org.apache.cordova.PybStreamPlayer;

import android.content.Context;
import android.content.Intent;

import pengyanb.com.videoviewstreamplayer.VideoviewStreamPlayerActivity;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;

import org.json.JSONException;
import org.json.JSONArray;

public class PybVlcStreamPlayerHelper extends CordovaPlugin{
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException{
        if(action.equals("openPlayerForStreamURL")){
            String urlString = args.getString(0);
            Context context = this.cordova.getActivity().getApplicationContext();
            Intent intent = new Intent(context, VideoviewStreamPlayerActivity.class);
            intent.putExtra("UrlString", urlString);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent);
            return true;
        }
        return false;
    }
}