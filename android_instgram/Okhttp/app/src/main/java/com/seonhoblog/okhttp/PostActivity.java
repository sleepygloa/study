package com.seonhoblog.okhttp;

import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ImageView;

public class PostActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_post);

        ImageView ivPost = (ImageView) findViewById(R.id.iv_post);

        Intent intent = getIntent();
        Uri photoUri = intent.getData();
        ivPost.setImageURI(photoUri);

//        Bundle extras = getIntent().getExtras();
//        Bitmap imageBitmap = (Bitmap) extras.get("data");
//        ivPost.setImageBitmap(imageBitmap);

    }
}
