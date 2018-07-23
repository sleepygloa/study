package com.seonhoblog.samplelogin.thread;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.seonhoblog.samplelogin.R;

public class ThreadActivity extends AppCompatActivity{

    /**
     * 프로그레스바
     */
    ProgressBar bar;
    TextView textView;
    boolean isRunning = false;

    /**
     * 메인 스레드의 UI에 접근하기 위한 핸들러
     */
    ThreadActivity.ProgressHandler handler;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_thread);

        bar = (ProgressBar) findViewById(R.id.progress);
        textView = (TextView) findViewById(R.id.textView);

        handler = new ThreadActivity.ProgressHandler();

    }

    public void onStart() {
        super.onStart();

        bar.setProgress(0);
        Thread thread1 = new Thread(new Runnable() {
            public void run() {
                try {
                    for (int i = 0; i < 20 && isRunning; i++) {
                        Thread.sleep(1000);

                        Message msg = handler.obtainMessage();
                        handler.sendMessage(msg);
                    }
                } catch (Exception ex) {
                    Log.e("MainActivity", "Exception in processing message.", ex);
                }
            }
        });

        isRunning = true;
        thread1.start();
    }

    public void onStop() {
        super.onStop();

        isRunning = false;
    }


    public class ProgressHandler extends Handler {

        public void handleMessage(Message msg) {

            bar.incrementProgressBy(5);

            if (bar.getProgress() == bar.getMax()) {
                textView.setText("Done");
            } else {
                textView.setText("Working ..." + bar.getProgress());
            }

        }

    }
}
