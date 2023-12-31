<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>리뷰 게시판</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<c:url value="/common/css/common.css" />" type="text/css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script type="text/javascript">

        const editReview = (reviewNo) => {
            location.href = "/highwayrest/editReview?reviewNo=" + reviewNo;
        }

        const delReview = (reviewNo) => {
            let flag = confirm("후기를 삭제하면 다시 작성할 수 없습니다. 삭제하시겠습니까?");
            if (flag) {
                location.href = "/highwayrest/delReview?reviewNo=" + reviewNo;
            } else {
                alert("삭제가 취소되었습니다.");
            }
        }
    </script>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="d-grid gap-2 mx-auto">
            <h3>리뷰 관리</h3>
        </div>
    </div>

    <div class="row mt-3">
        <div class="d-grid gap-2 col-6 mx-auto mt-3">
            <c:forEach var="r" items="${myList}">
                <table class="table">
                    <tr>
                        <th class="table-light text-center align-middle">휴게소 번호</th>
                        <td>${restNo}
                            <div class="btn-group btn-group-sm" role="group" aria-label="Small button group">
                                <input type="button" value="수정" class="btn btn-outline-secondary"onclick="editReview(${r.reviewNo})">
                                <input type="button" value="삭제" class="btn btn-outline-secondary"onclick="delReview(${r.reviewNo})">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th class="table-light text-center align-middle">작성일</th>
                        <td>${r.WDate}</td>
                    </tr>
                    <tr>
                        <th class="table-light text-center align-middle">별점</th>
                        <td>${r.star}</td>
                    </tr>
                    <tr>
                        <th class="table-light text-center align-middle">후기</th>
                        <td>${r.content}</td>
                    </tr>
                </table>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>