package br.com.system.websys.business;

import java.io.File;
import java.io.IOException;

public interface ImageResizeBusiness {

	File resize(File image) throws IOException;

}