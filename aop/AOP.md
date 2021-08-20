#### 2021.08

* personal project
  * focus on aop and validation
    * exception and error message
  * simple project


### Dev.

* OS : windows
* IDE : intellij


* gradle
* springboot, aop, validation,..
* java v11

* Restful
* MVC model pattern


---


# AOP

  
* aop method debug<br><br>
  <img src="https://user-images.githubusercontent.com/66774973/129746864-805d2770-d850-4070-b256-c3df83c8f76f.png">


---


* Timer aop <br><br>
  <img src="https://user-images.githubusercontent.com/66774973/129753813-05450dfc-2f23-47f4-8401-54974933e62e.png">

  ---

* DecodeAop <br>
  * when PUT request/response, check Email changed
  * result of decode Email address in server  <br><br>
  <img src="https://user-images.githubusercontent.com/66774973/129776111-99088f75-7629-45eb-a433-06581eb65d12.png">

    ``` java
       {
         "email":"c3VuaHdhMjAyMUBlbWFpbC5jb20=",
         "name": "sunhwa",
         "password" : "asdf1234"
       }
    ```

  ---


# VALIDATION


  * custom validation
    * client request
     ``` json
      {
        "name":"sunhwa",
        "email":"test1@email.com",
        "password":"asdf1234",
        "phoneNumber":"010-1234-1234",
          "movies" : [
              {
                "title": "히든 피겨스",
                "GENRE" : ["드라마"],
                "watch_movie_date" : "20210802"
              },
              {
                "title": "세븐",
                "GENRE" : ["스릴러"],
                "watch_movie_date" : "20210803"
          }]
        }
      }
     ```
  * RequestDto in server
    * enum class : korean, english 
    * json field name and class's memeber variables 
    * snake-case and camel-case
    
      ```  json
      
        "SignUpRequest"
        {
           "name"="sunhwa",
           "email"="test1@email.com",
           "password"="asdf1234",
           "phoneNumber"="010-1234-1234",
           "movies="[
                "MovieDto"{
                   "title"="히든 피겨스",
                   "genres"= ["DRAMA"],
                   "watchMovieDate=""20210802"
                },
                "MovieDto"{
                   "title"="세븐",
                   "genres"=["THRILLER"],
                   "watchMovieDate"="20210803"
                }]
        }
      
      ```

        
  ---


# EXCEPTION

* API가 많아질 수록 validation 의 에러와 메시지 전달로 코드 중복 증가 ( 엔터프라이즈 프레임워크 )
  * 기본적인 에러사항들 global exception 처리
    * 공백/null, 타입 미스 (enum) 등
    * ErrorResponse : status, request_url, data { field name : message }
      ```json
      {
          "title": " ",
          "GENRE" : ["액션","공상과학"],
          "movie_director" : "크리스토퍼 놀런",
          "release_date": "20100721"
        }
      ```
    
      ```json
      {
        "status": "FAIL",
        "request_url": "/api/movie",
        "data": {
          "title": "공백일 수 없습니다"
        }
      }
      ```