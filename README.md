### private projects

1. order
2. Let's Study
3. springboot with aws

<br>

---

## MSA

[adm - 사용자, 상품, 주문](https://github.com/sunhwa-kim/Spring_practice/tree/master/adm)
→ [order (private) ](https://github.com/sunhwa-kim/order)
<br>

* Layered architecture 기반 spring MAS 개발 목표
* 기존 프로젝트에서 JPA 트랜잭션 개선

<br>

---


## Let's Study  Web Application


### project - private
personal, 2021.04 ~ 05

### BE
Spring Boot<br>Spring Security<br>JDK 11<br>JPA<br>H2DB<br>

### FE
tymeleaf<br>boot-strap<br>jQueyr<br>Ajax

### FE 라이브러리
jdenticon<br>font-awesome<br>cropper.js<br>tagify

### API
* 회원가입,로그인 
    * 스프링시큐리티 커스터마이즈
    * 서버사이드 검증 
    * 비밀번호 해싱, 쿠키생성
    * 토큰 인증
* 프로필 조회 
    * 인증된 계정 사용자/일반 사용자 데이터 및 화면 처리
* 프로필 수정 
    * 이미지 업로드
    * 스터디 관심 주제 설정
* 계정 설정
    * 닉네임 변경
    * 비밀번호 변경

### Configuration
* Spring Security
  * @EnableWebSecurity와 WebSecurityConfigurerAdapter 이용
  * secrurity filter 등 Spring Security 커스터마이즈 설정
  * login 커스터마이즈
  * rememberMe 이용한 쿠키 설정

* PasswordEncoder 
  * PasswordEncoderFactories : bcrypt
    * 해싱강도 및 Hash + salt
    * 단방향 해싱
* AppProperties
  * host - local

* application.properties - local, h2DB create-drop
* application-dev.properties - h2DB server, SMTP
  
### view
sign-up : form data, fail-fast  <br>
login<br>check-email<br>GET profile/{nickname}<br>settings/profile<br>settings/notification<br>settings/alarm<br>settings/keywords<br>settings/account

<div style="inline;">
<img src="https://user-images.githubusercontent.com/66774973/119087062-7005c900-ba41-11eb-8ba8-f3e4b0e6351d.PNG" width="300">
<img src="https://user-images.githubusercontent.com/66774973/119087329-ef939800-ba41-11eb-88ae-4b08fa513852.PNG" width="300" height="230">
</div>
<br>
<div style="inline;">
<img src="https://user-images.githubusercontent.com/66774973/119087569-4c8f4e00-ba42-11eb-8e41-21ee6ae19b11.PNG" width="300">
<img src="https://user-images.githubusercontent.com/66774973/119087669-7b0d2900-ba42-11eb-9d75-6b66a2c5e156.PNG" width="400">
</div>
