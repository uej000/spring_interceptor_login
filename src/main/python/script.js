const fileInput = document.getElementById('fileInput');
const scanButton = document.getElementById('scanButton');
const result = document.getElementById('result');

scanButton.addEventListener('click', () => {
    const file = fileInput.files[0];
    if (!file) {
        alert('파일을 선택하세요.');
        return;
    }

    const reader = new FileReader();
    reader.onload = (event) => {
        const data = event.target.result;
        Tesseract.recognize(data, 'kor', {
            logger: (m) => console.log(m),
        }).then((result) => {
            const text = result.text;
            result.html.forEach((line) => {
                const p = document.createElement('p');
                p.textContent = line;
                result.appendChild(p);
            });
        });
    };
    reader.readAsDataURL(file);
});
