<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">


<meta name="viewport" content="width=device-width, initial-scale=1">
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
   rel="stylesheet">
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


<title>VitaGems Notice</title>
<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
   type="text/css">
<link
   href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
   rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<!-- Custom styles for this page -->
<link href="vendor/datatables/dataTables.bootstrap4.min.css"
   rel="stylesheet">

<style>
h2 {
   color: black;
}

.d-flex {
   white-space: nowrap;
}

/* Style the buttons */
.btn1 {
   height: 40px;
   color: black;
   border: none;
   outline: none;
   padding: 5px 15px;
   background-color: white;
   cursor: pointer;
   border-radius: 7px;
   background-color: white;
}

.btn1:hover {
   color: black;
   background-color: #ddd;
}

.btn1.active2 {
   color: white;
   height: 40px;
   border-radius: 7px;
   background-color: #666;
}

.row {
   margin: 10px -16px;
}

/* Add padding BETWEEN each column */
.row, .row>.column {
   padding: 8px;
}

/* Create three equal columns that floats next to each other */
.column {
   float: left;
   width: 25%;
   display: none; /* Hide all elements by default */
}

/* Clear floats after rows */
.row:after {
   content: "";
   display: table;
   clear: both;
}

/* Content */
.content {
   background-color: white;
   padding: 10px;
   overflow: hidden;
}

.content h5 {
   overflow: hidden; /* 넘치는 부분을 잘라냄 */
   text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 부호(...)로 표시 */
   white-space: normal; /* 줄바꿈을 가능하게 함 */
}

/* The "show" class is added to the filtered elements */
.show {
   display: block;
}

.SearchBox {
   display: flex; /* 수평 정렬을 위해 flexbox 사용 */
   align-items: center; /* 수직 가운데 정렬 */
}

.SerchInput {
   border-radius: 7px;
   padding-left: 10px;
   height: 40px;
}

.Searchbtn {
   background-color: #036ffc;
   color: white;
   border-radius: 7px;
   width: 80px;
   height: 40px;
   margin-left: 5px;
}

.Searchbtn:hover {
   background-color: blue;
   color: white;
}

.navigationbar {
   background-color: black;
   height: 50px;
   display: flex; /* 수평 정렬을 위해 flexbox 사용 */
   align-items: center; /* 수직 가운데 정렬 */
   justify-content: space-between; /* 좌우 여백을 균등하게 배치 */
   padding: 5px; /* 좌우 여백 추가 */
}

.content p {
   overflow: hidden; /* 넘치는 부분을 잘라냄 */
   text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 부호(...)로 표시 */
   white-space: normal; /* 줄바꿈을 가능하게 함 */
}
</style>


</head>

