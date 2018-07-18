package com.seonhoblog.samplelogin;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;

import com.seonhoblog.samplelogin.fragment.FragmentActivity;
import com.seonhoblog.samplelogin.layout.LayoutActivity;
import com.seonhoblog.samplelogin.event.EventActivity;
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
        Button btnEvent = (Button) findViewById(R.id.btn_event);
        Button btnFlagment = (Button) findViewById(R.id.btn_flagment);
        Button btnActionBar = (Button) findViewById(R.id.btn_actionbar);

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
        btnEvent.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toEvent();
            }
        });
        btnFlagment.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toFlagment();
            }
        });
        btnActionBar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toActionBar();
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

    private void toEvent(){
        Intent intent = new Intent(MenuActivity.this, EventActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toFlagment(){
        Intent intent = new Intent(MenuActivity.this, FragmentActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toActionBar(){
        Intent intent = new Intent(MenuActivity.this, ActionBarActivity.class);
        setResult(RESULT_OK);
        finish();
    }
}
