# for shopping mall



** 2021.09.  restructuring and refactoring** <br>
[주문 API - private ](https://github.com/sunhwa-kim/order)

  * layer architecture 기반의 Spring MSA 개발
  * 이전 프로젝트 보다 transaction 범위 짧게 리팩토링, JPA의 OSIV 개선 
  * -ing
  * 기존 프로젝트에 DI 추가 : apache.common.lang
  * SpringBoot 2.5.4 최신

 <br>
 
---

 <br>
 
### 개발 환경
* OS : Windows
* IDE : Intellij

### 개발 프레임워크
* jdk 11
* spring boot + web
* spring data jpa + Mysql/h2
* lombok

### 빌드
* gradle

---
### code refactoring

* **함수의 매개변수를 어떻게 줄여볼까?**
    1. 객체로 전달
        * 일일이 하나씩 리팩토링?
        * 점진적 리팩토링은 초보인 나에게 의미 있지만, 공통의 객체로 묶을 수 있을까?
            * 객체에 매개변수로 객체 전달은 캡슐화에 맞지 않다.
        
    2. **Service 레이어의 매개변수들은 모두 Repository를 향한다.**
        * 역할 분리?
        * entity의 변경은 entity가 담당
          * 메서드별 분리 될, JPA 별도의 트랜잭션 범위 할당하지 않아도 되는 장점이 보였다.
        * Service는 요청에 따라 DB로부터 entity 전달/전송 역할만
    
    * RESULT   [[ git_ history ]](https://github.com/sunhwa-kim/Spring_practice/commit/3174337c4a8f274ad92a6fc8f4bd258034167580#diff-4ee76a5028fb660885ee8bb8bf120e3c26181968969b36db96aaceafd9947d93)
    
        * 람다의 간편화
           ```java
                userRepository.findById(1L).ifPresent(user -> {
                    user.deledtedAccount(LocalDateTime.now(),UserStatus.UNREGISTERED,true);
                });
          
            ```
            ```java
                userRepository.findById(1L).ifPresent(User::deledtedAccount);
            ```
        * entity 값 변화에 대한 매개변수 삭제 
            ```java
                entity.deledtedAccount(LocalDateTime.now(), UserStatus.UNREGISTERED, true);
            ```
            ```java
                entity.deledtedAccount();
            ```
          
* gradle 설정 변경
  * 테스트에서 @Slf4j 자동 임포트 오류 발생
    * compile() 로 변경
    * complieOnly 는 compile 클래스 경로에만 gradle이 종속성 추가하기 때문에 테스트 코드에서 import 안 됨
