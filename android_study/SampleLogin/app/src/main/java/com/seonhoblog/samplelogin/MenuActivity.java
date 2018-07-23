package com.seonhoblog.samplelogin;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;

import com.seonhoblog.samplelogin.asyncTask.AsyncTaskActivity;
import com.seonhoblog.samplelogin.bitmapBtn.BitmapBtnActivity;
import com.seonhoblog.samplelogin.cameraImgModify.ImgCoverFlowActivity;
import com.seonhoblog.samplelogin.fragment.FragmentActivity;
import com.seonhoblog.samplelogin.graphAnimation.GraphAnimActivity;
import com.seonhoblog.samplelogin.http.HttpActivity;
import com.seonhoblog.samplelogin.keypad.KeypadActivity;
import com.seonhoblog.samplelogin.layout.LayoutActivity;
import com.seonhoblog.samplelogin.event.EventActivity;
import com.seonhoblog.samplelogin.listView.ListViewActivity;
import com.seonhoblog.samplelogin.multitouch.MultiTouchActivity;
import com.seonhoblog.samplelogin.receiver.SmsActivity;
import com.seonhoblog.samplelogin.rss.RssActivity;
import com.seonhoblog.samplelogin.service.ServiceActivity;
import com.seonhoblog.samplelogin.socket.SocketActivity;
import com.seonhoblog.samplelogin.tapMenu.TapMenuActivity;
import com.seonhoblog.samplelogin.thread.ThreadActivity;
import com.seonhoblog.samplelogin.web.WebActivity;

public class MenuActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu);

        Button btnLayout = (Button) findViewById(R.id.btn_layout);
        Button button3 = (Button) findViewById(R.id.btn_item);
        Button button4 = (Button) findViewById(R.id.btn_service);
        Button button5 = (Button) findViewById(R.id.btn_receiver);
        Button btnEvent = (Button) findViewById(R.id.btn_event);
        Button btnFlagment = (Button) findViewById(R.id.btn_flagment);
        Button btnTapMenu = (Button) findViewById(R.id.btn_tabMenu);
        Button btnWeb = (Button) findViewById(R.id.btn_web);
        Button btnKeypad = (Button) findViewById(R.id.btn_keypad);
        Button btnBitmapBtn = (Button) findViewById(R.id.btn_bitmapBtn);
        Button btnListView = (Button) findViewById(R.id.btn_listview);
        Button btnMultiTouch = (Button) findViewById(R.id.btn_multitouch);
        Button btnPaintBoard = (Button) findViewById(R.id.btn_paintboard);
        Button btnImgCoverFlow = (Button) findViewById(R.id.btn_imgcoverflow);
        Button btnThread = (Button) findViewById(R.id.btn_thread);
        Button btnAsyncTask = (Button) findViewById(R.id.btn_asyncTask);
        Button btnGraphAnim = (Button) findViewById(R.id.btn_graphanim);
        Button btnSocket = (Button) findViewById(R.id.btn_socket);
        Button btnHttp = (Button) findViewById(R.id.btn_http);
        Button btnRss = (Button) findViewById(R.id.btn_rss);


        btnLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toLayout();
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
        btnTapMenu.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toTapMenu();
            }
        });
        btnWeb.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toWeb();
            }
        });
        btnKeypad.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toKeypad();
            }
        });
        btnBitmapBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toBitmapBtn();
            }
        });
        btnListView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toListView();
            }
        });
        btnMultiTouch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toMultiTouch();
            }
        });
        btnPaintBoard.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toPaintBoard();
            }
        });
        btnImgCoverFlow.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toImgCoverFlow();
            }
        });
        btnThread.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toThread();
            }
        });
        btnAsyncTask.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toAsyncTask();
            }
        });
        btnGraphAnim.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toGraphAnim();
            }
        });
        btnSocket.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toSocket();
            }
        });
        btnHttp.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toHttp();
            }
        });
        btnRss.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                toRss();
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

    private void toTapMenu(){
        Intent intent = new Intent(MenuActivity.this, TapMenuActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toWeb(){
        Intent intent = new Intent (MenuActivity.this, WebActivity.class);
        setResult(RESULT_OK);
        finish();
    }
    private void toKeypad(){
        Intent intent = new Intent (MenuActivity.this, KeypadActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toBitmapBtn(){
        Intent intent = new Intent (MenuActivity.this, BitmapBtnActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toListView(){
        Intent intent = new Intent (MenuActivity.this, ListViewActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toMultiTouch(){
        Intent intent = new Intent (MenuActivity.this, MultiTouchActivity.class);
        setResult(RESULT_OK);
        finish();
    }
    private void toPaintBoard(){
        Intent intent = new Intent (MenuActivity.this, MultiTouchActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toImgCoverFlow(){
        Intent intent = new Intent (MenuActivity.this, ImgCoverFlowActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toThread(){
        Intent intent = new Intent (MenuActivity.this, ThreadActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toAsyncTask(){
        Intent intent = new Intent (MenuActivity.this, AsyncTaskActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toGraphAnim(){
        Intent intent = new Intent (MenuActivity.this, GraphAnimActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toSocket(){
        Intent intent = new Intent (MenuActivity.this, SocketActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toHttp(){
        Intent intent = new Intent (MenuActivity.this, HttpActivity.class);
        setResult(RESULT_OK);
        finish();
    }

    private void toRss(){
        Intent intent = new Intent (MenuActivity.this, RssActivity.class);
        setResult(RESULT_OK);
        finish();
    }

}
