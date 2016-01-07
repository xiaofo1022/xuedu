package com.xiaofo1022.xuedu.test;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class IOTest {

	private static final String PIC_URL = "http://orange9.cn/images/show/enu/19/7.jpg";
	
	public void nio2Test() {
		try {
			byte[] inputBytes = readNetBytes();
			if (inputBytes != null) {
				Path targetPath = Paths.get("C:\\Users\\kurt.yu\\Downloads\\orange9_nio2_download.jpg");
				if (!Files.exists(targetPath)) {
					Files.createFile(targetPath);
				}
				Files.write(targetPath, inputBytes);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public byte[] readNetBytes() {
		try (InputStream inputStream = getNetInputStream();
			ByteArrayOutputStream byteOutput = new ByteArrayOutputStream();) {
			byte[] buffer = new byte[1024];
			int readBytes = 0;
			while ((readBytes = inputStream.read(buffer)) != -1) {
				byteOutput.write(buffer, 0, readBytes);
			}
			return byteOutput.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public InputStream getNetInputStream() {
		try {
			URL picUrl = new URL(PIC_URL);
			HttpURLConnection connection = (HttpURLConnection)picUrl.openConnection();
			if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
				InputStream inputStream = connection.getInputStream();
				return inputStream;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static void main(String[] args) {
		IOTest ioTest = new IOTest();
		ioTest.nio2Test();
	}
}
