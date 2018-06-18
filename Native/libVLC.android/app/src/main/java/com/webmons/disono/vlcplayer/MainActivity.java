package com.webmons.disono.vlcplayer;

import android.content.pm.ActivityInfo;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.view.SurfaceView;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;

import com.webmons.disono.vlc.VlcListener;
import com.webmons.disono.vlc.VlcVideoLibrary;

import java.util.Locale;
import java.util.Timer;
import java.util.TimerTask;

public class MainActivity extends AppCompatActivity implements VlcListener, View.OnClickListener {

    SurfaceView surfaceView;
    LinearLayout mediaPlayerView;
    LinearLayout mediaPlayerControls;
    SeekBar mSeekBar;
    int mProgress = 0;
    boolean isSeeking = false;
    private VlcVideoLibrary vlcVideoLibrary;
    private ImageButton bStartStop;
    private Handler handlerSeekBar;
    private Runnable runnableSeekBar;
    private TextView videoCurrentLoc;
    private TextView videoDuration;

    private Handler handlerOverlay;
    private Runnable runnableOverlay;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

        this.requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);

        android.support.v7.app.ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.hide();
        }

        setContentView(R.layout.activity_main);

        mSeekBar = findViewById(R.id.videoSeekBar);

        surfaceView = findViewById(R.id.surfaceView);
        bStartStop = findViewById(R.id.b_start_stop);

        videoCurrentLoc = findViewById(R.id.videoCurrentLoc);
        videoDuration = findViewById(R.id.videoDuration);

        mediaPlayerView = findViewById(R.id.mediaPlayerView);
        mediaPlayerControls = findViewById(R.id.mediaPlayerControls);

        mediaPlayerControls.bringToFront();
        bStartStop.setOnClickListener(this);
        vlcVideoLibrary = new VlcVideoLibrary(this, this, surfaceView);

        _handlerSeekBar();
        _handlerMediaControl();
    }

    @Override
    public void onClick(View v) {
        if (!vlcVideoLibrary.isPlaying()) {
            vlcVideoLibrary.play("rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov");
        } else {
            vlcVideoLibrary.pause();
        }
    }

    @Override
    public void onPlayVlc() {
        Toast.makeText(this, "Playing", Toast.LENGTH_SHORT).show();

        Drawable drawableIcon = getResources().getDrawable(R.drawable.ic_pause_white_24dp);
        bStartStop.setImageDrawable(drawableIcon);
    }

    @Override
    public void onPauseVlc() {
        Toast.makeText(this, "Pause", Toast.LENGTH_SHORT).show();

        Drawable drawableIcon = getResources().getDrawable(R.drawable.ic_play_arrow_white_24dp);
        bStartStop.setImageDrawable(drawableIcon);
    }

    @Override
    public void onStopVlc() {
        Toast.makeText(this, "Stop", Toast.LENGTH_SHORT).show();
        Drawable drawableIcon = getResources().getDrawable(R.drawable.ic_play_arrow_white_24dp);
        bStartStop.setImageDrawable(drawableIcon);
    }

    @Override
    public void onVideoEnd() {
        Toast.makeText(this, "End", Toast.LENGTH_SHORT).show();
        Drawable drawableIcon = getResources().getDrawable(R.drawable.ic_play_arrow_white_24dp);
        bStartStop.setImageDrawable(drawableIcon);
    }

    @Override
    public void onError() {
        Toast.makeText(this, "Error, make sure your endpoint is correct", Toast.LENGTH_SHORT).show();
        vlcVideoLibrary.stop();

        Drawable drawableIcon = getResources().getDrawable(R.drawable.ic_play_arrow_white_24dp);
        bStartStop.setImageDrawable(drawableIcon);
    }

    private void _handlerSeekBar() {
        // SEEK BAR
        handlerSeekBar = new Handler();
        runnableSeekBar = () -> {
            if (vlcVideoLibrary.getPlayer() != null && vlcVideoLibrary.isPlaying()) {
                long curTime = vlcVideoLibrary.getPlayer().getTime();
                long totalTime = (long) (curTime / vlcVideoLibrary.getPlayer().getPosition());
                int minutes = (int) (curTime / (60 * 1000));
                int seconds = (int) ((curTime / 1000) % 60);
                int endMinutes = (int) (totalTime / (60 * 1000));
                int endSeconds = (int) ((totalTime / 1000) % 60);
                String currentLoc = String.format(Locale.US, "%02d:%02d", minutes, seconds);
                String duration = String.format(Locale.US, "%02d:%02d", endMinutes, endSeconds);

                videoCurrentLoc.setText(currentLoc);
                videoDuration.setText(duration);

                if (!isSeeking) {
                    int playingPos = (int) (vlcVideoLibrary.getPlayer().getPosition() * 100);
                    mSeekBar.setProgress(playingPos);
                }
            }

            handlerSeekBar.postDelayed(runnableSeekBar, 1000);
        };
        runnableSeekBar.run();
        mSeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress,
                                          boolean fromUser) {
                mProgress = progress;
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {
                isSeeking = true;
            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                // progress
                if (vlcVideoLibrary.getPlayer() != null && vlcVideoLibrary.getPlayer().getTime() > 0 && mProgress > 0 && isSeeking) {
                    vlcVideoLibrary.getPlayer().pause();
                    vlcVideoLibrary.getPlayer().setPosition(((float) mProgress / 100.0f));

                    new Timer().schedule(
                            new TimerTask() {
                                @Override
                                public void run() {
                                    vlcVideoLibrary.getPlayer().play();
                                }
                            },
                            600
                    );
                } else {
                    vlcVideoLibrary.stop();
                    _reInit();
                }

                isSeeking = false;
            }
        });
    }

    private void _reInit() {
        vlcVideoLibrary = new VlcVideoLibrary(this, this, surfaceView);
        vlcVideoLibrary.play("rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov");
    }

    private void _handlerMediaControl() {
        // OVERLAY
        handlerOverlay = new Handler();
        runnableOverlay = () -> mediaPlayerControls.setVisibility(View.GONE);
        final long timeToDisappear = 3000;
        handlerOverlay.postDelayed(runnableOverlay, timeToDisappear);
        mediaPlayerView.setOnClickListener(view -> {
            mediaPlayerControls.setVisibility(View.VISIBLE);

            handlerOverlay.removeCallbacks(runnableOverlay);
            handlerOverlay.postDelayed(runnableOverlay, timeToDisappear);
        });
    }
}