<body id="page-top">

   <!-- Page Wrapper -->
   <div id="wrapper">

      <!-- Sidebar -->
      <%@ include file="nav.jsp"%>
      <!-- End of Sidebar -->

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">

         <!-- Main Content -->
         <div id="content">

            <%@ include file="header.jsp"%>

            <!-- Begin Page Content -->
            <div class="container-fluid">

               <h2>공지사항 게시판</h2>

               <nav class="navigationbar">
                  <div id="myBtnContainer">
                     <button class="btn1 active2" onclick="filterSelection('all')">전체</button>
                     <button class="btn1" onclick="filterSelection('nature')">업무</button>
                     <button class="btn1" onclick="filterSelection('cars')">인사</button>
                     <button class="btn1" onclick="filterSelection('people')">이벤트</button>
                  </div>
                  <div class="SearchBox">
                     <input class="SerchInput" type="text" placeholder="Search">
                     <button class="Searchbtn" type="button">Search</button>
                  </div>
               </nav>


               <!-- Portfolio Gallery Grid -->
               <div class="row">
                  <div class="column nature">
                     <div class="content">
                        <img src="img/유연근무제 공지 이미지.jpg" alt="유연근무제" style="width: 100%">
                        <h5>유연근무제 시범실시</h5>
                        <p>3월20일부터 실시되는..</p>
                     </div>
                  </div>
                  <div class="column nature">
                     <div class="content">
                        <img src=" img/프로젝트 팀 모집 공지사항 이미지.jpg" alt="프로젝트 팀"
                           style="width: 100%">
                        <h5>신규 프로젝트 팀 모집안내</h5>
                        <p>이번 분기에 예정인..</p>
                     </div>
                  </div>
                  <div class="column nature">
                     <div class="content">
                        <img src="img/재택근무 공지사항 이미지.jpg" alt="재택근무" style="width: 100%">
                        <h5>재택근무 주의사항 및 안내사항</h5>
                        <p>재택근무 시 근태관리는..</p>
                     </div>
                  </div>

                  <div class="column cars">
                     <div class="content">
                        <img src="img/인사이동 공지 이미지.jpg" alt="인사이동" style="width: 100%">
                        <h5>인사이동 안내</h5>
                        <p>3월19일부터 진행되는..</p>
                     </div>
                  </div>
                  <div class="column cars">
                     <div class="content">
                        <img src="img/인사평가 공지 이미지.jpg" alt="인사평가" style="width: 100%">
                        <h5>인사평가 실시안내</h5>
                        <p>3월25일부터 실시되는..</p>
                     </div>
                  </div>
                  <div class="column cars">
                     <div class="content">
                        <img src="img/인사발령 공지사항 이미지.jpg" alt="인사발령" style="width: 100%">
                        <h5>인사발령안내</h5>
                        <p>전 사원은 본인 해당사항을..</p>
                     </div>
                  </div>

                  <div class="column people">
                     <div class="content">
                        <img src="img/창립기념일 이벤트 공지 이미지.jpg" alt="창립기념일 이벤트"
                           style="width: 100%">
                        <h5>창립기념일 행사안내</h5>
                        <p>3월23일에 개최되는..</p>
                     </div>
                  </div>
                  <div class="column people">
                     <div class="content">
                        <img src="img/복지관련 설문조사 공지사항 이미지.jpg" alt="설문조사"
                           style="width: 100%">
                        <h5>사내 복지관련 설문조사 실시</h5>
                        <p>설문조사에 참가한 분들께는..</p>
                     </div>
                  </div>
                  <div class="column people">
                     <div class="content">
                        <img src="img/홍보이벤트 공지사항 이미지.jpg" alt="회사 홍보 이벤트"
                           style="width: 100%">
                        <h5>회사 홍보 이벤트</h5>
                        <p>본인의 SNS를 이용해서 우리의 회사를 홍보..</p>
                     </div>
                  </div>
                  <!-- END GRID -->
               </div>



               <!-- datatable 템플릿 사용 -->
               <div class="card shadow mb-4">

                  <div class="card-body">
                     <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable" width="100%"
                           cellspacing="0">
                           <thead>
                              <tr>
                                 <th>게시글번호</th>
                                 <th>카테고리</th>
                                 <th>제목</th>
                                 <th>글쓴이</th>
                                 <th>등록일</th>
                              </tr>
                           </thead>
                           <tbody>
                              <c:forEach var="board" items="${boardList}">
                                 <tr>
                                    <td>${board.noticeId}</td>
                                    <td>${board.category}</td>
                                    <td><a href="boardDetailView.boardDo?noticeid=${board.noticeId}">${board.title}</a></td>
                                    <td>관리자</td>
                                    <td>${board.publishdate}</td>
                                 </tr>
                              </c:forEach>
                           </tbody>
                        </table>
                     </div>
                     <!-- 등록 버튼 -->
                     <div class="text-right" style="margin-right: 10px;">
                        <button class="btn btn-primary"
                           onclick="location.href='boardWriteView.jsp'">등록</button>
                     </div>
                  </div>
               </div>


            </div>
            <!-- /.container-fluid -->



         </div>
         <!-- End of Main Content -->

         <!-- Footer -->
         <%@ include file="footer.jsp"%>
         <!-- End of Footer -->

      </div>
      <!-- End of Content Wrapper -->

   </div>
   <!-- End of Page Wrapper -->

   <!-- Scroll to Top Button-->
   <a class="scroll-to-top rounded" href="#page-top"> <i
      class="fas fa-angle-up"></i>
   </a>

   <!-- Logout Modal-->
  <%@ include file="logoutModal.jsp" %>


   <script>
      filterSelection("all")
      function filterSelection(c) {
         var x, i;
         x = document.getElementsByClassName("column");
         if (c == "all")
            c = "";
         for (i = 0; i < x.length; i++) {
            w3RemoveClass(x[i], "show");
            if (x[i].className.indexOf(c) > -1)
               w3AddClass(x[i], "show");
         }
      }

      function w3AddClass(element, name) {
         var i, arr1, arr2;
         arr1 = element.className.split(" ");
         arr2 = name.split(" ");
         for (i = 0; i < arr2.length; i++) {
            if (arr1.indexOf(arr2[i]) == -1) {
               element.className += " " + arr2[i];
            }
         }
      }

      function w3RemoveClass(element, name) {
         var i, arr1, arr2;
         arr1 = element.className.split(" ");
         arr2 = name.split(" ");
         for (i = 0; i < arr2.length; i++) {
            while (arr1.indexOf(arr2[i]) > -1) {
               arr1.splice(arr1.indexOf(arr2[i]), 1);
            }
         }
         element.className = arr1.join(" ");
      }

      // Add active2 class to the current button (highlight it)
      var btnContainer = document.getElementById("myBtnContainer");
      var btns = btnContainer.getElementsByClassName("btn1");
      for (var i = 0; i < btns.length; i++) {
         btns[i].addEventListener("click", function() {
            var current = document.getElementsByClassName("active2");
            current[0].className = current[0].className.replace(" active2",
                  "");
            this.className += " active2";
         });
      }
   </script>


   <!-- Bootstrap core JavaScript-->
   <script src="vendor/jquery/jquery.min.js"></script>
   <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

   <!-- Core plugin JavaScript-->
   <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

   <!-- Custom scripts for all pages-->
   <script src="js/sb-admin-2.min.js"></script>

   <!-- Page level plugins -->
   <script src="vendor/datatables/jquery.dataTables.min.js"></script>
   <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

   <!-- Page level custom scripts -->
   <script src="js/demo/datatables-demo.js"></script>

</body>

</html>
