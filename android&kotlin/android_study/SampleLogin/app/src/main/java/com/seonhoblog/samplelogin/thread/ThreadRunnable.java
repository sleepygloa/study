package com.seonhoblog.samplelogin.thread;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.seonhoblog.samplelogin.R;

public class ThreadRunnable extends Activity{

    ProgressBar bar;
    TextView textView;
    boolean isRunning = false;
    Handler handler;
    ThreadRunnable.ProgressRunnable runnable;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        bar = (ProgressBar) findViewById(R.id.pb_thread_bar);
        textView = (TextView) findViewById(R.id.tv_thread_text);

        handler = new Handler();
        runnable = new ThreadRunnable.ProgressRunnable();
    }

    public void onStart() {
        super.onStart();

        bar.setProgress(0);
        Thread thread1 = new Thread(new Runnable() {
            public void run() {
                try {
                    for (int i = 0; i < 20 && isRunning; i++) {
                        Thread.sleep(1000);

                        handler.post(runnable);
                    }
                } catch (Exception ex) {
                    Log.e("SampleThreadActivity", "Exception in processing message.", ex);
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


    public class ProgressRunnable implements Runnable {

        public void run() {

            bar.incrementProgressBy(5);

            if (bar.getProgress() == bar.getMax()) {
                textView.setText("Runnable Done");
            } else {
                textView.setText("Runnable Working ..." + bar.getProgress());
            }

        }

    }

}
