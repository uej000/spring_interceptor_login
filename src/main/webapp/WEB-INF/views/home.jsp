<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="com.cmsoft.cm_ocr.CmOcrApplication" %>

<!DOCTYPE html>
<html lang="kr">
<head>
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <title>image_ocr</title>
    <link rel="stylesheet" href="../../css/style.css"/>
</head>
<body>
<div class="container">
    <div class = "title_tag">
        <h1>IMAGE OCR</h1>
        <p class="P_tag" data-id="4">
        Extract text from your documents with ease.
        </p>
    </div>
    <div class="content">
        <label id = label_btn for="imageFile">Upload Image</label>
        <input type="file" id="imageFile" name="imageFile" onchange="previewImage()" multiple>
        <div id="imagePreview"></div> <!-- 이미지 미리보기를 표시할 영역 -->
        <div class="result">OCR Result</div>
        <hr style="border: 1px">
        <div id="resultOCR"></div>
    </div>
</div>
    <script>
        function previewImage() {

            var input = document.getElementById('imageFile');
            var reader = new FileReader();
            reader.onload = function(){
                var img = document.createElement("img");
                img.src = reader.result;
                // img.style.maxWidth = "100%"; // 이미지 최대 너비 설정
                var preview = document.getElementById("imagePreview");
                preview.innerHTML = ""; // 이미지 미리보기 영역 초기화
                preview.appendChild(img); // 이미지 미리보기 추가

                var formData = new FormData();

                var fileInput = document.querySelector("#imageFile");

                let files = fileInput.files;
                formData.append("file", files[0]);

                $.ajax({
                    url: '/',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    // dataType: 'json',
                    timeout: 10000,
                    success: function(data) {
                        console.log(data);
                        $('#resultOCR').text(data); // OCR 결과를 textarea에 표시
                    },
                    error: function(xhr, status, error) {
                        console.log(xhr);
                        alert('오류가 발생했습니다.');
                    },
                });
            };
            if(input.files[0])
            reader.readAsDataURL(input.files[0]); // 파일을 읽어 데이터 URL로 변환
        }
    </script>
</body>
</html>