package com.cmsoft.ocr_cm;

import lombok.extern.slf4j.Slf4j;
import net.sourceforge.tess4j.ITesseract;
import net.sourceforge.tess4j.Tesseract;
import net.sourceforge.tess4j.TesseractException;
import org.python.util.PythonInterpreter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;


@Slf4j
@SpringBootApplication
@Controller
@RequestMapping("/")
public class OcrcmApplication {

    public static void main(String[] args) {
        SpringApplication.run(OcrcmApplication.class, args);
    }

    private static PythonInterpreter intPre;

    @GetMapping("/")
    public String home() {
        return "home";
    }


    @PostMapping("/")
    @ResponseBody
    public String handleFileUpload(MultipartFile file) {
        try {
            // 임시 파일로 이미지 저장
            File file1 = new File(file.getOriginalFilename());
            file1.createNewFile();
            FileOutputStream fos = new FileOutputStream(file1);
            fos.write(file.getBytes());
            fos.close();

            System.out.println(file1.exists());

            // OCR 실행
            ITesseract instance = new Tesseract();
            instance.setDatapath("C:\\Program Files\\Tesseract-OCR\\tessdata");
            instance.setLanguage("kor");
            String extractedText = instance.doOCR(file1);
            extractedText = extractedText.replaceAll(" ", "");
            System.out.println("extractedText = " + extractedText);

            // 추출된 텍스트를 모델에 추가하여 jsp로 전달
            return extractedText; // 결과를 보여줄 jsp 페이지의 이름을 반환

        } catch (IOException | TesseractException e) {
            e.printStackTrace();
            return ""; // 오류가 발생했을 경우 보여줄 jsp 페이지의 이름을 반환
        }
    }
}
