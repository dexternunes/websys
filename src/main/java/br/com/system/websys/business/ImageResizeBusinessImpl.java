package br.com.system.websys.business;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;

import net.coobird.thumbnailator.Thumbnails;

@Service
public class ImageResizeBusinessImpl implements ImageResizeBusiness {

	public File resize(File image) throws IllegalArgumentException, IOException {
		return resizeImage(image, 250, 250);
	}

	private File resizeImage(File originalImage, int scaledWidth, int scaledHeight) throws IllegalArgumentException, IOException {	
		Thumbnails.of(originalImage).size(255, 255).outputFormat(FilenameUtils.getExtension(originalImage.getName())).toFile(originalImage);		
		return originalImage;
	}
	
}