/**
 * Copyright (c) 2000-2005 Liferay, LLC. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

package com.liferay.portal.service.impl;

import com.liferay.portal.NoSuchImageException;
import com.liferay.portal.PortalException;
import com.liferay.portal.SystemException;
import com.liferay.portal.model.Image;
import com.liferay.portal.service.persistence.ImageFinder;
import com.liferay.portal.service.persistence.ImageUtil;
import com.liferay.portal.service.spring.ImageService;

import java.util.Date;
import java.util.List;

/**
 * <a href="ImageServiceImpl.java.html"><b><i>View Source</i></b></a>
 *
 * @author  Brian Wing Shun Chan
 * @version $Revision: 1.3 $
 *
 */
public class ImageServiceImpl extends PrincipalBean implements ImageService {

	// Business methods

	public void deleteImage(String imageId)
		throws PortalException, SystemException {

		ImageUtil.remove(imageId);
	}

	public Image getImage(String imageId)
		throws PortalException, SystemException {

		/*Image image = null;

		try {
			image = ImageUtil.findByPrimaryKey(imageId);
		}
		catch (NoSuchImageException nsie) {
			image = ImageUtil.create(imageId);

			image.setModifiedDate(new Date());
			image.setTextObj(ImageLocalUtil.getDefaultBytes());

			ImageUtil.update(image);
		}

		return image;*/

		return ImageUtil.findByPrimaryKey(imageId);
	}

	public List getImageById(String imageId) throws SystemException {
		return ImageFinder.findByImageId(imageId);
	}

	public Image updateImage(String imageId, byte[] bytes)
		throws SystemException {

		Image image = null;

		try {
			image = ImageUtil.findByPrimaryKey(imageId);
		}
		catch (NoSuchImageException nsie) {
			image = ImageUtil.create(imageId);

			image.setTextObj(ImageLocalUtil.getDefaultBytes());

			ImageUtil.update(image);
		}

		image.setModifiedDate(new Date());
		image.setTextObj(bytes);

		ImageUtil.update(image);

		return image;
	}

}