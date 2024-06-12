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

        // 사용자 -> 웹 서버(react / html css js ) -> was(spring) -> db
        $.ajax({
            url: 'http://localhost:8188',
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