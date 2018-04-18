package com.springapp.mvc.storage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.xml.bind.DatatypeConverter;
import java.io.ByteArrayInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.nio.file.*;
import java.util.Arrays;
import java.util.HashSet;

@Service
public class StorageServiceImpl implements StorageService {

    private final Path rootLocation;

    private static final long IMG_MAX_SIZE = 1024 * 1024 * 2;
    private static final HashSet<String> extensions = new HashSet<>(Arrays.asList("jpg", "jpeg", "png"));

    @Autowired
    public StorageServiceImpl(StorageProperties properties) {
        this.rootLocation = Paths.get(properties.getLocation());
    }

    @Override
    public String saveFile(MultipartFile file, String type) {

        String filename = StringUtils.cleanPath(file.getOriginalFilename());
        String extension = StringUtils.getFilenameExtension(file.getOriginalFilename());

        if (!validateFile(file, extension)) {
            return "";
        }

        try {
            if (file.isEmpty()) {
                throw new StorageException("Failed to store empty file " + filename);
            }
            if (filename.contains("..")) {
                throw new StorageException(
                        "Cannot store file with relative path outside current directory "
                                + filename);
            }

            byte [] byteArr=file.getBytes();
            InputStream inputStream = new ByteArrayInputStream(byteArr);
            String SHA256sum = DatatypeConverter.printHexBinary(Hash.SHA256.checksum(inputStream));

            String folder1 = SHA256sum.substring(0, 2);
            String folder2 = SHA256sum.substring(2, 4);

            String folders = type + "/" + folder1 + "/" + folder2;
            Path foldersPath = this.rootLocation.resolve(folders);
            if (!Files.exists(foldersPath)) {
                Files.createDirectories(foldersPath);
            }

            String filePath = folders + "/" + SHA256sum + "." + extension;
            Path fileResultPath = this.rootLocation.resolve(filePath);

            if (!Files.exists(fileResultPath)) {

                Files.copy(file.getInputStream(), fileResultPath,
                        StandardCopyOption.REPLACE_EXISTING);
            }

            return filePath;
        }
        catch (IOException e) {
            throw new StorageException("Failed to store file " + filename, e);
        }
    }

    @Override
    public String saveFromUrl(String source, String type) {

        String extension = source.substring(source.lastIndexOf("."));

        if ( !validateFileFromUrl(source, extension.replace(".", "") )) {
            return "";
        }

        try {

            String SHA256sum = "";

            try (InputStream inputStream = new URL(source).openStream()) {
                SHA256sum = DatatypeConverter.printHexBinary(Hash.SHA256.checksum(inputStream));
            }

            if (SHA256sum.equals("")) {
                return "";
            }

            String folder1 = SHA256sum.substring(0, 2);
            String folder2 = SHA256sum.substring(2, 4);

            String folders = type + "/" + folder1 + "/" + folder2;
            Path foldersPath = this.rootLocation.resolve(folders);
            if (!Files.exists(foldersPath)) {
                Files.createDirectories(foldersPath);
            }

            String filePath = folders + "/" + SHA256sum + extension;
            Path fileResultPath = this.rootLocation.resolve(filePath);

            if (!Files.exists(fileResultPath)) {

                URL website = new URL(source);
                ReadableByteChannel rbc = Channels.newChannel(website.openStream());
                FileOutputStream fos = new FileOutputStream(fileResultPath.toString());
                fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);

                fos.close();
                rbc.close();
            }

            return filePath;
        }
        catch (IOException e) {
            throw new StorageException("Failed to store file from URL " + source, e);
        }

    }

    @Override
    public void init() {
        try {
            Files.createDirectories(rootLocation);
        }
        catch (IOException e) {
            throw new StorageException("Could not initialize storage", e);
        }
    }

    private boolean validateFile(MultipartFile file, String extension) {
        return extensions.contains(extension) && (file.getSize() <= IMG_MAX_SIZE);
    }

    private boolean validateFileFromUrl(String source, String extension) {
        return extensions.contains(extension) && (sizeFromLink(source) <= IMG_MAX_SIZE);
    }

    private long sizeFromLink(String source) {
        try {
            URL url = new URL(source);

            URLConnection conn = null;
            try {
                conn = url.openConnection();
                if(conn instanceof HttpURLConnection) {
                    ((HttpURLConnection)conn).setRequestMethod("HEAD");
                }
                conn.getInputStream();
                return conn.getContentLength();
            } catch (IOException e) {
                throw new RuntimeException(e);
            } finally {
                if(conn instanceof HttpURLConnection) {
                    ((HttpURLConnection)conn).disconnect();
                }
            }

        } catch (MalformedURLException e) {
            System.out.println(e.getMessage());
        }

        return Long.MAX_VALUE;
    }
}
