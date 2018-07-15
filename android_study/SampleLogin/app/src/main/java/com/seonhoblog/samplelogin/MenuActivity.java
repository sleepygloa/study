package com.seonhoblog.samplelogin;

import android.content.Intent;
import android.os.Bundle;
import android.provider.Telephony;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;

import com.seonhoblog.samplelogin.Layout.LayoutActivity;
import com.seonhoblog.samplelogin.receiver.Receiver;
import com.seonhoblog.samplelogin.receiver.SmsActivity;
import com.seonhoblog.samplelogin.service.ServiceActivity;

public class MenuActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu);

        Button btnLayout = (Button) findViewById(R.id.btn_layout);
        Button button = (Button) findViewById(R.id.btn_customer);
        Button button2 = (Button) findViewById(R.id.btn_sales);
        Button button3 = (Button) findViewById(R.id.btn_item);
        Button button4 = (Button) findViewById(R.id.btn_service);
        Button button5 = (Button) findViewById(R.id.btn_receiver);

        btnLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toLayout();
            }
        });
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toLogin();
            }
        });
        button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toLogin();
            }
        });
        button3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toLogin();
            }
        });
        button4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });
        button5.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toReceiver();
            }
        });


    }

    private void toLayout(){
        Intent intent = new Intent(MenuActivity.this, LayoutActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toService(){
        Intent intent = new Intent(MenuActivity.this, ServiceActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toReceiver(){
        Intent intent = new Intent(MenuActivity.this, SmsActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toLogin(){
        Intent intent = new Intent();
        setResult(RESULT_OK);
        finish();
    }
}
