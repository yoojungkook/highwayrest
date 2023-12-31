<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 카카오 로그인 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script src="src/main/webapp/WEB-INF/apikey.js"></script>
    <script type="text/javascript">
        Kakao.init("9078530b4b7e4c304208ca7503a016a9");
        function kakaoLogin() {
            Kakao.Auth.login({
                success: function () {
                    Kakao.API.request({
                        url: '/v2/user/me',
                        success: function (res) {
                            let id = "kakao_" + res.id;
                            let email = res.kakao_account.email;
                            let properties = res.properties;
                            let name = properties.nickname;
                            // let profile_image = properties.profile_image;

                            // 회원이 DB에 있는지
                            $.ajax({
                                type: 'post',
                                url: 'kakaoLogin',
                                data: {"id": id},
                                dataType: 'json',
                                success: function (result) {
                                    // 카카오 첫 로그인
                                    if (result.dbcheck == "null") {
                                        var nickname = prompt('사용하실 닉네임을 입력해주세요');
                                        if (nickname != null) {
                                            $.ajax({
                                                type: 'post',
                                                url: 'kakaoJoin',
                                                data: {"id": id, "name": name, "email": email, "nickname": nickname},
                                                dataType: 'json',
                                                success: function () {
                                                    alert(nickname + "님 환영합니다.");
                                                    location.href = "${pageContext.request.contextPath}/index.jsp";
                                                },
                                                error: function (error) {
                                                    console.error(error);
                                                }
                                            });
                                        } else {
                                            location.href = "/member/login";
                                        }
                                    } else {
                                        // 카카오 기존 회원
                                        $.ajax({
                                            type: 'post',
                                            url: 'kakaoLogins',
                                            data: {"id": id},
                                            dataType: 'json',
                                            success: function (res) {
                                                console.log(res);
                                                alert(res.nickname + "님 환영합니다.");
                                                location.href = "${pageContext.request.contextPath}/index.jsp";
                                            },
                                            error: function (error) {
                                                console.error(error);
                                            }
                                        });
                                    }
                                }, fail: function (error) {
                                    console.error(error);
                                }
                            });
                        },
                        fail: function (error) {
                            console.error(error);
                        }
                    });
                }
            });
        }
    </script>
</head>

<body>
<h3 class="mt-3">로그인</h3>
    <div class="row justify-content-center">
        <div class="col-lg-6">
            <form action="${pageContext.request.contextPath}/member/login" method="post">
                <div class="mb-3">
                    <c:if test="${not empty msg}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle mx-1"></i>${msg}
                        </div>
                    </c:if>
                </div>
                <div class="mb-3 text-start">
                    <label for="id" class="form-label ms-2">아이디</label>
                    <input type="text" id="id" name="id" class="form-control" placeholder="Username" autofocus>
                </div>
                <div class="mb-3 text-start">
                    <label for="password" class="form-label ms-2" style="text-align:left;">비밀번호</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Password">
                </div>
                <button type="submit" class="btn btn-secondary btn-lg w-100 mb-3">
                    <i class="fa-solid fa-arrow-right-to-bracket"></i>
                    <span>로그인</span>
                </button>
                <a href="javascript:kakaoLogin()" class="btn btn-warning btn-lg w-100 mb-3">
                    <i class="fas fa-comment text-[color:#ffe812]"></i>
                    <span>카카오 로그인</span>
                </a>
                <div class="d-flex justify-content-center">
                    <a class="btn btn-dark btn-sm me-2" href="${pageContext.request.contextPath}/member/join" role="button">회원가입</a>
                    <a class="btn btn-dark btn-sm me-2" href="${pageContext.request.contextPath}/member/findId" role="button">아이디찾기</a>
                    <a class="btn btn-dark btn-sm" href="${pageContext.request.contextPath}/member/findPwd" role="button">비밀번호찾기</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>