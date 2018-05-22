package com.seonhoblog.okhttp;

import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.google.gson.Gson;
import com.seonhoblog.okhttp.api.Api;
import com.seonhoblog.okhttp.api.Api.Post;

import java.io.IOException;
import java.util.ArrayList;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class TimelineFragment extends Fragment{

    ArrayList<Post> arrayList;
    PostViewAdapter postViewAdapter;

    public TimelineFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        fetchAsyncPosts();

        // Inflate the layout for this fragment
        View baseView = inflater.inflate(R.layout.fragment_timeline, container, false);
        RecyclerView recyclerView = (RecyclerView) baseView.findViewById(R.id.rv_list);
        recyclerView.setLayoutManager(new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false));
        postViewAdapter = new PostViewAdapter();
        recyclerView.setAdapter(postViewAdapter);

        return baseView;
    }

    private void fetchAsyncPosts() {
        arrayList = new ArrayList<>();
        FetchPostsTask fetchPostsTask = new FetchPostsTask();
        fetchPostsTask.execute(Api.GET_POST);

    }
    class FetchPostsTask extends AsyncTask<String, Void, Api.Post[]>{
        @Override
        protected Api.Post[] doInBackground(String... strings){

            String url = strings[0];

            OkHttpClient client = new OkHttpClient();

            Request request = new Request.Builder()
                    .url(url)
                    .build();
            try {
                Response response = client.newCall(request).execute();

                Gson gson = new Gson();
                Api.Post[] posts = gson.fromJson(response.body().charStream(), Api.Post[].class);

                return posts;
            } catch (IOException e) {
                Log.d("FetchPostsTask", e.getMessage());
                return null;
            }
       }

       @Override
        protected void onPostExecute(Api.Post[] posts){
            super.onPostExecute(posts);
            for(Api.Post post : posts){
                arrayList.add(post);
            }

            postViewAdapter.notifyDataSetChanged(); //자료가 바뀔때 갱신해달라는 메세지
       }

    }

    class PostViewAdapter extends RecyclerView.Adapter<PostViewHolder> {

        @Override
        public PostViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View baseView = getActivity().getLayoutInflater().inflate(R.layout.item_post, parent, false);
            PostViewHolder postViewHolder = new PostViewHolder(baseView);
            return postViewHolder;
        }

        @Override
        public void onBindViewHolder(PostViewHolder holder, int position) {

            Post item = arrayList.get(position);

            String url = item.getIMG();
            Glide.with(TimelineFragment.this)
                    .load(Api.BASE_URL+url)
                    .into(holder.iv_post);

            holder.tv_username.setText(item.getIN_USER_ID());
            holder.tv_posttext.setText(item.getTEXT());
            holder.tv_postlikecount.setText( String.valueOf( item.getLIKES() ) );
        }

        @Override
        public int getItemCount() {
            return arrayList.size();

        }

    }

    class PostViewHolder extends RecyclerView.ViewHolder {

        public TextView tv_username, tv_postlikecount, tv_posttext;
        public ImageView iv_post;

        public PostViewHolder(View itemView) {
            super(itemView);
            iv_post = (ImageView) itemView.findViewById(R.id.iv_post_img);
            tv_username = (TextView) itemView.findViewById(R.id.tv_user_nickname);
            tv_postlikecount = (TextView) itemView.findViewById(R.id.tv_like_count);
            tv_posttext = (TextView) itemView.findViewById(R.id.tv_post_text);

        }
    }

}
