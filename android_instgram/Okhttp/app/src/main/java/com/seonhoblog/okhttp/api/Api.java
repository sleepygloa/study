package com.seonhoblog.okhttp.api;

public class Api {

    public static final String BASE_URL = "http://61.252.235.153:18082";
//    public static final String BASE_URL = "http://localhost:8080";
    public static final String GET_POST = BASE_URL + "/instar/getInstarContent";

    /**
     {
     "id" : 1,
     "uploader" : "g82",
     "text" : "현영아...",
     "likes" : 0,
     "created_at" : "2016-05-05T07:27:35.9622",
     "updated_at" : "2016-05-05T07:27:35.9622",
     "image" : {
     "url" : "/uploads/post/image/1/IMG_6940.jpg"
     }

     }
      */

    public static class Post {
        int IDX;
        String IN_USER_ID;
        String TEXT;
        int LIKES = 0;
        String IN_DT;
        String UP_DT;
        Img IMAGE;
        String IMG;

        public int getIDX() {
            return IDX;
        }

        public String getIN_USER_ID() {
            return IN_USER_ID;
        }

        public String getTEXT() {
            return TEXT;
        }

        public int getLIKES() {
            return LIKES;
        }

        public String getIN_DT() {
            return IN_DT;
        }

        public String getUP_DT() {
            return UP_DT;
        }

        public Img getIMAGE() {
            return IMAGE;
        }

        public String getIMG() {
            return IMG;
        }


        public static class Img{
            String url;

            public String getUrl() {
                return url;
            }
        }
    }


}
