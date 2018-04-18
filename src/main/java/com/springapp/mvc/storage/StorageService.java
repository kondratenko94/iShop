package com.springapp.mvc.storage;

import org.springframework.web.multipart.MultipartFile;

public interface StorageService {
    String saveFile(MultipartFile file, String type);
    String saveFromUrl(String source, String type);
    void init();
}
