package com.seonhoblog.class6c;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.seonhoblog.class6c.model.PostItem;


import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ArrayList<PostItem>  listItem = new ArrayList<PostItem>();
        LinearLayout llScrollParent = (LinearLayout) findViewById(R.id.ll_scroll);

        for (int i = 0 ; i < 5 ; i ++){
            PostItem item = new PostItem(
                    true, 125, "back",
                    "http://www.asiae.co.kr/news/view.htm?idxno=2017090912402625418", "WOW!!"
            );
            listItem.add(i, item);

        }

        for(PostItem item : listItem){
            View v = View.inflate(this,R.layout.post_item, null);
            TextView tvUserName = (TextView) v.findViewById(R.id.tv_userName);
            TextView tvPostText = (TextView) v.findViewById(R.id.tv_postText);

            tvUserName.setText(item.getUserName());
            tvPostText.setText(item.getPostText());

            llScrollParent.addView(v);
        }


    }
}
