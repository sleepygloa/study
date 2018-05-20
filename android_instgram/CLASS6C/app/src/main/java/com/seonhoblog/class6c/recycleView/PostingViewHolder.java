package com.seonhoblog.class6c.recycleView;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.seonhoblog.class6c.R;

public class PostingViewHolder extends RecyclerView.ViewHolder {

    public ImageView ivImg, ivLike, ivShare;
    public TextView tvLikeCount, tvUserName, tvPostText;

    public PostingViewHolder(View itemView) {
        super(itemView);
        ivImg = (ImageView) itemView.findViewById(R.id.iv_img);
        ivLike = (ImageView) itemView.findViewById(R.id.iv_like);
        ivShare = (ImageView) itemView.findViewById(R.id.iv_share);

        tvLikeCount = (TextView) itemView.findViewById(R.id.tv_likeCount);
        tvUserName = (TextView) itemView.findViewById(R.id.tv_userName);
        tvPostText = (TextView) itemView.findViewById(R.id.tv_postText);


    }
}
