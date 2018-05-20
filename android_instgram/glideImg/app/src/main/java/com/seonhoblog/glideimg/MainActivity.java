package com.seonhoblog.glideimg;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.btn_start).setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                startLoadingBackImage();
            }
        });
    }
        private void startLoadingBackImage(){
            String url = "http://img.mbn.co.kr/filewww/news/other/2018/01/09/100019201008.jpg";
        }

}
