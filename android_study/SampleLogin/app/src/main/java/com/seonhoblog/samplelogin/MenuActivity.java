package com.seonhoblog.samplelogin;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;

public class MenuActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu);

        Button button = (Button) findViewById(R.id.btn_customer);
        Button button2 = (Button) findViewById(R.id.btn_sales);
        Button button3 = (Button) findViewById(R.id.btn_item);

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



    }


    public void toLogin(){
//        Intent intent = new Intent(MenuActivity.this, MainActivity.class);
        Intent intent = new Intent();
        setResult(RESULT_OK);
        finish();
  //      startActivityForResult(intent, 100);
    }
}
